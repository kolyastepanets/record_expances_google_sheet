class DeleteMessagesJob < ApplicationJob
  queue_as :default

  def perform(message_ids)
    key = "messages_at_#{Date.today.to_s}"
    Redis.new.del(key)

    message_ids.each do |message_id|
      Telegram.bot.delete_message(chat_id: ENV['MY_TELEGRAM_ID'], message_id: message_id)
    end
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message)
    else
      raise e
    end
  end
end
