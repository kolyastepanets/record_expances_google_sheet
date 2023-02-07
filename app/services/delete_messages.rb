class DeleteMessages
  include CallableService

  def initialize(message_ids)
    @message_ids = message_ids
  end

  def call
    key = "messages_at_#{Date.today.to_s}"
    Redis.new.del(key)

    @message_ids.each do |message_id|
      delete_message(message_id)
    end

    nil
  end

  private

  def delete_message(message_id)
    Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
  rescue Telegram::Bot::Error => e
    if e.message != "Bad Request: Bad Request: message to delete not found"
      raise e
    end
  end
end
