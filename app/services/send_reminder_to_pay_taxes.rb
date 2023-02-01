class SendReminderToPayTaxes
  include CallableService

  def call
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: ReceiveCurrentMonthTaxesToPay.call,
      reply_markup: {
        keyboard: AllConstants::MAIN_BUTTONS,
        resize_keyboard: true,
        one_time_keyboard: true,
        is_persistent: false,
        selective: true,
      }
    )
  end
end
