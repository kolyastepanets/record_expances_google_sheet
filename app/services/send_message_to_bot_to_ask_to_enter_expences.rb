class SendMessageToBotToAskToEnterExpences
  include CallableService

  NIKOLAY_STEPANETS_CHAT_ID = 384435131
  EXPENSES_TO_SKIP = ["На награду в моно", "С гривневого счета ФОП"].freeze
  SHOW_ITEMS_PER_LINE = 2

  def initialize(transaction_data)
    @id = transaction_data[:id]
    @description = transaction_data[:description]
    @price_in_uah = transaction_data[:amount].abs / 100.0
    @operation_amount = transaction_data[:operationAmount].abs / 100.0
    @redis = Redis.new
    @categories = ReceiveCategories.call
  end

  def call
    return if EXPENSES_TO_SKIP.include?(@description)

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
      operation_amount: @operation_amount,
      message_ids: [],
    }
  end

  def send_message_with_params
    Telegram.bot.send_message(
      chat_id: NIKOLAY_STEPANETS_CHAT_ID,
      text: @params,
    )
  end

  def send_message_with_categories
    Telegram.bot.send_message(
      chat_id: NIKOLAY_STEPANETS_CHAT_ID,
      text: 'Выбери категорию чтобы сохранить:',
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  def save_to_redis
    @redis.set(@id, @params.to_json, ex: 2.weeks)
  end

  def categories_to_show
    categories = @categories.keys.each_slice(SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}: c_id:#{@id}" }
      end
    end

    remove_messages = [
      {
        text: "Удалить сообщения этой транзакции",
        callback_data: "remove_messages: #{@id}"
      }
    ]

    categories.push(remove_messages)
  end

  def save_message_id(message_id)
    @params[:message_ids] << message_id
  end
end
