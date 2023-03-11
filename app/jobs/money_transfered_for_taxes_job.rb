class MoneyTransferedForTaxesJob < ApplicationJob
  queue_as :default

  def perform(params)
    params.deep_symbolize_keys!

    current_sheets_info = ReceiveCurrentSheetsInfo.call
    sheet_id = current_sheets_info.detect { |sheet| sheet[:title] == Date.today.year.to_s }[:sheet_id]
    row_index = params[:taxes_amount_coordinates].delete('^0-9').to_i - 1
    letter = params[:taxes_amount_coordinates].delete('^A-Z')
    column_index = letter.ord - 'A'.ord
    UpdateCellBackgroundColorRequest.call(sheet_id, row_index, column_index, 'green')

    SendNotificationMessageToBot.call("tax column marked as green")
  end
end
