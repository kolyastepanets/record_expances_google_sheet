class DecreaseDollarsJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys

    result = CalculateTotalSpentUsdAndUah.call

    # decrease usd amount
    UpdateCellInGoogleSheet.call(
      result[:total_left_usd_money] - params[:dollars],
      result[:coordinates_of_total_left_usd_money],
    )

    SendNotificationMessageToBot.call(params)
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "Данные после сохранения: #{ReceiveUsdFopFromGoogleSheet.call}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
