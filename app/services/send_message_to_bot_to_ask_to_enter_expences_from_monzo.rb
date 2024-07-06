class SendMessageToBotToAskToEnterExpencesFromMonzo
  include CallableService

  def initialize(params)
    if params[:data][:account_id] == ENV['MONZO_ACCOUNT_ID']
      @account_type = 'Monzo'
      @transaction_identificator = "m_id"
    end
    if params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID']
      @account_type = 'Joint Monzo'
      @transaction_identificator = "mj_id"
    end
    @params_to_display = {
      type: params[:type],
      id: params[:data][:id],
      created: params[:data][:created],
      updated: params[:data][:updated],
      description: params[:data][:description],
      amount: (params[:data][:amount].to_i / 100.0).round(2),
      currency: params[:data][:currency],
      local_amount: (params[:data][:local_amount].to_i / 100.0).round(2),
      local_currency: params[:data][:local_currency],
      notes: params[:data][:notes],
      category: params[:data][:category],
      type_account: @account_type,
    }
    @id = Digest::SHA256.hexdigest(params[:data][:id])[0, 5]
    @original_id = params[:data][:id]
    @redis = Redis.new
    @categories = ReceiveCategories.call
    price_in_gbp = (params[:data][:amount].to_i.abs / 100.0).round(2)
    @params = {
      price_in_gbp: price_in_gbp,
      price_in_usd: "= #{price_in_gbp.to_s.gsub(".", ",")} * #{CurrencyRate.call('GBP', 'USD').to_s.gsub(".", ",")}",
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
      text: "Выбери категорию чтобы сохранить #{@account_type} транзакцию:",
      reply_markup: { inline_keyboard:  categories_to_show },
    )
  end

  def save_to_redis
    @redis.set(@id, @params.to_json, ex: 2.weeks)
  end

  def categories_to_show
    categories = @categories.keys.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}:#{@transaction_identificator}:#{@id}:#{@params[:price_in_gbp]}" }
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
