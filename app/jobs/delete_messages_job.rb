class DeleteMessagesJob < ApplicationJob
  queue_as :default

  after_perform do
    redis = Redis.new
    key = "messages_at_#{Date.today.to_s}"
    redis.del(key)

    params = JSON.parse(@redis.get(@transaction_id))
    data = params.detect { |current_param| current_param.key?(:total_sum_categories) }

    message = @price_in_usd ? ReceiveUsdFopFromGoogleSheet.call : ReceiveCurrentBalanceInMonobankFromGoogleSheet.call
    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: "Данные после сохранения: #{message}")
  end

  def perform(message_ids, transaction_id, price_in_usd)
    @transaction_id = transaction_id
    @price_in_usd = price_in_usd

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
