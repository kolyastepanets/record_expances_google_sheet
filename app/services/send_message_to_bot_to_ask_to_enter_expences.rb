class SendMessageToBotToAskToEnterExpences
  include CallableService

  EXPENSES_TO_SKIP = ["На награду в моно", "З гривневого рахунку ФОП"].freeze

  def initialize(transaction_data)
    @id = transaction_data[:id]
    @description = transaction_data[:description]
    @currency_rate = transaction_data[:currency_rate]
    @total_sum_of_money_before_save = transaction_data[:total_sum_of_money_before_save]
    @can_show_final_sum = transaction_data[:can_show_final_sum]
    @price_in_uah_white_card = transaction_data[:price_in_uah_white_card]
    @price_in_uah = transaction_data[:amount].to_i.abs / 100.0 if !transaction_data[:is_fop_dollar]
    @price_in_usd = transaction_data[:amount].to_i.abs / 100.0 if transaction_data[:is_fop_dollar]
    @operation_amount = transaction_data[:operationAmount].to_i.abs / 100.0
    @redis = Redis.new
    @categories = ReceiveCategories.call
  end

  def call
    return if EXPENSES_TO_SKIP.any? { |expence| @description.include?(expence) }

    build_params
    response = send_message_with_params
    save_message_id(response["result"]["message_id"])
    response = send_message_with_categories
    save_message_id(response["result"]["message_id"])
    save_to_redis
  end

  private

  def build_params
    @params = {
      description: @description,
      price_in_uah: @price_in_uah,
      price_in_usd: @price_in_usd,
      operation_amount: @operation_amount,
      currency_rate: @currency_rate,
      message_ids: [],
      total_sum_of_money_before_save: @total_sum_of_money_before_save,
      can_show_final_sum: @can_show_final_sum,
      price_in_uah_white_card: @price_in_uah_white_card,
    }
  end

  def send_message_with_params
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: @params,
    )
  end

  def send_message_with_categories
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: 'Выбери категорию чтобы сохранить:',
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  def save_to_redis
    @redis.set(@id, @params.to_json, ex: 2.weeks)
  end

  def categories_to_show
    categories = @categories.keys.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}:c_id:#{@id}:#{@price_in_uah.presence || @price_in_usd}" }
      end
    end

    remove_messages = [
      {
        text: "Удалить сообщения этой транзакции",
        callback_data: "remove_messages: #{@id}"
      }
    ]

    categories.push(remove_messages)

    categories
  end

  def save_message_id(message_id)
    @params[:message_ids] << message_id
  end
end
