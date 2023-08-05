class FindCellsCurrentMonth < GetOrSetDataInGoogleSheetBase
  HOW_MANY_COLUMNS_TAKE = 3
  MAX_CHARACTERS_IN_STRING_COLUMN = 7

  def initialize(month, year)
    @month = month
    @year = year
  end

  private

  def prepare_request_data
    @range = "#{@year}!A#{start_line_to_search}:CJ#{end_line_to_search}"
  end

  def start_line_to_search
    60
  end

  def end_line_to_search
    103
  end

  def parse_response
    all_month_data = []
    index_line_to_remember = 0
    index_column_to_remember = 0

    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        index_column_to_remember = index if value == @month
      end
      break if !index_column_to_remember.zero?
    end

    @response.values.each do |value_array|
      all_month_data << value_array[index_column_to_remember..(index_column_to_remember + HOW_MANY_COLUMNS_TAKE)]
    end

    data_for_markdown_as_table = []

    can_add = false
    dash = "-"*MAX_CHARACTERS_IN_STRING_COLUMN

    all_month_data.compact.each do |array_of_text|
      can_add = true if array_of_text[1] == 'План'

      next if !can_add

      data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|#{dash}|"
      current_string = ""
      array_of_text.each_with_index do |word, index|
        if word.include?("$")
          word = word.split(',')[0]
        end
        how_many_spaces_to_add = MAX_CHARACTERS_IN_STRING_COLUMN - word.size
        wrapped_word = "|#{word.truncate(MAX_CHARACTERS_IN_STRING_COLUMN, omission: '')}"
        how_many_spaces_to_add.times do
          wrapped_word << " "
        end
        wrapped_word << "|" if index == (array_of_text.size - 1)

        current_string << wrapped_word
      end
      data_for_markdown_as_table << current_string
    end
    data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|#{dash}|"

    data_for_markdown_as_table.join("\n")
  end
end
