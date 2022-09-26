class HandleInputPhoto
  include CallableService

  NIKOLAY_STEPANETS_CHAT_ID = 384435131
  SHOW_ITEMS_PER_LINE = 2
  ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM = 0.5

  def initialize(message_params)
    @message_params = message_params.deep_symbolize_keys
    @redis = Redis.new
    currency_code, currency_rate = @message_params[:caption].split(' ')
    @currency_to_usd = currency_rate.to_f if currency_code == "Usd" || currency_code == "usd" || currency_code == "USD"
    @currency_to_uah = currency_rate.to_f if currency_code == "Uah" || currency_code == "uah" || currency_code == "UAH"
    @params = []
  end

  def call
    return if @message_params[:photo].blank?

    @collected_prices, @total_sum_in_receipt, @file_id = PricesFromImage.call(@message_params)
    # @prices_with_categories, @total_sum_in_receipt, @file_id = PricesFromImage.call(@message_params)

    return send_message('не смог распарсить все цены в чеке :(((') if !can_enter_expenses?

    send_message("Общая цена в чеке: #{@collected_prices.sum}")
    # send_message("Общая цена в чеке: #{collected_prices_sum}")

    # !!!!! СОХРАНИТЬ ПОРЯДОК СООБЩЕНИЙ В БОТЕ КАК В ЧЕКЕ !!!!!!

    # @prices_with_categories.each do |price_with_category|
    #   current_price = price_with_category[:price]

    #   if price_with_category[:category_name].present?
    #     price_in_uah = {}
    #     price_in_uah = { price_in_uah: (current_price * @currency_to_uah / MonobankCurrencyRates.call('USD', 'UAH')) } if @currency_to_uah.present?

    #     price_in_usd = {}
    #     price_in_usd = { price_in_usd: (current_price / @currency_to_usd) } if @currency_to_usd.present?

    #     params_to_save_to_google_sheet = {
    #       category_name: price_with_category[:category_name],
    #       sub_category_name: price_with_category[:sub_category_name],
    #       operation_amount: current_price,
    #       **price_in_usd,
    #       **price_in_uah,
    #     }

    #     PutExpencesFopDollarCardJob.perform_now(params_to_save_to_google_sheet) if params_to_save_to_google_sheet[:price_in_usd]
    #     PutExpencesUahBlackCardJob.perform_now(params_to_save_to_google_sheet) if params_to_save_to_google_sheet[:price_in_uah]
    #   else
    #     categories_to_show = get_categories.keys.each_slice(SHOW_ITEMS_PER_LINE).map do |categories_array|
    #       categories_array.map do |category|
    #         { text: category, callback_data: "#{category}: f_id:#{@file_id}:#{current_price}" }
    #       end
    #     end
    #     response = send_message_with_categories(current_price, categories_to_show, price_with_category[:line_to_parse])
    #     @params << {
    #       price: price,
    #       currency_to_usd: @currency_to_usd,
    #       currency_to_uah: @currency_to_uah,
    #       message_ids: [response["result"]["message_id"]],
    #     }
    #   end
    # end
    # save_to_redis





    categories_to_show_by_price.each do |price_to_categories|
      price_to_categories.each do |price, categories_to_show|
        response = send_message_with_categories(price, categories_to_show)
        @params << {
          price: price,
          currency_to_usd: @currency_to_usd,
          currency_to_uah: @currency_to_uah,
          message_ids: [response["result"]["message_id"]],
        }
      end
    end
    save_to_redis

    nil
  end

  private

  def can_enter_expenses?
    return true if @collected_prices.sum.round(2) == @total_sum_in_receipt
    return true if (@collected_prices.sum.round(2) - @total_sum_in_receipt) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM && (@collected_prices.sum.round(2) - @total_sum_in_receipt).positive?
    return true if (@total_sum_in_receipt - @collected_prices.sum.round(2)) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM && (@total_sum_in_receipt - @collected_prices.sum.round(2)).positive?
    # return true if collected_prices_sum.round(2) == @total_sum_in_receipt
    # return true if (collected_prices_sum.round(2) - @total_sum_in_receipt) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM && (collected_prices_sum.round(2) - @total_sum_in_receipt).positive?
    # return true if (@total_sum_in_receipt - collected_prices_sum.round(2)) <= ACCEPTABLE_DIFFERENCE_BETWEEN_PRICES_SUM_AND_TOTAL_SUM && (@total_sum_in_receipt - collected_prices_sum.round(2)).positive?

    false
  end

  def send_message(text)
    Telegram.bot.send_message(
      chat_id: NIKOLAY_STEPANETS_CHAT_ID,
      text: text,
    )
  end

  def send_message_with_categories(price, categories_to_show)
    Telegram.bot.send_message(
      chat_id: NIKOLAY_STEPANETS_CHAT_ID,
      text: "Выбери категорию чтобы сохранить для #{price}:",
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  # def send_message_with_categories(price, categories_to_show, line_to_parse)
  #   Telegram.bot.send_message(
  #     chat_id: NIKOLAY_STEPANETS_CHAT_ID,
  #     text: "Выбери категорию чтобы сохранить для #{price}, line_to_parse: #{line_to_parse}:",
  #     reply_markup: { inline_keyboard:  categories_to_show },
  #   )
  # end

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
    @collected_prices_sum ||= @prices_with_categories[0].sum { |hsh| hsh[:price] }.round(2)
  end

  def get_categories
    @get_categories ||= ReceiveCategories.call
  end

  def save_to_redis
    @redis.set(@file_id, @params.to_json, ex: 2.days)
  end
end
