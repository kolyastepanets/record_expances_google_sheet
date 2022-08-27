class NotifyEnteredExpencesFromWebhook
  include CallableService

  NIKOLAY_STEPANETS_CHAT_ID = 384435131

  def initialize(params)
    @params = params
  end

  def call
    Telegram.bot.send_message(chat_id: NIKOLAY_STEPANETS_CHAT_ID, text: @params)
  end
end
