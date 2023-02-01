class EnterSalaryFromSwiftJob < ApplicationJob
  queue_as :default

  def perform(params)
    EnterSalaryFromSwift.call(params)
    SendNotificationMessageToBot.call(params)
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "Данные после сохранения: #{ReceiveUsdFopFromGoogleSheet.call}",
      reply_markup: {
        keyboard: AllConstants::MAIN_BUTTONS,
        resize_keyboard: true,
        one_time_keyboard: true,
        is_persistent: false,
        selective: true,
      }
    )
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message)
    else
      raise e
    end
  end
end
