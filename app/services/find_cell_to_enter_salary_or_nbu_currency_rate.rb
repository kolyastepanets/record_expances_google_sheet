class FindCellToEnterSalaryOrNbuCurrencyRate < GetOrSetDataInGoogleSheetBase
  COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)

  def initialize(month, year_sheet, cell_with_text_to_find_next_cell)
    @month = month
    @year_sheet = year_sheet
    @cell_with_text_to_find_next_cell = cell_with_text_to_find_next_cell
  end

  private

  def prepare_request_data
    @range = "#{@year_sheet}!A#{start_line_to_search}:CJ#{end_line_to_search}"
  end

  def end_line_to_search
    85
  end

  def parse_response
    index_line_to_remember = 0
    index_column_to_remember = 0

    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        index_column_to_remember = index if value == @month.to_s
      end
      break if !index_column_to_remember.zero?
    end

    index_value_to_update = index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == @cell_with_text_to_find_next_cell
          index_line_to_remember = value_array_index
        end
      end
    end

    coordinates_of_cell_to_enter_salary = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"
    coordinates_of_cell_to_enter_salary
  end
end
