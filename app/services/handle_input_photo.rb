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

    return send_message('не смог распарсить все цены в чеке :(((') if !can_enter_expenses?

    send_message("Общая цена в чеке: #{@collected_prices.sum}")
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

  def get_categories
    ReceiveCategories.call
  end

  def save_to_redis
    @redis.set(@file_id, @params.to_json, ex: 2.days)
  end
end
