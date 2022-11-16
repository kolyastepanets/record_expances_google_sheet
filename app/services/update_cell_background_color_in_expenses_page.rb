class UpdateCellBackgroundColorInExpensesPage < GetOrSetDataInGoogleSheetBase
  EVERY_DAY_EXPENSES_PAGE = 2079267030

  def initialize(response_after_save_expenses, should_divide_expenses)
    @response_after_save_expenses = response_after_save_expenses
    @should_divide_expenses = should_divide_expenses
  end

  def call
    return if !@should_divide_expenses

    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    @batch_update = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new
    @batch_update.requests = requests
    @batch_update
  end

  def make_request
    service_google_sheet.batch_update_spreadsheet(FIN_PLAN_SPREAD_SHEET_ID, @batch_update)
  end

  def parse_response
    # nothing to return
  end

  def requests
    [
      {
        update_cells: {
          range: {
            sheet_id: EVERY_DAY_EXPENSES_PAGE,
            start_row_index: line_number_saved_expenses,
            end_row_index: line_number_saved_expenses + 1,
            start_column_index: 2,
            end_column_index: 3
          },
          rows: [
            {
              values: [
                {
                  user_entered_format: {
                    background_color: {
                      red: 1,
                      green: 0.8,
                    }
                  }
                }
              ]
            }
          ],
          fields: "userEnteredFormat.backgroundColor"
        }
      }
    ]
  end

  def line_number_saved_expenses
    @line_number_saved_expenses ||= @response_after_save_expenses.table_range.split(":")[-1].match(/\d.*/)[0].to_i
  end
end
