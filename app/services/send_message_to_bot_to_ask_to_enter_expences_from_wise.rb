class SendMessageToBotToAskToEnterExpencesFromWise
  include CallableService

  def initialize(params)
    @params_to_display = params
    @id = params[:id]
    @redis = Redis.new
    @categories = ReceiveCategories.call
    @params = {
      price_in_usd: params[:price_in_usd],
      message_ids: [],
    }
  end

  def call
    response = send_message_with_params
    save_message_id(response["result"]["message_id"])
    response = send_message_with_categories
    save_message_id(response["result"]["message_id"])
    save_to_redis
  end

  private

  def send_message_with_params
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: @params_to_display,
    )
  end

  def send_message_with_categories
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: 'Выбери категорию чтобы сохранить wise транзакцию:',
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  def save_to_redis
    @redis.set(@id, @params.to_json, ex: 2.weeks)
  end

  def categories_to_show
    categories = @categories.keys.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}:w_id:#{@id}:#{@params[:price_in_usd]}" }
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
