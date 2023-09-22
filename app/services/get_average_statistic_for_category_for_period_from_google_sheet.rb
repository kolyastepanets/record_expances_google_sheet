class GetAverageStatisticForCategoryForPeriodFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN = 'A2'
  CATEGORY_INDEX = 0
  SUB_CATEGORY_INDEX = 1
  PRICE_INDEX = 2
  DAY_INDEX = 3
  MONTH_INDEX = 4
  YEAR_INDEX = 5
  MAX_CHARACTERS_FOR_CATEGORY = 13
  MAX_CHARACTERS_FOR_PRICE = 8
  TOTAL_MAX_CHARACTERS_WITHOUT_PIPE = 31
  EXPIRE_TIME = 30.minutes

  # start_month = "Nov"
  # start_year = "2022"
  # end_month = "Feb"
  # end_year = "2023"
  def initialize(category, start_month, start_year, end_month, end_year)
    @category = category
    @redis = Redis.new
    @start_month = start_month
    @start_year = start_year
    @end_month = end_month
    @end_year = end_year
    date_range = Date.parse("#{start_month} #{start_year}")..Date.parse("#{end_month} #{end_year}")
    @dates = (date_range).to_a
                         .select { |current_date| current_date.day == 1 }
                         .map { |current_date| { months: [current_date.month.to_s, "#{current_date.month},1"], year: current_date.year.to_s } }
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

    @response_values.each do |array_of_data|
      new_result << array_of_data if array_of_data[CATEGORY_INDEX] == @category && fit_date?(array_of_data[MONTH_INDEX], array_of_data[YEAR_INDEX])
    end

    grouped_data = {}

    new_result.each do |array_of_data|
      if grouped_data[array_of_data[SUB_CATEGORY_INDEX]]
        grouped_data[array_of_data[SUB_CATEGORY_INDEX]] = (grouped_data[array_of_data[SUB_CATEGORY_INDEX]] + array_of_data[PRICE_INDEX].gsub(/[[:space:]]+/, "").delete("$").gsub(",",".").to_f).round(2)
      else
        grouped_data[array_of_data[SUB_CATEGORY_INDEX]] = array_of_data[PRICE_INDEX].gsub(/[[:space:]]+/, "").delete("$").gsub(",",".").to_f
      end
    end

    dash_category = "-"*MAX_CHARACTERS_FOR_CATEGORY
    dash_price = "-"*MAX_CHARACTERS_FOR_PRICE
    dash_space = " "*MAX_CHARACTERS_FOR_PRICE
    range_to_display = GenerateStringMaxLengthWithSpaces.call("#{@start_month} #{@start_year} - #{@end_month} #{@end_year}, #{@dates.size} months", TOTAL_MAX_CHARACTERS_WITHOUT_PIPE)

    data_for_markdown_as_table = []
    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|#{dash_price}|"
    data_for_markdown_as_table << "|#{range_to_display}|"
    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|#{dash_price}|"

    category_to_display = GenerateStringMaxLengthWithSpaces.call(@category, MAX_CHARACTERS_FOR_CATEGORY)
    average_per_month = GenerateStringMaxLengthWithSpaces.call("Av per month", MAX_CHARACTERS_FOR_PRICE)
    data_for_markdown_as_table << "|#{category_to_display}|#{dash_space}|#{average_per_month}|"

    sorted_data = grouped_data.sort_by { |_key, value| value }
    sorted_data_with_average_price = sorted_data.map do |array_of_text|
      array_of_text.concat([(array_of_text[-1] / @dates.size).round(2)])
    end

    sorted_data_with_average_price.each do |array_of_text|
      data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|#{dash_price}|"
      current_string = ""

      array_of_text.each_with_index do |word, index|
        if index.zero?
          max_characters = MAX_CHARACTERS_FOR_CATEGORY
        else
          max_characters = MAX_CHARACTERS_FOR_PRICE
          word = "$#{word}"
        end

        wrapped_word = GenerateStringMaxLengthWithSpaces.call(word, max_characters)
        wrapped_word.prepend("|")
        wrapped_word << "|" if index == (array_of_text.size - 1)

        current_string << wrapped_word
      end

      data_for_markdown_as_table << current_string
    end

    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|#{dash_price}|"
    sum_word_to_display = GenerateStringMaxLengthWithSpaces.call('Cумма', MAX_CHARACTERS_FOR_CATEGORY)
    sum_to_display = GenerateStringMaxLengthWithSpaces.call("$#{grouped_data.values.sum}", MAX_CHARACTERS_FOR_PRICE)
    average_sum_to_display = GenerateStringMaxLengthWithSpaces.call("$#{(grouped_data.values.sum / @dates.size).round(2)}", MAX_CHARACTERS_FOR_PRICE)
    data_for_markdown_as_table << "|#{sum_word_to_display}|#{sum_to_display}|#{average_sum_to_display}|"
    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|#{dash_price}|"

    data_for_markdown_as_table.join("\n")
  end

  def fit_date?(month, year)
    @dates.any? do |date|
      date[:months].include?(month) && date[:year] == year
    end
  end
end
