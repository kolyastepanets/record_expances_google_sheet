class UpdateCellBackgroundColorRequest < GetOrSetDataInGoogleSheetBase
  def initialize(sheet_id, line_number_saved_expenses, color)
    @sheet_id = sheet_id
    @line_number_saved_expenses = line_number_saved_expenses
    @color = color
  end

  def call
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
            sheet_id: @sheet_id,
            start_row_index: @line_number_saved_expenses,
            start_column_index: 2,
            end_column_index: 3
          },
          rows: [
            {
              values: [
                {
                  user_entered_format: {
                    background_color: {
                      **detect_hash_color,
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

  def detect_hash_color
    if @color == 'yellow'
      return { red: 1, green: 0.8 }
    end

    if @color == 'green'
      return { green: 0.8 }
    end

    if @color == 'orange'
      return { red: 1, green: 0.4 }
    end
  end
end
