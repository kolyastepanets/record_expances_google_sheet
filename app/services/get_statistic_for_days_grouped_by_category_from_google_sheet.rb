class GetStatisticForDaysGroupedByCategoryFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN = 'A2'
  DAY_INDEX = 3
  MONTH_INDEX = 4
  YEAR_INDEX = 5
  MAX_CHARACTERS_IN_STRING_COLUMN = 9
  MAX_ARRAY_SIZE_TO_FIT_TELEGRAM_MESSAGE_SIZE = 120

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    date_range = Date.parse(start_date)..Date.parse(end_date)
    @dates = (date_range).to_a
                         .map { |current_date| { day: current_date.day.to_s, months: [current_date.month.to_s, "#{current_date.month},1"], year: current_date.year.to_s } }
  end

  private

  def prepare_request_data
    @range = "'Повседневные'!#{START_COLUMN}:F"
  end

  def make_request
    @response_values = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range).values
  end

  def parse_response
    new_result = []
    data_for_markdown_as_table = []
    total_sum = 0

    @response_values.each do |array_of_data|
      next if array_of_data[0] == "Кэш"
      next if !fit_date?(array_of_data[DAY_INDEX], array_of_data[MONTH_INDEX], array_of_data[YEAR_INDEX])

      new_array = []
      new_array << array_of_data[0] # category
      new_array << array_of_data[1] # sub category
      new_array << array_of_data[2] # price
      new_array << "#{array_of_data[3]}-#{array_of_data[4]}" # day-month
      new_result << new_array
    end

    grouped_data = new_result.each { |item| item[2] = item[2].gsub(/[[:space:]]+/, "").delete("$").gsub(",", ".").to_f }.group_by { |item| item[0] }

    grouped_data.each do |category, items|
      subcategories = items.group_by { |item| item[1] }
      items.clear
      subcategories.each do |subcategory, sub_items|
        items << [category, subcategory, sub_items.sum { |item| item[2] }.round(2), ""]
      end
      items.sort_by! { |item| item[2] }
    end

    sorted_data = grouped_data.sort_by { |category, items| items.sum { |item| item[2] } }

    result_3 = []

    sorted_data.each do |category, items|
      items.each do |item|
        result_3 << item - [item[-1]]
      end
      result_3 << ["", "", items.sum { |item| item[2] }.round(2)]
    end

    dash = "-"*MAX_CHARACTERS_IN_STRING_COLUMN
    spaces = " "*MAX_CHARACTERS_IN_STRING_COLUMN

    result_3.each do |array_of_text|
      data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|"
      current_string = ""
      array_of_text.each_with_index do |word, index|
        if index == 2 && word.is_a?(Float) && array_of_text[index - 1].blank?
          total_sum += word
        end

        how_many_spaces_to_add = MAX_CHARACTERS_IN_STRING_COLUMN - word.to_s.size
        wrapped_word = "|#{word.to_s.truncate(MAX_CHARACTERS_IN_STRING_COLUMN, omission: '')}"
        how_many_spaces_to_add.times do
          wrapped_word << " "
        end
        wrapped_word << "|" if index == (array_of_text.size - 1)

        current_string << wrapped_word
      end
      data_for_markdown_as_table << current_string
    end
    data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|"
    data_for_markdown_as_table << "|#{spaces}|#{spaces}|#{prepare_total_sum(total_sum)}|"
    data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|"

    data_for_markdown_as_table.each_slice(MAX_ARRAY_SIZE_TO_FIT_TELEGRAM_MESSAGE_SIZE).to_a
  end

  def prepare_total_sum(total_sum)
    total_sum_to_show = "$#{total_sum.round(2)}"
    how_many_spaces_to_add = MAX_CHARACTERS_IN_STRING_COLUMN - total_sum_to_show.size
    wrapped_word = "#{total_sum_to_show.truncate(MAX_CHARACTERS_IN_STRING_COLUMN, omission: '')}"
    how_many_spaces_to_add.times do
      wrapped_word << " "
    end
    wrapped_word
  end

  def fit_date?(day, month, year)
    @dates.any? do |date|
      date[:day] == day && date[:months].include?(month) && date[:year] == year
    end
  end
end
