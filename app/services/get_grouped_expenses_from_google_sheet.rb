class GetGroupedExpensesFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN = 'A2'
  CATEGORY_INDEX = 0
  SUB_CATEGORY_INDEX = 1
  PRICE_INDEX = 2
  DAY_INDEX = 3
  MONTH_INDEX = 4
  YEAR_INDEX = 5
  MAX_CHARACTERS_FOR_CATEGORY = 13
  MAX_CHARACTERS_FOR_PRICE = 8
  EXPIRE_TIME = 30.minutes

  def initialize(category, months, year)
    @category = category
    @months = months
    @year = year
    @redis = Redis.new
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
      new_result << array_of_data if array_of_data[CATEGORY_INDEX] == @category && @months.include?(array_of_data[MONTH_INDEX]) && array_of_data[YEAR_INDEX] == @year
    end

    grouped_data = {}

    new_result.each do |array_of_data|
      if grouped_data[array_of_data[SUB_CATEGORY_INDEX]]
        grouped_data[array_of_data[SUB_CATEGORY_INDEX]] = (grouped_data[array_of_data[SUB_CATEGORY_INDEX]] + array_of_data[PRICE_INDEX].delete("$").gsub(",",".").to_f).round(2)
      else
        grouped_data[array_of_data[SUB_CATEGORY_INDEX]] = array_of_data[PRICE_INDEX].delete("$").gsub(",",".").to_f
      end
    end

    dash_category = "-"*MAX_CHARACTERS_FOR_CATEGORY
    dash_price = "-"*MAX_CHARACTERS_FOR_PRICE
    dash_space = " "*MAX_CHARACTERS_FOR_PRICE

    month_to_display = GenerateStringMaxLengthWithSpaces.call(Date::MONTHNAMES[@months.first.to_i], MAX_CHARACTERS_FOR_CATEGORY)
    year_to_display = GenerateStringMaxLengthWithSpaces.call(@year, MAX_CHARACTERS_FOR_PRICE)

    data_for_markdown_as_table = []
    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|"
    data_for_markdown_as_table << "|#{month_to_display}|#{year_to_display}|"
    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|"

    category_to_display = GenerateStringMaxLengthWithSpaces.call(@category, MAX_CHARACTERS_FOR_CATEGORY)
    data_for_markdown_as_table << "|#{category_to_display}|#{dash_space}|"

    grouped_data.sort_by { |_key, value| value }.each do |array_of_text|
      data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|"
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

    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|"
    sum_word_to_display = GenerateStringMaxLengthWithSpaces.call('Cумма', MAX_CHARACTERS_FOR_CATEGORY)
    sum_to_display = GenerateStringMaxLengthWithSpaces.call("$#{grouped_data.values.sum}", MAX_CHARACTERS_FOR_PRICE)
    data_for_markdown_as_table << "|#{sum_word_to_display}|#{sum_to_display}|"
    data_for_markdown_as_table << "|#{dash_category}|#{dash_price}|"

    data_for_markdown_as_table.join("\n")
  end
end
