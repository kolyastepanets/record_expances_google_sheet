class SaveDataFromMonoWebhook < GetOrSetDataInGoogleSheetBase
  def initialize(params)
    @params = params
  end

  private

  def prepare_request_data
    @range = "'monowebhook'!A:A"
  end

  def make_request
    @response = service_google_sheet.append_spreadsheet_value(
      FIN_PLAN_SPREAD_SHEET_ID,
      @range,
      { values: [[@params.to_s]] },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    @response
  end
end
