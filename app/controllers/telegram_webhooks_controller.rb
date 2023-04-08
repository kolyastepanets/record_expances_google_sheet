class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  BUTTONS_INFO = [
    ['UAH and USD all'],
    ['How many taxes to pay in current month'],
    ['Total saved money on gsheets'],
    ['Траты в gsheets за текущий день'],
    ['Последние 10 транзакций в моно'],
    ['Удалить все текущие сообщения'],
    ['Сегодня пришла Komank'],
    ['Сегодня пришел pool man'],
    ['Вернуть часть денег после снятия кэша'],
    ['Выровнять в гугл таблице как в монобанке'],
    ['Enter wise salary'],
    ['Получить статистику по категории за месяц'],
    ['Получить среднее значение трат по категории за период'],
    ['Info current month'],
  ].freeze

  def start!(*)
    set_default_values_in_session!

    if from["username"] == ENV['MY_USER_NAME']
      respond_with(
        :message,
        text: 'Выбери действие:',
        reply_markup: {
          keyboard: AllConstants::MAIN_BUTTONS,
          resize_keyboard: true,
          one_time_keyboard: true,
          is_persistent: false,
          selective: true,
        }
      )
    else
      respond_with(:message, text: 'You are not authorized')
    end
  end

  def callback_query(data)
    case data
    when 'main_menu'
      start!
    when 'metro_expenses'
      session[:is_metro] = true
      start_remember_total_price_of_products
      is_usd = false
      is_uah = true
      session[:total_sum_of_money_before_save] = SendTextMessagesBeforeEnterPrices.call(is_usd, is_uah)
      show_categories_to_choose
    when 'common_expenses'
      session[:is_grivnas] = true
      start_remember_total_price_of_products
      is_usd = false
      is_uah = true
      session[:total_sum_of_money_before_save] = SendTextMessagesBeforeEnterPrices.call(is_usd, is_uah)
      show_categories_to_choose
    when 'receipt_foreign_currency'
      session[:is_grivnas] = true
      is_usd = false
      is_uah = true
      session[:total_sum_of_money_before_save] = SendTextMessagesBeforeEnterPrices.call(is_usd, is_uah)
      ask_to_enter_current_exchange_rate
    when 'cash_foreign_currency'
      result = CalculateForeignCurrencyCashExpenses.call
      session[:foreigh_spent_cash_amount] = result[:spent_foreign_money]
      session[:total_withraw_foreign_money] = result[:total_withraw_foreign_money]
      respond_with(:message, text: "Предыдущая оставшаяся сумма: #{result[:now_foreign_money]}")
      ask_to_enter_left_foreign_cash
    when 'dollar_card'
      ask_to_enter_dollar_foreign_currency_exchange_rate
    when 'wise'
      session[:is_wise] = true
      start_remember_total_price_of_products
      show_categories_to_choose
    when 'wise_lend_money'
      ask_to_enter_wise_amount_to_lend_money
    when 'previous_day'
      session[:requested_date_to_show_expenses] -= 1.day
      get_expenses_for_today_in_google_sheet(requested_date_to_show_expenses: session[:requested_date_to_show_expenses])
    when 'komank_came_today'
      Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: redis.get('message_id_ask_if_komank_came_today'))
      komank_came_today
    when 'komank_did_not_come_today'
      Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: redis.get('message_id_ask_if_komank_came_today'))
      respond_with(:message, text: "Komank did not come today", reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
    when -> (input_category) { input_category.include?('category_for_statistic') }
      category_name = data.split(':')[0]
      session[:category_for_statistic] = category_name
      ask_to_choose_year_for_statistic(payload["message"]["message_id"])
    when -> (input_year) { input_year.include?('year_for_statistic') }
      year_for_statistic = data.split(':')[0]
      session[:year_for_statistic] = year_for_statistic
      ask_to_choose_month_for_statistic(payload["message"]["message_id"])
    when -> (input_category) { input_category.include?('m_and_y_for_statistic') }
      show_statistic(data, payload["message"]["message_id"])
    when -> (input_category) { input_category.include?('av_exp_for_category') }
      category_name = data.split(':')[0]
      session[:category_for_statistic] = category_name
      ask_to_choose_start_year_for_statistic(payload["message"]["message_id"])
    when -> (input_year) { input_year.include?('start_year_for_av_statistic') }
      year_for_statistic = data.split(':')[0]
      session[:start_year_for_average_statistic] = year_for_statistic
      ask_to_choose_start_month_for_statistic(payload["message"]["message_id"])
    when -> (input_year) { input_year.include?('start_m_and_y_for_av_statistic') }
      month, year = data.split(':')[0].split
      session[:start_month_for_average_statistic] = month
      ask_to_choose_end_year_for_statistic(payload["message"]["message_id"])
    when -> (input_year) { input_year.include?('end_year_for_average_statistic') }
      year_for_statistic = data.split(':')[0]
      session[:end_year_for_average_statistic] = year_for_statistic
      ask_to_choose_end_month_for_statistic(payload["message"]["message_id"])
    when -> (input_year) { input_year.include?('end_m_and_y_for_av_statistic') }
      show_average_statistic(data, payload["message"]["message_id"])
    when -> (input_string) { input_string.include?('sub_category') && !input_string.include?('<<:') }
      category_name = data.split(':')[0]
      save_category_to_session!(category_name)
      Telegram.bot.edit_message_reply_markup(chat_id: ENV['MY_TELEGRAM_ID'], message_id: payload["message"]["message_id"], reply_markup: { inline_keyboard: BuildArrayOfSubCategories.call(category_name, 'sub1_category', '', '') })
    when -> (input_data) { input_data.include?('sub1_category') }
      ask_for_price(find_full_sub_category_name(data.split(":")[0]))
    when 'categor_without_subcategor'
      ask_for_price(nil)
    when 'finish_remember_total_price_of_products'
      finish_remember_total_price_of_products
    when -> (input_data) { input_data.include?('remove_messages') }
      remove_messages(data)
    when -> (input_string) { input_string.include?('<<:') }
      _sign, kind_of_transaction, transaction_id, price = data.split(':')
      message_id = FindMessageId.call(transaction_id, price, payload["message"]["message_id"])
      Telegram.bot.edit_message_reply_markup(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id, reply_markup: { inline_keyboard: BuildArrayOfCategories.call(kind_of_transaction, transaction_id, price) })
    when -> (input_category) { input_category.include?('w_id') || input_category.include?('c_id') }
      category_name, kind_of_transaction, transaction_id, price = data.split(':')
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:category_name] = category_name
      redis.set(transaction_id, params.to_json, ex: 1.week)
      Telegram.bot.edit_message_reply_markup(chat_id: ENV['MY_TELEGRAM_ID'], message_id: params[:message_ids].last, reply_markup: { inline_keyboard: BuildArrayOfSubCategories.call(category_name, kind_of_transaction.insert(1, "1"), transaction_id, price) })
    when -> (input_sub_category) { input_sub_category.include?('c1_id') }
      short_subcategory_name, _kind_of_transaction, transaction_id, _price = data.split(":")
      sub_category_name = find_full_sub_category_name(short_subcategory_name)
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:message_ids] << payload["message"]["message_id"]
      params[:sub_category_name] = sub_category_name

      PutExpencesUahBlackCardJob.perform_later(params) if params[:price_in_uah]
      PutExpencesFopDollarCardJob.perform_later(params) if params[:price_in_usd]
      DeleteMessagesJob.perform_later(params[:message_ids].uniq)
    when -> (input_sub_category) { input_sub_category.include?('w1_id') }
      short_subcategory_name, _kind_of_transaction, transaction_id, _price = data.split(":")
      sub_category_name = find_full_sub_category_name(short_subcategory_name)
      params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
      params[:message_ids] << payload["message"]["message_id"]
      params[:sub_category_name] = sub_category_name

      DecreaseWiseUsdSavedAmountJob.perform_later(params[:price_in_usd])
      PutExpensesToGoogleSheetJob.perform_later(params[:category_name], params[:sub_category_name], params[:price_in_usd], detect_month)
      SendNotificationMessageToBot.call(params, show_reply_markup_main_buttons: true)
      DeleteMessagesJob.perform_later(params[:message_ids].uniq)
    when -> (input_category) { input_category.include?('f_id') }
      category_name, kind_of_transaction, transaction_id, price = data.split(':')
      params = JSON.parse(redis.get(transaction_id))
      last_price_to_message = params.select { |pri| pri["price"] == price.to_f }[-1]
      last_price_to_message["category_name"] = category_name
      redis.set(transaction_id, params.to_json, ex: 1.week)
      Telegram.bot.edit_message_reply_markup(chat_id: ENV['MY_TELEGRAM_ID'], message_id: last_price_to_message["message_ids"].last, reply_markup: { inline_keyboard: BuildArrayOfSubCategories.call(category_name, kind_of_transaction.insert(1, "1"), transaction_id, price) })
    when -> (input_sub_category) { input_sub_category.include?('f1_id') }
      params_to_save_to_google_sheet, new_params_for_redis, messages_to_delete = PrepareParamsAfterEnterSubcategoryBeforeSave.call(data)

      data_hash = new_params_for_redis.detect { |pri| pri["total_sum_manually_entered_categories"] }
      updated_params = {
        **params_to_save_to_google_sheet,
        can_show_final_sum: data_hash["total_sum_manually_entered_categories"].present? && data_hash["total_sum_manually_entered_categories"].zero?,
        total_sum_of_money_before_save: data_hash["total_sum_of_money_before_save"],
      }

      PutExpencesUahBlackCardJob.perform_later(updated_params) if updated_params[:price_in_uah]
      PutExpencesFopDollarCardJob.perform_later(updated_params) if updated_params[:price_in_usd]
      DeleteMessages.call((messages_to_delete + [payload["message"]["message_id"]]).uniq)
    else
      # return help
    end
  rescue StandardError => e
    if Rails.env.production?
      respond_with(:message, text: "Что то пошло не так: #{e.message}", reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
    else
      raise e
    end
  end

  def save_data_to_google_sheet!(price, *args)
    price_to_put_in_sheets, price_to_calculate = BuildPrice.call(price, session)

    if !session[:receipt_dollar_foreign_currency_exchange_rate].nil?
      currency_uah_to_usd = price_to_put_in_sheets.split(" ")[-1].gsub(",", ".").to_f
      price_in_uah = price.to_f / session[:receipt_dollar_foreign_currency_exchange_rate].to_f * currency_uah_to_usd
      price_in_usd = price_to_calculate

      DecreaseUsdSavedAmountJob.perform_later({ price_in_usd: price_in_usd })
    end

    if session[:is_grivnas]
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
    PutExpensesToGoogleSheetJob.perform_later(category_name, sub_category_name, price_to_put_in_sheets, detect_month)

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
      respond_with(:message, text: error_message, reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
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
    session[:total_sum_of_money_before_save] = SendTextMessagesBeforeEnterPrices.call(true, false)
    start_remember_total_price_of_products
    show_categories_to_choose
  end

  def save_left_foreign_cash!(foreigh_cash_amount, *args)
    session[:foreigh_cash_amount] = SumEnteredAmount.call(foreigh_cash_amount)
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
    message_text = message["text"]

    if 'All buttons' == message_text
      return respond_with(
        :message,
        text: 'Выбери действие:',
        reply_markup: {
          keyboard: BUTTONS_INFO,
          resize_keyboard: true,
          one_time_keyboard: true,
          is_persistent: false,
          selective: true,
        }
      )
    end

    if message_text == 'Внести расходы'
      set_default_values_in_session!
      return ask_type_of_expenses
    end

    if BUTTONS_INFO.flat_map(&:first).include?(message_text)
      mapping = [
        { text: 'UAH and USD all', method_to_call: 'uah_and_usd_all' },
        { text: 'How many taxes to pay in current month', method_to_call: 'how_many_taxes_to_pay_in_current_month' },
        { text: 'Total saved money on gsheets', method_to_call: 'total_saved_money_from_google_sheet' },
        { text: 'Траты в gsheets за текущий день', method_to_call: 'get_expenses_for_today_in_google_sheet' },
        { text: 'Последние 10 транзакций в моно', method_to_call: 'get_last_10_transactions_from_mono' },
        { text: 'Удалить все текущие сообщения',  method_to_call: 'delete_all_todays_messages' },
        { text: 'Сегодня пришла Komank',  method_to_call: 'komank_came_today' },
        { text: 'Сегодня пришел pool man', method_to_call: 'pool_man_came_today' },
        { text: 'Вернуть часть денег после снятия кэша', method_to_call: 'return_part_money_after_withdraw_cash' },
        { text: 'Выровнять в гугл таблице как в монобанке', method_to_call: 'round_in_google_sheet_like_in_monobank' },
        { text: 'Enter wise salary', method_to_call: 'ask_to_enter_wise_salary' },
        { text: 'Получить статистику по категории за месяц', method_to_call: 'get_statistic_by_category_for_month' },
        { text: 'Получить среднее значение трат по категории за период', method_to_call: 'get_statistic_average_expenses_by_category_for_period' },
        { text: 'Info current month',  method_to_call: 'info_current_month' }
      ]
      found_mapping = mapping.detect { |current_mapping| current_mapping[:text] == message_text }

      if found_mapping
        return send(found_mapping[:method_to_call])
      end
    end

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
    respond_with(:message, text: 'Wise salary has been saved', reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
  end

  def ask_to_enter_wise_amount_to_lend_money
    save_context(:save_wise_lend_money!)
    respond_with(:message, text: 'Enter how much to lend:')
  end

  def save_wise_lend_money!(wise_lend_money, *args)
    DecreaseWiseUsdSavedAmountJob.perform_later(wise_lend_money)
    respond_with(:message, text: 'Entered amount has been withdrawn', reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
  end

  def ask_grivnas_and_foreign_money_returned!(grivnas_returned, *args)
    grivnas = grivnas_returned
    foreign_cash = args.first
    HandleMoneyReturnedCashAndGrivnas.call(grivnas.to_f, foreign_cash.to_f)
    respond_with(:message, text: 'money has been handled!', reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
  end

  private

  def uah_and_usd_all
    usd_wise_in_google_sheet = ReceiveWiseFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:wise_formula]
    usd_wise_in_google_sheet_text = "usd wise in google sheet: $#{usd_wise_in_google_sheet.round(2)}"

    respond_with(
      :message,
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{ReceiveUsdFopFromMonobank.call}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{ReceiveCurrentBalanceInMonobankFromMono.call}\n#{usd_wise_in_google_sheet_text}\n#{ReceiveWiseFromApi.call}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  end

  def total_saved_money_from_google_sheet
    respond_with(:message, text: ReceiveTotalSavedMoneyFromGoogleSheet.call, reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
  end

  def get_expenses_for_today_in_google_sheet(requested_date_to_show_expenses: Date.today)
    session[:requested_date_to_show_expenses] = requested_date_to_show_expenses
    arrays_of_data = GetExpensesForTodayFromGoogleSheet.call(session[:requested_date_to_show_expenses])
    arrays_of_data.each_with_index do |array_of_data, index|
      reply_markup = {}
      reply_markup = {
        reply_markup: {
          inline_keyboard: [
            [{ text: 'previous day', callback_data: 'previous_day' }],
            [{ text: 'main menu', callback_data: 'main_menu' }],
          ]
        }
      } if index == (arrays_of_data.size - 1)

      respond_with(
        :message,
        text: "```#{array_of_data.join("\n")}```",
        parse_mode: :MarkdownV2,
        **reply_markup,
      )
    end
  end

  def get_last_10_transactions_from_mono
    respond_with(:message, text: GetLastTenTransactionsFromMonobank.call, reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
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
          [{ text: 'Wise',  callback_data: 'wise' }],
          [{ text: 'Wise lend money',  callback_data: 'wise_lend_money' }],
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

    message_ids = redis.get("messages_at_#{Date.today.to_s}")
    DeleteMessages.call((JSON.parse(message_ids) + [payload["message"]["message_id"]]).uniq)

    if session[:is_grivnas] || session[:is_metro] || !!session[:receipt_dollar_foreign_currency_exchange_rate]
      is_usd = !!session[:receipt_dollar_foreign_currency_exchange_rate]
      is_uah = session[:is_grivnas] || session[:is_metro]
      SendMessageTotalSumAfterFinishEnterMoney.call(is_usd, is_uah, session[:total_sum_of_money_before_save])
    end

    set_default_values_in_session!

    respond_with(
      :message,
      text: 'Выбери действие:',
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
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
    prepare_categories = categories.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}:sub_category" }
      end
    end

    finish_remember_total_price_of_products = [
      {
        text: "Зак..ть внесение продуктов. Н.ть заново",
        callback_data: "finish_remember_total_price_of_products"
      }
    ]

    prepare_categories.push(finish_remember_total_price_of_products)

    respond_with(:message, text: 'Выбери категорию:', reply_markup: { inline_keyboard: prepare_categories })
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
    if session[:foreigh_cash_amount] && !session[:foreigh_cash_amount].zero?
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
    session[:is_grivnas] = false
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
    session[:total_sum_of_money_before_save] = 0
    session[:category_for_statistic] = nil
    session[:year_for_statistic] = nil
    session[:start_year_for_average_statistic] = nil
    session[:start_month_for_average_statistic] = nil
    session[:end_year_for_average_statistic] = nil
    session[:requested_date_to_show_expenses] = nil
  end

  def redis
    @redis ||= Redis.new
  end

  def remove_messages(data)
    transaction_id = data.split(': ')[1]
    params = JSON.parse(redis.get(transaction_id)).deep_symbolize_keys
    DeleteMessagesJob.perform_later(params[:message_ids].uniq)
  end

  def how_many_taxes_to_pay_in_current_month
    respond_with(:message, text: ReceiveCurrentMonthTaxesToPay.call[:full_text], reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS)
  end

  def respond_with(type, *args)
    result = super

    return if args[0][:parse_mode].present?

    SaveMessageIdToRedis.call(payload["message_id"].presence || payload.dig("message", "message_id"))
    SaveMessageIdToRedis.call(result["result"]["message_id"])
  end

  def delete_all_todays_messages
    DeleteAllTodaysMessages.call
  end

  def komank_came_today
    updated_rows = RecordTodayVisitKomankToGoogleSheet.call
    if updated_rows == 1
      return respond_with(
        :message,
        text: "Дата визита Komank сохранена",
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
    end
    respond_with(
      :message,
      text: "Что то случилось, дата визита НЕ сохранена",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  end

  def pool_man_came_today
    updated_rows = RecordTodayVisitPoolManToGoogleSheet.call
    if updated_rows == 1
      return respond_with(
        :message,
        text: "Дата визита pool man сохранена",
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
    end
    respond_with(
      :message,
      text: "Что то случилось, дата визита НЕ сохранена",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  end

  def round_in_google_sheet_like_in_monobank
    usd_fop_monobank = ReceiveUsdFopFromMonobank.call
    uah_fop_monobank = ReceiveCurrentBalanceInMonobankFromMono.call

    respond_with(
      :message,
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{usd_fop_monobank}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{uah_fop_monobank}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )

    RoundInGoogleSheetLikeInMonobank.call(usd_fop_monobank, uah_fop_monobank)

    respond_with(
      :message,
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{usd_fop_monobank}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{uah_fop_monobank}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  end

  def info_current_month
    respond_with(
      :message,
      text: "```#{FindCellsCurrentMonth.call}```",
      parse_mode: :MarkdownV2,
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS,
    )
  end

  def get_statistic_by_category_for_month
    prepare_categories = categories.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}: category_for_statistic" }
      end
    end

    respond_with(:message, text: 'Выбери категорию для статистики:', reply_markup: { inline_keyboard: prepare_categories })
  end

  def ask_to_choose_year_for_statistic(message_id)
    start_year = 2020
    year_now = Date.today.year
    array_of_years = (start_year..year_now).to_a
    years_to_choose = array_of_years.map do |year|
      { text: year, callback_data: "#{year}: year_for_statistic" }
    end

    Telegram.bot.edit_message_reply_markup(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id, reply_markup: { inline_keyboard: [years_to_choose] })
  end

  def ask_to_choose_month_for_statistic(message_id)
    start_year = "01.01.#{session[:year_for_statistic]}"
    start_year = "01.10.#{session[:year_for_statistic]}" if session[:year_for_statistic] == "2020"
    end_year   = "31.12.#{session[:year_for_statistic]}"
    end_year   = Date.today.end_of_month.strftime("%d.%m.%Y") if session[:year_for_statistic] == Date.today.year.to_s
    dates = (Date.parse(start_year)..Date.parse(end_year)).to_a.select { |current_date| current_date.day == 1 }.map { |current_date| "#{Date::ABBR_MONTHNAMES[current_date.month]} #{current_date.year}" }

    prepare_dates = dates.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |dates_array|
      dates_array.map do |category|
        { text: category, callback_data: "#{category}: m_and_y_for_statistic" }
      end
    end

    Telegram.bot.edit_message_reply_markup(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id, reply_markup: { inline_keyboard: prepare_dates })
  end

  def show_statistic(date_for_statistic, message_id)
    month, year = date_for_statistic.split(':')[0].split
    months = [Date::ABBR_MONTHNAMES.index(month).to_s, "#{Date::ABBR_MONTHNAMES.index(month).to_s},1"]

    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    respond_with(
      :message,
      text: "```#{GetStatisticForCategoryForMonthFromGoogleSheet.call(session[:category_for_statistic], months, year)}```",
      parse_mode: :MarkdownV2,
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS,
    )

    set_default_values_in_session!
  end

  def get_statistic_average_expenses_by_category_for_period
    prepare_categories = categories.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}: av_exp_for_category" }
      end
    end

    respond_with(:message, text: 'Выбери категорию для статистики:', reply_markup: { inline_keyboard: prepare_categories })
  end

  def ask_to_choose_start_year_for_statistic(message_id)
    start_year = 2020
    year_now = Date.today.year
    array_of_years = (start_year..year_now).to_a
    years_to_choose = array_of_years.map do |year|
      { text: year, callback_data: "#{year}: start_year_for_av_statistic" }
    end

    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    respond_with(:message, text: 'Выбери год начала для статистики:', reply_markup: { inline_keyboard: [years_to_choose] })
  end

  def ask_to_choose_start_month_for_statistic(message_id)
    start_year = "01.01.#{session[:start_year_for_average_statistic]}"
    start_year = "01.10.#{session[:start_year_for_average_statistic]}" if session[:start_year_for_average_statistic] == "2020"
    end_year   = "31.12.#{session[:start_year_for_average_statistic]}"
    end_year   = Date.today.end_of_month.strftime("%d.%m.%Y") if session[:start_year_for_average_statistic] == Date.today.year.to_s
    dates = (Date.parse(start_year)..Date.parse(end_year)).to_a.select { |current_date| current_date.day == 1 }.map { |current_date| "#{Date::ABBR_MONTHNAMES[current_date.month]} #{current_date.year}" }

    prepare_dates = dates.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |dates_array|
      dates_array.map do |month_and_year|
        { text: month_and_year, callback_data: "#{month_and_year}: start_m_and_y_for_av_statistic" }
      end
    end

    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    respond_with(:message, text: 'Выбери месяц начала для статистики:', reply_markup: { inline_keyboard: prepare_dates })
  end

  def ask_to_choose_end_year_for_statistic(message_id)
    start_year = session[:start_year_for_average_statistic].to_i
    year_now = Date.today.year
    array_of_years = (start_year..year_now).to_a
    years_to_choose = array_of_years.map do |year|
      { text: year, callback_data: "#{year}: end_year_for_average_statistic" }
    end

    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    respond_with(:message, text: 'Выбери конечный год для статистики:', reply_markup: { inline_keyboard: [years_to_choose] })
  end

  def ask_to_choose_end_month_for_statistic(message_id)
    month_start_from = "01"
    if session[:start_year_for_average_statistic] == session[:end_year_for_average_statistic]
      month_start_from = Date::ABBR_MONTHNAMES.index(session[:start_month_for_average_statistic]) + 1
    end
    start_year = "01.#{month_start_from}.#{session[:end_year_for_average_statistic]}"
    end_year   = "31.12.#{session[:end_year_for_average_statistic]}"
    end_year   = Date.today.end_of_month.strftime("%d.%m.%Y") if session[:end_year_for_average_statistic] == Date.today.year.to_s
    dates = (Date.parse(start_year)..Date.parse(end_year)).to_a.select { |current_date| current_date.day == 1 }.map { |current_date| "#{Date::ABBR_MONTHNAMES[current_date.month]} #{current_date.year}" }

    prepare_dates = dates.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |dates_array|
      dates_array.map do |month_and_year|
        { text: month_and_year, callback_data: "#{month_and_year}: end_m_and_y_for_av_statistic" }
      end
    end

    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    respond_with(:message, text: 'Выбери конечный месяц для статистики:', reply_markup: { inline_keyboard: prepare_dates })
  end

  def show_average_statistic(date_for_statistic, message_id)
    start_month = session[:start_month_for_average_statistic]
    start_year = session[:start_year_for_average_statistic]
    end_month, end_year = date_for_statistic.split(':')[0].split

    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    respond_with(
      :message,
      text: "```#{GetAverageStatisticForCategoryForPeriodFromGoogleSheet.call(session[:category_for_statistic], start_month, start_year, end_month, end_year)}```",
      parse_mode: :MarkdownV2,
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS,
    )

    set_default_values_in_session!
  end

  def return_part_money_after_withdraw_cash
    save_context(:ask_grivnas_and_foreign_money_returned!)
    respond_with(:message, text: 'Enter how much grivnas and foreign cash were returned, "1468 600000" :')
  end
end
