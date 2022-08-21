class UpdateCommonCurrencyExpenses < GetOrSetDataInGoogleSheetBase
  include CallableService

  VALUE_INPUT_OPTION = 'USER_ENTERED'.freeze

  def initialize(money_to_save, coordinates_of_value_to_change)
    @money_to_save = money_to_save
    @coordinates_of_value_to_change = coordinates_of_value_to_change
  end

  private

  def prepare_request_data
    @range = "#{Date.today.year}!#{@coordinates_of_value_to_change}"
    @values = [[@money_to_save]]
  end

  def make_request
    service_google_sheet.update_spreadsheet_value(
      FIN_PLAN_SPREAD_SHEET_ID,
      @range,
      { values: @values },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    # nothing to return
  end
end
