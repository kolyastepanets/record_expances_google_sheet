module ApiGoogleSheet
  class GetLastThreeExpensesInGoogleSheet < GetOrSetDataInGoogleSheetBase
    private

    def prepare_request_data
      @range = "'Повседневные'!A2500:F"
    end

    def parse_response
      @response.values.last(3).map do |line|
        line.first(3).push('грн').join(' ') + ', ' + line.last(3).join('-')
      end.unshift('Последние 3 траты в google sheet:').join("\n")
    end
  end
end
