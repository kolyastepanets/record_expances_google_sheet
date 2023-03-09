class ReceiveCurrentSheetsInfo < GetOrSetDataInGoogleSheetBase
  private

  def make_request
    @response = service_google_sheet.get_spreadsheet(ENV['FIN_PLAN_SPREAD_SHEET_ID'])
  end

  def parse_response
    result = []

    @response.to_h[:sheets].each do |page|
      result << { sheet_id: page[:properties][:sheet_id], title: page[:properties][:title] }
    end

    result
  end
end
