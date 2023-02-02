class DeleteMessages
  include CallableService

  def initialize(message_ids)
    @message_ids = message_ids
  end

  def call
    @message_ids.each do |message_id|
      Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    end
  ensure
    key = "messages_at_#{Date.today.to_s}"
    Redis.new.del(key)
  end
end
