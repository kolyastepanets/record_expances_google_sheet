class DeleteMessagesJob < ApplicationJob
  queue_as :default

  NIKOLAY_STEPANETS_CHAT_ID = 384435131

  def perform(message_ids)
    message_ids.each do |message_id|
      Telegram.bot.delete_message(chat_id: NIKOLAY_STEPANETS_CHAT_ID, message_id: message_id)
    end
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    NotifyEnteredExpencesFromWebhook.call(error_message)
  end
end
