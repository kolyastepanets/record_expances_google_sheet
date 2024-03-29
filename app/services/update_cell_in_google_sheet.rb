class UpdateCellInGoogleSheet < GetOrSetDataInGoogleSheetBase
  def initialize(money_to_save, coordinates_of_value_to_change, page: Date.today.year)
    @money_to_save = money_to_save
    @coordinates_of_value_to_change = coordinates_of_value_to_change
    @page = page
  end

  private

  def prepare_request_data
    @range = "#{@page}!#{@coordinates_of_value_to_change}"
    @values = [[@money_to_save]]
  end

  def make_request
    service_google_sheet.update_spreadsheet_value(
      ENV['FIN_PLAN_SPREAD_SHEET_ID'],
      @range,
      { values: @values },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    # nothing to return
  end
end
