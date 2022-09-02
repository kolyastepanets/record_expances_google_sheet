class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  SHOW_ITEMS_PER_LINE = 2
  SHOW_TRAVEL_SUB_CATEGORIES_PER_LINE = 1

  def start!(*)
    if from["username"] == "nikolay_stepanets" || from["username"] == "liliya_stepanets"
      respond_with(:message, text: 'Выбери действие:', reply_markup: {
        inline_keyboard: [
          [{ text: 'UAH на gsheets', callback_data: 'get_current_mono_balance_from_google_sheet' }],
          [{ text: 'UAH на monobank', callback_data: 'get_current_mono_balance_from_monobank' }],
          [{ text: 'USD FOP на gsheets', callback_data: 'get_usd_fop_from_google_sheet' }],
          [{ text: 'USD FOP на monobank', callback_data: 'get_usd_fop_from_monobank' }],
          [{ text: 'Total saved money on gsheets', callback_data: 'total_saved_money_from_google_sheet' }],
          [{ text: 'Последние 3 траты в gsheets', callback_data: 'get_last_3_expenses_in_google_sheet' }],
          [{ text: 'Последние 10 транзакций в моно', callback_data: 'get_last_10_transactions_from_mono' }],
          [{ text: 'Продал валюту c ФОПа', callback_data: 'sold_dollars_from_fop' }],
          [{ text: 'Внести расходы',  callback_data: 'enter_expenses' }],
          [{ text: 'Главное меню',  callback_data: 'start_again' }],
        ],
      })
    else
      respond_with(:message, text: 'You are not authorized')
    end
  end

  def callback_query(data)
    case data
    when 'start_again'
      set_default_values_in_session!

      start!

    when 'get_current_mono_balance_from_google_sheet'
      get_current_mono_balance_from_google_sheet
    when 'get_current_mono_balance_from_monobank'
      get_current_mono_balance_from_monobank
    when 'get_usd_fop_from_google_sheet'
      get_usd_fop_from_google_sheet
    when 'get_usd_fop_from_monobank'
      get_usd_fop_from_monobank
    when 'total_saved_money_from_google_sheet'
      total_saved_money_from_google_sheet
    when 'get_last_3_expenses_in_google_sheet'
      get_last_3_expenses_in_google_sheet
    when 'get_last_10_transactions_from_mono'
      get_last_10_transactions_from_mono
    when 'sold_dollars_from_fop'
      sold_dollars_from_fop
    when 'enter_expenses'
      ask_type_of_expenses
    when 'metro_expenses'
      session[:is_metro] = true
      start_remember_total_price_of_products
      show_categories_to_choose
    when 'common_expenses'
      session[:is_grivnas] = true
      start_remember_total_price_of_products
      show_categories_to_choose
    when 'receipt_foreign_currency'
      session[:is_grivnas] = true
      ask_to_enter_current_exchange_rate
    when 'cash_foreign_currency'
      ask_to_enter_left_foreign_cash
    when 'dollar_card'
      ask_to_enter_dollar_foreign_currency_exchange_rate
    when -> (input_category) { input_category.include?('only_category') }
      category_name = data.split(': ')[0]
      show_sub_categories_by_category(category_name)
    when *sub_categories
      ask_for_price(data)
    when 'categor_without_subcategor'
      ask_for_price(nil)
    when 'finish_remember_total_price_of_products'
      finish_remember_total_price_of_products
    when -> (input_data) { input_data.include?('remove_messages') }
      remove_messages(data)
    when -> (input_category) { input_category.include?('c_id') }
      category_name = data.split(': ')[0]
      transaction_id = data.split(': ')[1].split('c_id:')[1]
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:category_name] = category_name
      params[:message_ids] << payload["message"]["message_id"]
      redis.set(transaction_id, params.to_json, ex: 2.weeks)

      show_sub_categories_by_category(category_name, transaction_id)
    when -> (input_sub_category) { input_sub_category.include?('s_id') }
      sub_category_name = find_full_sub_category_name(data.split(': ')[0])
      transaction_id = data.split(': ')[1].split('s_id:')[1]
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:message_ids] << payload["message"]["message_id"]
      params[:sub_category_name] = sub_category_name

      PutExpencesUahBlackCardJob.perform_later(params) if params[:price_in_uah]
      PutExpencesFopDollarCardJob.perform_later(params) if params[:price_in_usd]
      DeleteMessagesJob.perform_later(params[:message_ids].uniq)
    else
      # return help
    end
  rescue StandardError => e
    respond_with(:message, text: "Что то пошло не так: #{e.message}")
  end

  def save_data_to_google_sheet!(price, *args)
    price_to_put_in_sheets, price_to_calculate = BuildPrice.call(price, session)

    if !session[:receipt_dollar_foreign_currency_exchange_rate].nil?
      currency_uah_to_usd = price_to_put_in_sheets.split(" ")[-1].gsub(",", ".").to_f
      price_in_uah = price.to_f / session[:receipt_dollar_foreign_currency_exchange_rate].to_f * currency_uah_to_usd
      price_in_usd = price_to_calculate

      DecreaseUsdSavedAmount.call(price_in_usd)
    end

    if session[:is_grivnas]
      DecreaseUahSavedAmount.call(price_to_calculate)
    end

    sub_category_name = session[:last_chosen_sub_category]
    category_name = session[:last_chosen_category]
    PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, current_month: detect_month)
    remember_total_price_of_products(price_to_calculate)
    remember_total_price_of_products_in_foreign_currency(price.to_f)

    respond_with(:message, text: "Текущая общая стоимость продуктов в чеке: #{session[:total_price_of_products]}")
    respond_with(:message, text: "Текущая общая стоимость продуктов в чеке (валюта): #{session[:total_price_of_products_in_foreign_currency]}") unless session[:total_price_of_products_in_foreign_currency].zero?
    if !session[:foreigh_cash_amount].zero?
      money_left_to_enter = session[:total_withraw_foreign_money] - session[:foreigh_cash_amount] - session[:total_price_of_products] - session[:foreigh_spent_cash_amount]
      respond_with(:message, text: "Осталось внести: #{money_left_to_enter}")
    end

    save_category_to_session!(nil)
    save_sub_category_to_session!(nil)
    respond_with(:message, text: 'Данные внесены')
    show_categories_to_choose
  rescue StandardError => e
    error_message = "Упс, что-то пошло не так, категория: #{category_name}, подкатегория: #{sub_category_name}, ошибка: #{e.message}"
    respond_with(:message, text: error_message)
  end

  def ask_to_enter_dollar_foreign_currency_exchange_rate
    save_context(:save_dollar_foreign_currency_exchange_rate!)
    respond_with(:message, text: 'Внеси текущий курс доллар/валюта:')
  end

  def save_dollar_foreign_currency_exchange_rate!(exchange_rate, *args)
    session[:receipt_dollar_foreign_currency_exchange_rate] = exchange_rate.to_f
    session[:total_price_of_products_in_foreign_currency] = 0
    start_remember_total_price_of_products
    show_categories_to_choose
  end

  def enter_sold_dollars_and_grivnas!(dollars, *args)
    dollars = dollars.to_f
    grivnas = args[0].to_f

    result = CalculateTotalSpentUsdAndUah.call

    # increase uah amount
    UpdateCommonCurrencyExpenses.call(
      result[:total_left_uah_money] + grivnas,
      result[:coordinates_of_total_left_uah_money],
    )

    # decrease usd amount
    UpdateCommonCurrencyExpenses.call(
      result[:total_left_usd_money] - dollars,
      result[:coordinates_of_total_left_usd_money],
    )

    respond_with(:message, text: 'Данные внесены!')
  end

  def save_left_foreign_cash!(foreigh_cash_amount, *args)
    session[:foreigh_cash_amount] = foreigh_cash_amount.to_f
    result = CalculateForeignCurrencyCashExpenses.call
    session[:foreigh_spent_cash_amount] = result[:spent_foreign_money]
    session[:total_withraw_foreign_money] = result[:total_withraw_foreign_money]
    start_remember_total_price_of_products
    show_categories_to_choose
  end

  def save_current_exchange_rate!(exchange_rate, *args)
    session[:receipt_foreign_currency_exchange_rate] = exchange_rate.to_f
    session[:total_price_of_products_in_foreign_currency] = 0
    start_remember_total_price_of_products
    show_categories_to_choose
  end

  private

  def get_usd_fop_from_google_sheet
    respond_with(:message, text: ReceiveUsdFopFromGoogleSheet.call)
  end

  def get_usd_fop_from_monobank
    respond_with(:message, text: ReceiveUsdFopFromMonobank.call)
  end

  def total_saved_money_from_google_sheet
    respond_with(:message, text: ReceiveTotalSavedMoneyFromGoogleSheet.call)
  end

  def get_last_3_expenses_in_google_sheet
    respond_with(:message, text: GetLastThreeExpensesInGoogleSheet.call)
  end

  def get_last_10_transactions_from_mono
    respond_with(:message, text: GetLastTenTransactionsFromMonobank.call)
  end

  def sold_dollars_from_fop
    save_context(:enter_sold_dollars_and_grivnas!)
    respond_with(:message, text: 'Внеси сколько долларов пробел сколько гривен:')
    respond_with(:message, text: 'Например: 500 14770')
  end

  def ask_type_of_expenses
    respond_with(
      :message,
      text: 'как заполнять?',
      reply_markup: {
        inline_keyboard: [
          [{ text: 'Покупки с метро', callback_data: 'metro_expenses' }],
          [{ text: 'Обычные покупки', callback_data: 'common_expenses' }],
          [{ text: 'Чек иностранная валюта',  callback_data: 'receipt_foreign_currency' }],
          [{ text: 'Наличка иностранная валюта',  callback_data: 'cash_foreign_currency' }],
          [{ text: 'Долларовая карта',  callback_data: 'dollar_card' }],
        ],
      }
    )
  end

  def start_remember_total_price_of_products
    session[:total_price_of_products] = 0
    show_total_price_of_products
  end

  def finish_remember_total_price_of_products
    show_total_price_of_products
    if !session[:foreigh_cash_amount].zero?
      result = CalculateForeignCurrencyCashExpenses.call
      UpdateCommonCurrencyExpenses.call(
        result[:spent_foreign_money] + session[:total_price_of_products],
        result[:coordinates_of_value_to_change_spent_foreign_money],
      )
      UpdateCommonCurrencyExpenses.call(
        session[:foreigh_cash_amount],
        result[:coordinates_of_value_to_change_now_foreign_money],
      )
    end

    set_default_values_in_session!
    ask_type_of_expenses
  end

  def show_total_price_of_products
    respond_with(:message, text: "Общая цена продуктов: #{session[:total_price_of_products]}")
    respond_with(:message, text: "Общая цена продуктов в валюте: #{session[:total_price_of_products_in_foreign_currency]}") unless session[:total_price_of_products_in_foreign_currency].zero?
  end

  def remember_total_price_of_products(price)
    session[:total_price_of_products] += price
  end

  def remember_total_price_of_products_in_foreign_currency(price)
    session[:total_price_of_products_in_foreign_currency] += price
  end

  def show_categories_to_choose
    prepare_categories = categories.each_slice(SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}: only_category" }
      end
    end

    finish_remember_total_price_of_products = [
      {
        text: "Зак..ть внесение продуктов. Н.ть заново",
        callback_data: "finish_remember_total_price_of_products"
      }
    ]
    start_again = [
      {
        text: "Главное меню",
        callback_data: "start_again"
      }
    ]

    prepare_categories.push(finish_remember_total_price_of_products)
    prepare_categories.push(start_again)

    respond_with(:message, text: 'Выбери категорию:', reply_markup: { inline_keyboard: prepare_categories })
  end


  def get_current_mono_balance_from_google_sheet
    respond_with(:message, text: ReceiveCurrentBalanceInMonobankFromGoogleSheet.call)
  end

  def get_current_mono_balance_from_monobank
    respond_with(:message, text: ReceiveCurrentBalanceInMonobankFromMono.call)
  end

  def category_to_sub_categories
    @category_to_sub_categories ||= ReceiveCategories.call
  end

  def categories
    category_to_sub_categories.keys
  end

  def sub_categories
    category_to_sub_categories.values.flatten
  end

  def ask_for_price(sub_category)
    save_sub_category_to_session!(sub_category)
    respond_with(:message, text: "Выбранная подкатегория: #{sub_category}")
    save_context(:save_data_to_google_sheet!)
    respond_with(:message, text: 'Внеси цену товара:')
  end

  def show_sub_categories_by_category(category_name, transaction_id = nil)
    save_category_to_session!(category_name)
    show_per_line = category_name == 'Путешествия' ? SHOW_TRAVEL_SUB_CATEGORIES_PER_LINE : SHOW_ITEMS_PER_LINE

    prepare_sub_categories = category_to_sub_categories[category_name].each_slice(show_per_line)
                                                                      .map do |sub_categories_array|
      sub_categories_array.map do |sub_category|
        if transaction_id.present?
          sub_category = sub_category.first(20) + "_" if sub_category.size > 20

          next { text: sub_category, callback_data: "#{sub_category}: s_id:#{transaction_id}" }
        end

        { text: sub_category, callback_data: sub_category }
      end
    end

    category_without_subcategory = [
      {
        text: "Без подкатегории",
        callback_data: "categor_without_subcategor"
      }
    ]
    prepare_sub_categories.push(category_without_subcategory)

    respond_with(:message, text: 'Выбери подкатегорию:', reply_markup: { inline_keyboard: prepare_sub_categories })
  end

  def find_full_sub_category_name(sub_category_name)
    return sub_category_name if !sub_category_name.end_with?("_")

    short_sub_category_name = sub_category_name.delete("_")
    full_sub_category_name = ""

    sub_categories.each do |sub_category|
      if sub_category.include?(short_sub_category_name)
        full_sub_category_name = sub_category
        break
      end
    end
    full_sub_category_name
  end

  def save_category_to_session!(category_name)
    session[:last_chosen_category] = category_name
  end

  def save_sub_category_to_session!(sub_category_name)
    session[:last_chosen_sub_category] = sub_category_name
  end

  def detect_month
    if !session[:foreigh_cash_amount].zero?
      "#{Date.today.month},1"
    end
  end

  def ask_to_enter_current_exchange_rate
    save_context(:save_current_exchange_rate!)
    respond_with(:message, text: 'Внеси текущий курс гривна/валюта:')
  end

  def ask_to_enter_left_foreign_cash
    save_context(:save_left_foreign_cash!)
    respond_with(:message, text: 'Внеси сколько осталось налички:')
  end

  def set_default_values_in_session!
    session[:is_grivnas] = nil
    session[:last_chosen_category] = nil
    session[:last_chosen_sub_category] = nil
    session[:receipt_dollar_foreign_currency_exchange_rate] = nil
    session[:date_when_purchase_was_made] = 0
    session[:total_price_of_products] = 0
    session[:is_metro] = false
    session[:receipt_foreign_currency_exchange_rate] = nil
    session[:foreigh_cash_amount] = 0
    session[:foreigh_spent_cash_amount] = 0
    session[:total_withraw_foreign_money] = 0
    session[:total_price_of_products_in_foreign_currency] = 0
  end

  def redis
    @redis ||= Redis.new
  end

  def remove_messages(data)
    transaction_id = data.split(': ')[1]
    params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
    DeleteMessagesJob.perform_later(params[:message_ids].uniq)
  end
end
