class FindCellValueInEveryDayExpensesPage < GetOrSetDataInGoogleSheetBase
  def initialize(coordinates_of_value)
    @coordinates_of_value = coordinates_of_value
  end

  private

  def prepare_request_data
    @range = "'Повседневные'!C#{@coordinates_of_value}"
  end

  def make_request
    @response = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range, { value_render_option: 'FORMULA' })
  end

  def parse_response
    return nil if @response.values.nil?

    @response.values[0][0]
  end
end
