class SendReminderToPayTaxes
  include CallableService

  def call
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: ReceiveCurrentMonthTaxesToPay.call,
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  end
end
