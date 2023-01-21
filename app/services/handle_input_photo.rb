class HandleInputPhoto
  include CallableService

  SHOW_ITEMS_PER_LINE = 2
  ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM = 0.5
  ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM_INDONESIA = 200
  USUALLY_MIN_SUM_IN_INDONESIA = 50_000

  def initialize(message_params)
    @message_params = message_params.deep_symbolize_keys
    @redis = Redis.new
    currency_code, currency_rate, who_paid = @message_params[:caption].split(' ')
    @currency_to_usd = currency_rate.to_f if currency_code.downcase == "usd"
    @currency_to_uah = currency_rate.to_f if currency_code.downcase == "uah"
    @who_paid = who_paid&.downcase
    @mykola_paid = true if @who_paid == AllConstants::MYKOLA_PAYED
    @vika_paid = true if @who_paid == AllConstants::VIKA_PAYED
    @params = []
  end

  def call
    return if @message_params[:photo].blank? && @message_params[:document].blank?

    @prices_with_categories, @total_sum_in_receipt, @file_id = PricesFromImage.call(@message_params)

    return send_message("не смог распарсить все цены в чеке :(((, сумма всех цен: #{collected_prices_sum.round(2)}, сумма: #{@total_sum_in_receipt}") if !can_enter_expenses?

    send_message("Общая цена в чеке: #{collected_prices_sum}")

    total_sum_usd = 0
    total_sum_uah = 0

    first_cell_number = 0
    last_cell_number = 0
    total_sum_categories = @prices_with_categories.size
    total_sum_auto_entered_categories = 0
    total_sum_manually_entered_categories = 0

    if !@vika_paid
      if @currency_to_usd
        total_sum_usd_in_receipt = total_sum_of_money / @currency_to_usd
      end
      if @currency_to_uah
        total_sum_usd_in_receipt = total_sum_of_money * @currency_to_usd / MonobankCurrencyRates.call('USD', 'UAH')
      end
      send_message("Общая цена в чеке в долларах: #{total_sum_usd_in_receipt}")
      send_message("Общая сумма перед заполнением: #{total_sum_of_money}")
    end

    @prices_with_categories.each.with_index(1) do |price_with_category, index|
      params_to_save_to_google_sheet = build_params_to_save_to_google_sheet(price_with_category)

      if price_with_category[:category_name].present?
        sleep(1) # prevent google api sheet limit
        if @currency_to_usd.present?
          price_to_put_in_sheets = @who_paid.nil? ? params_to_save_to_google_sheet[:price_in_usd_to_save_in_google_sheet] : "#{params_to_save_to_google_sheet[:price_in_usd_to_save_in_google_sheet]} / 2"

          response = PutExpensesToGoogleSheet.call(
            params_to_save_to_google_sheet[:category_name],
            params_to_save_to_google_sheet[:sub_category_name],
            price_to_put_in_sheets,
            @who_paid,
          )
          if index == 1
            first_cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
          end

          total_sum_usd += params_to_save_to_google_sheet[:price_in_usd]
        end

        if @currency_to_uah.present?
          price_to_put_in_sheets = @who_paid.nil? ? params_to_save_to_google_sheet[:price_in_uah_converted_to_usd_to_save_in_google_sheet] : "#{params_to_save_to_google_sheet[:price_in_uah_converted_to_usd_to_save_in_google_sheet]} / 2"

          response = PutExpensesToGoogleSheet.call(
            params_to_save_to_google_sheet[:category_name],
            params_to_save_to_google_sheet[:sub_category_name],
            price_to_put_in_sheets,
            @who_paid,
          )
          if index == 1
            first_cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
          end

          total_sum_uah += params_to_save_to_google_sheet[:price_in_uah]
        end

        SendNotificationMessageToBot.call(params_to_save_to_google_sheet)

        total_sum_auto_entered_categories += 1
      else
        categories_to_show = get_categories.keys.each_slice(SHOW_ITEMS_PER_LINE).map do |categories_array|
          categories_array.map do |category|
            { text: category, callback_data: "#{category}: f_id:#{@file_id}:#{price_with_category[:price]}" }
          end
        end
        response = send_message_with_categories(price_with_category[:price], categories_to_show)
        @params << {
          price: price_with_category[:price],
          currency_to_usd: @currency_to_usd,
          currency_to_uah: @currency_to_uah,
          message_ids: [response["result"]["message_id"]],
          who_paid: @who_paid,
        }
        total_sum_manually_entered_categories += 1
      end
    end

    total_sum_usd = total_sum_usd.round(2)
    total_sum_uah = total_sum_uah.round(2)

    last_cell_number = first_cell_number + (@prices_with_categories.size - 1)
    all_cells = (first_cell_number..last_cell_number).to_a

    UpdateCellBackgroundColor.call(@who_paid, all_cells)

    calculate_total_spent_usd_and_uah = CalculateTotalSpentUsdAndUah.call

    if @currency_to_usd.present?
      # decrease usd saved amount
      UpdateCellInGoogleSheet.call(
        calculate_total_spent_usd_and_uah[:total_left_usd_money] - total_sum_usd,
        calculate_total_spent_usd_and_uah[:coordinates_of_total_left_usd_money],
      )
    end

    if @currency_to_uah.present? && !@vika_paid
      # decrease uah spent amount
      UpdateCellInGoogleSheet.call(
        calculate_total_spent_usd_and_uah[:total_left_uah_money] - total_sum_uah,
        calculate_total_spent_usd_and_uah[:coordinates_of_total_left_uah_money],
      )
    end

    if !@vika_paid && total_sum_categories == total_sum_auto_entered_categories
      send_message("Общая сумма после заполнения: #{total_sum_of_money}")
    else
      @params << {
        total_sum_categories: total_sum_categories,
        total_sum_auto_entered_categories: total_sum_auto_entered_categories,
        total_sum_manually_entered_categories: total_sum_manually_entered_categories,
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

  def send_message(text)
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: text,
    )
  end

  def send_message_with_categories(price, categories_to_show)
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "Выбери категорию чтобы сохранить для #{price}:",
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  def categories_to_show_by_price
    @collected_prices.map do |price|
      {
        price => get_categories.keys.each_slice(SHOW_ITEMS_PER_LINE).map do |categories_array|
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

  def total_sum_of_money
    if @currency_to_usd
      return ReceiveUsdFopFromGoogleSheet.call
    end

    if @currency_to_uah
      return ReceiveCurrentBalanceInMonobankFromGoogleSheet.call
    end
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
end
