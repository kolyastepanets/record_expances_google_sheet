class FindCellValueInEveryDayExpensesPage < GetOrSetDataInGoogleSheetBase
  def initialize(coordinates_of_value)
    @coordinates_of_value = coordinates_of_value
  end

  private

  def prepare_request_data
    @range = "'Повседневные'!C#{@coordinates_of_value}"
  end

  def parse_response
    return nil if @response.values.nil?

    @response.values[0][0]
  end
end
