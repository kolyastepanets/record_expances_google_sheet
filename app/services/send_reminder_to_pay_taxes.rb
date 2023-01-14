class SendReminderToPayTaxes
  include CallableService

  def call
    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: ReceiveCurrentMonthTaxesToPay.call)
  end
end
