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

    taxes_info = ReceiveCurrentMonthTaxesToPay.call
    current_sheets_info = ReceiveCurrentSheetsInfo.call
    sheet_id = current_sheets_info.detect { |sheet| sheet[:title] == Date.today.year.to_s }[:sheet_id]
    row_index = taxes_info[:taxes_amount_coordinates].delete('^0-9').to_i - 1
    letter = taxes_info[:taxes_amount_coordinates].delete('^A-Z')
    column_index = letter.ord - 'A'.ord
    UpdateCellBackgroundColorRequest.call(sheet_id, row_index, column_index, 'green')
    SendNotificationMessageToBot.call("tax column marked as green")

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
