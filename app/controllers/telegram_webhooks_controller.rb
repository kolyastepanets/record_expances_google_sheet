class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  SHOW_ITEMS_PER_LINE = 2
  SHOW_TRAVEL_SUB_CATEGORIES_PER_LINE = 1

  def start!(*)
    set_default_values_in_session!

    if from["username"] == ENV['MY_USER_NAME']
      respond_with(:message, text: 'Выбери действие:', reply_markup: {
        inline_keyboard: [
          [{ text: 'UAH на gsheets', callback_data: 'get_current_mono_balance_from_google_sheet' }],
          [{ text: 'UAH на monobank', callback_data: 'get_current_mono_balance_from_monobank' }],
          [{ text: 'USD FOP на gsheets', callback_data: 'get_usd_fop_from_google_sheet' }],
          [{ text: 'USD FOP на monobank', callback_data: 'get_usd_fop_from_monobank' }],
          [{ text: 'USD on Wise', callback_data: 'get_usd_from_wise' }],
          [{ text: 'Уже потрачено', callback_data: 'amount_already_spent' }],
          [{ text: 'How many taxes to pay in current month', callback_data: 'how_many_taxes_to_pay_in_current_month' }],
          [{ text: 'Total saved money on gsheets', callback_data: 'total_saved_money_from_google_sheet' }],
          [{ text: 'Последние 3 траты в gsheets', callback_data: 'get_last_3_expenses_in_google_sheet' }],
          [{ text: 'Последние 10 транзакций в моно', callback_data: 'get_last_10_transactions_from_mono' }],
          [{ text: 'Удалить все текущие сообщения',  callback_data: 'delete_all_todays_messages' }],
          [{ text: 'Кто кому сколько должен',  callback_data: 'expenses_to_return_from_vika' }],
          [{ text: 'Info current month',  callback_data: 'info_current_month' }],
          [{ text: 'Enter wise salary',  callback_data: 'enter_wise_salary' }],
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
    when 'get_usd_from_wise'
      get_usd_from_wise
    when 'amount_already_spent'
      amount_already_spent
    when 'how_many_taxes_to_pay_in_current_month'
      how_many_taxes_to_pay_in_current_month
    when 'total_saved_money_from_google_sheet'
      total_saved_money_from_google_sheet
    when 'get_last_3_expenses_in_google_sheet'
      get_last_3_expenses_in_google_sheet
    when 'get_last_10_transactions_from_mono'
      get_last_10_transactions_from_mono
    when 'delete_all_todays_messages'
      delete_all_todays_messages
    when 'expenses_to_return_from_vika'
      expenses_to_return_from_vika
    when 'info_current_month'
      info_current_month
    when 'enter_wise_salary'
      ask_to_enter_wise_salary
    when 'calculate_as_mykola_paid_half_expenses'
      redis.set('how_calculate_expenses_between_us', 'calculate_as_mykola_paid_half_expenses')
      ask_type_of_expenses
    when 'calculate_as_vika_paid_half_expenses'
      redis.set('how_calculate_expenses_between_us', 'calculate_as_vika_paid_half_expenses')
      ask_type_of_expenses
    when 'calculate_as_our_full_expenses'
      redis.set('how_calculate_expenses_between_us', 'calculate_as_our_full_expenses')
      ask_type_of_expenses
    when 'enter_expenses'
      set_default_values_in_session!
      ask_half_price_or_full_price
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
    when 'wise'
      session[:is_wise] = true
      start_remember_total_price_of_products
      show_categories_to_choose
    when 'wise_lend_money'
      ask_to_enter_wise_amount_to_lend_money
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
      redis.set(transaction_id, params.to_json, ex: 1.week)

      transaction_id = "c1_id:#{transaction_id}"
      show_sub_categories_by_category(category_name, transaction_id)
    when -> (input_sub_category) { input_sub_category.include?('c1_id') }
      sub_category_name = find_full_sub_category_name(data.split(': ')[0])
      transaction_id = data.split(': ')[1].split('c1_id:')[1]
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:message_ids] << payload["message"]["message_id"]
      params[:sub_category_name] = sub_category_name

      PutExpencesUahBlackCardJob.perform_later(params) if params[:price_in_uah]
      PutExpencesFopDollarCardJob.perform_later(params) if params[:price_in_usd]
      DeleteMessagesJob.perform_later(params[:message_ids].uniq)
    when -> (input_category) { input_category.include?('h_id') }
      category_name = data.split(': ')[0]
      transaction_id = data.split(': ')[1].split('h_id:')[1]
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:category_name] = category_name
      params[:message_ids] << payload["message"]["message_id"]
      redis.set(transaction_id, params.to_json, ex: 1.week)
      redis.set('how_calculate_expenses_between_us', 'calculate_as_mykola_paid_half_expenses')

      transaction_id = "c1_id:#{transaction_id}"
      show_sub_categories_by_category(category_name, transaction_id)
    when -> (input_category) { input_category.include?('f_id') }
      category_name = data.split(': ')[0]
      transaction_id, price = data.split(': ')[1].split('f_id:')[1].split(":")
      params = JSON.parse(redis.get(transaction_id))
      last_price_to_message = params.select { |pri| pri["price"] == price.to_f }[-1]
      last_price_to_message["message_ids"] << payload["message"]["message_id"]
      last_price_to_message["category_name"] = category_name

      redis.set(transaction_id, params.to_json, ex: 1.week)

      transaction_id = "f1_id:#{transaction_id}:#{price}"
      show_sub_categories_by_category(category_name, transaction_id)
    when -> (input_sub_category) { input_sub_category.include?('f1_id') }
      params_to_save_to_google_sheet, new_params_for_redis, messages_to_delete = PrepareParamsAfterEnterSubcategoryBeforeSave.call(data)

      PutExpencesFopDollarCardJob.perform_later(params_to_save_to_google_sheet) if params_to_save_to_google_sheet[:price_in_usd]
      PutExpencesUahBlackCardJob.perform_later(params_to_save_to_google_sheet) if params_to_save_to_google_sheet[:price_in_uah]
      DeleteMessagesJob.perform_later((messages_to_delete + [payload["message"]["message_id"]]).uniq)
    else
      # return help
    end

  rescue StandardError => e
    if Rails.env.production?
      respond_with(:message, text: "Что то пошло не так: #{e.message}")
    else
      raise e
    end
  end

  def save_data_to_google_sheet!(price, *args)
    price_to_put_in_sheets, price_to_calculate = BuildPrice.call(price, session)

    if !session[:receipt_dollar_foreign_currency_exchange_rate].nil? && redis.get('how_calculate_expenses_between_us') != 'calculate_as_vika_paid_half_expenses'
      currency_uah_to_usd = price_to_put_in_sheets.split(" ")[-1].gsub(",", ".").to_f
      price_in_uah = price.to_f / session[:receipt_dollar_foreign_currency_exchange_rate].to_f * currency_uah_to_usd
      price_in_usd = price_to_calculate

      DecreaseUsdSavedAmountJob.perform_later({ price_in_usd: price_in_usd })
    end

    if session[:is_grivnas] && redis.get('how_calculate_expenses_between_us') != 'calculate_as_vika_paid_half_expenses'
      DecreaseUahSavedAmountJob.perform_later({ price_in_uah: price_to_calculate })
    end

    if session[:is_metro]
      DecreaseUahSavedAmountJob.perform_later({ price_in_uah: price_to_calculate })
    end

    if session[:is_wise]
      DecreaseWiseUsdSavedAmountJob.perform_later(price_to_calculate)
    end

    sub_category_name = session[:last_chosen_sub_category]
    category_name = session[:last_chosen_category]
    who_paid = case redis.get('how_calculate_expenses_between_us')
               when 'calculate_as_mykola_paid_half_expenses'
                 AllConstants::MYKOLA_PAYED
               when 'calculate_as_vika_paid_half_expenses'
                 AllConstants::VIKA_PAYED
               else
                 nil
               end
    PutExpensesToGoogleSheetJob.perform_later(category_name, sub_category_name, price_to_put_in_sheets, detect_month, who_paid)

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
    if Rails.env.production?
      error_message = "Упс, что-то пошло не так, категория: #{category_name}, подкатегория: #{sub_category_name}, ошибка: #{e.message}"
      respond_with(:message, text: error_message)
    else
      raise e
    end
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

  def save_left_foreign_cash!(foreigh_cash_amount, *args)
    session[:foreigh_cash_amount] = SumEnteredAmount.call(foreigh_cash_amount)
    result = CalculateForeignCurrencyCashExpenses.call
    session[:foreigh_spent_cash_amount] = result[:spent_foreign_money]
    session[:total_withraw_foreign_money] = result[:total_withraw_foreign_money]
    money_left_to_enter = session[:total_withraw_foreign_money] - session[:foreigh_cash_amount] - session[:foreigh_spent_cash_amount]
    respond_with(:message, text: "Внесенная сумма налички: #{session[:foreigh_cash_amount]}")
    respond_with(:message, text: "Осталось внести: #{money_left_to_enter}")
    start_remember_total_price_of_products
    show_categories_to_choose
  end

  def save_current_exchange_rate!(exchange_rate, *args)
    session[:receipt_foreign_currency_exchange_rate] = exchange_rate.to_f
    session[:total_price_of_products_in_foreign_currency] = 0
    start_remember_total_price_of_products
    show_categories_to_choose
  end

  def message(message)
    return respond_with(:message, text: 'invalid message') if message["photo"].blank? && message["document"].blank?

    HandleInputPhotoJob.perform_later(message)
    respond_with(:message, text: 'Началась обработка фото...')
  end

  def ask_to_enter_wise_salary
    save_context(:save_wise_salary!)
    respond_with(:message, text: 'Enter wise salary:')
  end

  def save_wise_salary!(wise_salary, *args)
    IncreaseWiseUsdSavedAmountJob.perform_later(wise_salary)
    respond_with(:message, text: 'Wise salary has been saved')
  end

  def ask_to_enter_wise_amount_to_lend_money
    save_context(:save_wise_lend_money!)
    respond_with(:message, text: 'Enter how much to lend:')
  end

  def save_wise_lend_money!(wise_lend_money, *args)
    DecreaseWiseUsdSavedAmountJob.perform_later(wise_lend_money)
    respond_with(:message, text: 'Entered amount has been withdrawn')
  end

  private

  def get_usd_fop_from_google_sheet
    respond_with(:message, text: ReceiveUsdFopFromGoogleSheet.call)
  end

  def get_usd_fop_from_monobank
    respond_with(:message, text: ReceiveUsdFopFromMonobank.call)
  end

  def get_usd_from_wise
    total_sum = TakeWiseSavedAmount.call(value_render_option: 'UNFORMATTED_VALUE')[:wise_formula]
    respond_with(:message, text: "on wise: $#{total_sum}")
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

  def ask_half_price_or_full_price
    respond_with(
      :message,
      text: 'как считать расходы?',
      reply_markup: {
        inline_keyboard: [
          [{ text: 'Все расходы наши', callback_data: 'calculate_as_our_full_expenses' }],
          [{ text: 'Микола заплатил (половина)', callback_data: 'calculate_as_mykola_paid_half_expenses' }],
          [{ text: 'Вика заплатила (половина)', callback_data: 'calculate_as_vika_paid_half_expenses' }],
        ],
      }
    )
  end

  def ask_type_of_expenses
    wise_expenses = {}
    wise_lend_money = {}
    if redis.get('how_calculate_expenses_between_us') == 'calculate_as_our_full_expenses'
      wise_expenses = { text: 'Wise',  callback_data: 'wise' }
      wise_lend_money = { text: 'Wise lend money',  callback_data: 'wise_lend_money' }
    end

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
          [**wise_expenses],
          [**wise_lend_money],
          [{ text: 'Главное меню',  callback_data: 'start_again' }],
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
      UpdateCellInGoogleSheet.call(
        result[:spent_foreign_money] + session[:total_price_of_products],
        result[:coordinates_of_value_to_change_spent_foreign_money],
      )
      UpdateCellInGoogleSheet.call(
        session[:foreigh_cash_amount],
        result[:coordinates_of_value_to_change_now_foreign_money],
      )
    end

    DeleteAllTodaysMessages.call
    set_default_values_in_session!

    respond_with(:message,
      text: 'В меню',
      reply_markup: {
        inline_keyboard: [[{ text: 'Главное меню',  callback_data: 'start_again' }]],
      }
    )
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
          sub_category = sub_category.first(15) + "_" if sub_category.size > 15

          next { text: sub_category, callback_data: "#{sub_category}: #{transaction_id}" }
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
    session[:is_wise] = nil
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

    redis.del('how_calculate_expenses_between_us')
  end

  def redis
    @redis ||= Redis.new
  end

  def remove_messages(data)
    transaction_id = data.split(': ')[1]
    params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
    DeleteMessagesJob.perform_later(params[:message_ids].uniq)
  end

  def amount_already_spent
    respond_with(:message, text: ReceiveCurrentMonthBalance.call)
  end

  def how_many_taxes_to_pay_in_current_month
    respond_with(:message, text: ReceiveCurrentMonthTaxesToPay.call)
  end

  def respond_with(type, *)
    result = super

    SaveMessageIdToRedis.call(payload["message_id"].presence || payload.dig("message", "message_id"))
    SaveMessageIdToRedis.call(result["result"]["message_id"])
  end

  def delete_all_todays_messages
    DeleteAllTodaysMessages.call
  end

  def expenses_to_return_from_vika
    result = FindCellToEnterVikaHalfExpenses.call

    who_should_return = ''
    if (result[:vika_total_spent_uah] - result[:mykola_total_spent_uah]) > 0
      who_should_return = "Итого: Микола должен #{result[:vika_total_spent_uah] - result[:mykola_total_spent_uah]} грн"
    elsif (result[:mykola_total_spent_uah] - result[:vika_total_spent_uah]) > 0
      who_should_return = "Итого: Вика должна #{result[:mykola_total_spent_uah] - result[:vika_total_spent_uah]} грн"
    elsif (result[:vika_total_spent_uah] - result[:mykola_total_spent_uah]) == 0
      who_should_return = 'Никто ничего никому не должен'
    end

    text = "Вика потратила гривен: #{result[:vika_total_spent_uah]}\nВика потратила $: #{result[:vika_total_spent_usd]}\nМикола потратила гривен: #{result[:mykola_total_spent_uah]}\nМикола потратил $: #{result[:mykola_total_spent_usd]}\n#{who_should_return}"

    respond_with(:message, text: text)
  end

  def info_current_month
    respond_with(:message, text: "```#{FindCellsCurrentMonth.call}```", parse_mode: :MarkdownV2)
  end
end
