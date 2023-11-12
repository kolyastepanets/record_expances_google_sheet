class HandleInputPhoto
  include CallableService

  ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM = 0.5
  ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM_INDONESIA = 200
  USUALLY_MIN_SUM_IN_INDONESIA = 50_000

  def initialize(message_params)
    @message_params = message_params.deep_symbolize_keys
    @redis = Redis.new
    currency_code, currency_rate = @message_params[:caption].split(' ')
    @currency_to_usd = currency_rate.to_f if currency_code.downcase == "usd"
    @currency_to_uah = currency_rate.to_f if currency_code.downcase == "uah"
    @params = []
  end

  def call
    return if @message_params[:photo].blank? && @message_params[:document].blank?

    @prices_with_categories, @total_sum_in_receipt, @file_id = PricesFromImage.call(@message_params)

    return send_message("не смог распарсить все цены в чеке :(((, сумма всех цен: #{collected_prices_sum.round(2)}, сумма: #{@total_sum_in_receipt}") if !can_enter_expenses?

    send_message("Общая цена в чеке в иностранной валюте: #{collected_prices_sum}")
    send_message("Общая цена в чеке: #{collected_prices_sum_in_uad_or_in_uah}")
    send_messages_before_enter_prices

    total_sum_usd = 0
    total_sum_uah = 0

    total_sum_categories = @prices_with_categories.size
    total_sum_auto_entered_categories = 0
    total_sum_manually_entered_categories = 0
    categories_names = []

    @prices_with_categories.each.with_index(1) do |price_with_category, index|
      params_to_save_to_google_sheet = build_params_to_save_to_google_sheet(price_with_category)

      if price_with_category[:category_name].present?
        categories_names << price_with_category[:category_name]

        sleep(1) # prevent google api sheet limit
        if @currency_to_usd.present?
          price_to_put_in_sheets = params_to_save_to_google_sheet[:price_in_usd_to_save_in_google_sheet]

          PutExpensesToGoogleSheet.call(
            params_to_save_to_google_sheet[:category_name],
            params_to_save_to_google_sheet[:sub_category_name],
            price_to_put_in_sheets,
          )

          total_sum_usd += params_to_save_to_google_sheet[:price_in_usd]
        end

        if @currency_to_uah.present?
          price_to_put_in_sheets = params_to_save_to_google_sheet[:price_in_uah_converted_to_usd_to_save_in_google_sheet]

          PutExpensesToGoogleSheet.call(
            params_to_save_to_google_sheet[:category_name],
            params_to_save_to_google_sheet[:sub_category_name],
            price_to_put_in_sheets,
          )

          total_sum_uah += params_to_save_to_google_sheet[:price_in_uah]
        end

        SendNotificationMessageToBot.call(params_to_save_to_google_sheet)

        total_sum_auto_entered_categories += 1
      else
        categories_to_show = get_categories.keys.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
          categories_array.map do |category|
            { text: category, callback_data: "#{category}:f_id:#{@file_id}:#{price_with_category[:price]}" }
          end
        end
        response = send_message_with_categories(price_with_category, categories_to_show)
        @params << {
          price: price_with_category[:price],
          currency_to_usd: @currency_to_usd,
          currency_to_uah: @currency_to_uah,
          message_ids: [response["result"]["message_id"]],
        }
        total_sum_manually_entered_categories += 1
      end
    end

    total_sum_usd = total_sum_usd.round(2)
    total_sum_uah = total_sum_uah.round(2)

    calculate_total_spent_usd_and_uah = CalculateTotalSpentUsdAndUah.call

    if @currency_to_usd.present?
      # decrease usd saved amount
      UpdateCellInGoogleSheet.call(
        calculate_total_spent_usd_and_uah[:total_left_usd_money] - total_sum_usd,
        calculate_total_spent_usd_and_uah[:coordinates_of_total_left_usd_money],
      )
    end

    if @currency_to_uah.present?
      # decrease uah spent amount
      UpdateCellInGoogleSheet.call(
        calculate_total_spent_usd_and_uah[:total_left_uah_money] - total_sum_uah,
        calculate_total_spent_usd_and_uah[:coordinates_of_total_left_uah_money],
      )
    end

    if total_sum_categories == total_sum_auto_entered_categories
      send_messages_after_enter_prices
      send_messages_how_much_can_spend(categories_names)
    else
      @params << {
        total_sum_categories: total_sum_categories,
        total_sum_auto_entered_categories: total_sum_auto_entered_categories,
        total_sum_manually_entered_categories: total_sum_manually_entered_categories,
        total_sum_of_money_before_save: @total_sum_of_money_before_save,
      }
    end

    save_to_redis

    nil
  end

  private

  def can_enter_expenses?
    return true if collected_prices_sum.round(2) == @total_sum_in_receipt
    return true if (collected_prices_sum.round(2) - @total_sum_in_receipt) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM && (collected_prices_sum.round(2) - @total_sum_in_receipt).positive?
    return true if (@total_sum_in_receipt - collected_prices_sum.round(2)) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM && (@total_sum_in_receipt - collected_prices_sum.round(2)).positive?

    if collected_prices_sum > USUALLY_MIN_SUM_IN_INDONESIA
      return true if collected_prices_sum.round(2) == @total_sum_in_receipt
      return true if (collected_prices_sum.round(2) - @total_sum_in_receipt) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM_INDONESIA && (collected_prices_sum.round(2) - @total_sum_in_receipt).positive?
      return true if (@total_sum_in_receipt - collected_prices_sum.round(2)) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM_INDONESIA && (@total_sum_in_receipt - collected_prices_sum.round(2)).positive?
    end

    false
  end

  def send_message(text, show_reply_markup_main_buttons: false)
    reply_markup_main_buttons = {}
    reply_markup_main_buttons = { reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS } if show_reply_markup_main_buttons

    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: text,
      **reply_markup_main_buttons,
    )
  end

  def send_message_with_categories(price_with_category, categories_to_show)
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "Вся строка: #{price_with_category[:full_parsed_line]}\nПоиск в гугле: <a href=\"https://www.google.com/search?q=#{without_first_and_last(price_with_category[:full_parsed_line])}\">ссылка</a>\nВыбери категорию чтобы сохранить для #{price_with_category[:price]}:",
      parse_mode: :HTML,
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  def categories_to_show_by_price
    @collected_prices.map do |price|
      {
        price => get_categories.keys.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
          categories_array.map do |category|
            { text: category, callback_data: "#{category}: f_id:#{@file_id}:#{price}" }
          end
        end
      }
    end
  end

  def collected_prices_sum
    return @collected_prices_sum if defined? @collected_prices_sum

    @collected_prices_sum ||= @prices_with_categories.sum { |hsh| hsh[:price] }.round(2)
  end

  def get_categories
    @get_categories ||= ReceiveCategories.call
  end

  def save_to_redis
    @redis.set(@file_id, @params.to_json, ex: 2.days)
  end

  def build_params_to_save_to_google_sheet(price_with_category)
    current_price = price_with_category[:price]

    price_in_usd = {}
    if @currency_to_usd.present?
      price_in_usd = {
        price_in_usd: (current_price / @currency_to_usd).round(2),
        price_in_usd_to_save_in_google_sheet: "=#{current_price.to_s.gsub(".", ",")} / #{@currency_to_usd.to_s.gsub(".", ",")}"
      }
    end

    price_in_uah = {}
    if @currency_to_uah.present?
      price_in_uah = {
        price_in_uah: (current_price * @currency_to_uah).round(2),
        price_in_uah_converted_to_usd_to_save_in_google_sheet: "=#{current_price.to_s.gsub(".", ",")} * #{@currency_to_uah.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"
      }
    end

    {
      category_name: price_with_category[:category_name],
      sub_category_name: price_with_category[:sub_category_name],
      operation_amount: current_price,
      **price_in_usd,
      **price_in_uah,
    }
  end

  def send_messages_before_enter_prices
    @total_sum_of_money_before_save = 0
  end

  def send_messages_after_enter_prices
    data_text = TextMessagesAfterEnterPrices.call(!!@currency_to_usd, !!@currency_to_uah, @total_sum_of_money_before_save)
    send_message(data_text[:total_sum_after_money_was_saved])
    send_message(data_text[:difference_of_saved_money], show_reply_markup_main_buttons: true)
  end

  def send_messages_how_much_can_spend(categories_names)
    SendInfoHowMuchMoneyCanSpendThisWeekJob.perform_later(categories_names)
  end

  def collected_prices_sum_in_uad_or_in_uah
    return "$#{(collected_prices_sum / @currency_to_usd).round(2)}" if @currency_to_usd
    return "#{(collected_prices_sum * @currency_to_uah).round(2)} грн" if @currency_to_uah
  end

  def without_first_and_last(current_string)
    current_string.split(", ")[1..-2].join(" ")
  end
end
