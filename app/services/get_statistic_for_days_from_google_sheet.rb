class GetStatisticForDaysFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN = 'A2'
  DAY_INDEX = 3
  MONTH_INDEX = 4
  YEAR_INDEX = 5
  EXPIRE_TIME = 30.minutes
  MAX_CHARACTERS_IN_STRING_COLUMN = 7
  MAX_ARRAY_SIZE_TO_FIT_TELEGRAM_MESSAGE_SIZE = 120

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @redis = Redis.new
    date_range = Date.parse(start_date)..Date.parse(end_date)
    @dates = (date_range).to_a
                         .map { |current_date| { day: current_date.day.to_s, months: [current_date.month.to_s, "#{current_date.month},1"], year: current_date.year.to_s } }
  end

  private

  def prepare_request_data
    @range = "'Повседневные'!#{START_COLUMN}:F"
  end

  def make_request
    all_expenses = @redis.get('all_expenses')
    if all_expenses.present?
      @response_values = JSON.parse(all_expenses)
      return @response_values
    end

    @response_values = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range).values
    @redis.set('all_expenses', @response_values.to_json, ex: EXPIRE_TIME)
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

    dash = "-"*MAX_CHARACTERS_IN_STRING_COLUMN
    spaces = " "*MAX_CHARACTERS_IN_STRING_COLUMN

    new_result.each do |array_of_text|
      data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|#{dash}|"
      current_string = ""
      array_of_text.each_with_index do |word, index|
        if word.include?("$")
          price = word.delete("$").gsub(",", ".").to_f
          total_sum += price
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
    data_for_markdown_as_table << "|#{spaces}|#{spaces}|#{prepare_total_sum(total_sum)}|#{spaces}|"
    data_for_markdown_as_table << "|#{dash}|#{dash}|#{dash}|#{dash}|"

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
