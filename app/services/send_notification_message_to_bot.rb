class SendNotificationMessageToBot
  include CallableService

  def initialize(params)
    @params = params
  end

  def call
    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: "Сохраненные данные: #{@params}")
  end
end
