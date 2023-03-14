class RecordTodayVisitKomankToGoogleSheet < GetOrSetDataInGoogleSheetBase
  def initialize
    @date_today = Date.today
  end

  private

  def prepare_request_data
    @values = [[
      @date_today.day,
      @date_today.month,
      @date_today.year,
      @date_today.strftime("%d.%m.%Y")
    ]]
    @range = "'Komank Ary'!A:D"
  end

  def make_request
    @response = service_google_sheet.append_spreadsheet_value(
      ENV['FIN_PLAN_SPREAD_SHEET_ID'],
      @range,
      { values: @values },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    @response.updates.updated_rows
  end
end
