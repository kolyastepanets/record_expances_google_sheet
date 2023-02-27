class GetGroupedExpensesFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN_FROM_1_ST_SEPTEMBER_2022 = 'A5163' # start writing expenses in usd
  CATEGORY_INDEX = 0
  SUB_CATEGORY_INDEX = 1
  PRICE_INDEX = 2
  DAY_INDEX = 3
  MONTH_INDEX = 4
  YEAR_INDEX = 5
  MAX_CHARACTERS_FOR_CATEGORY = 13
  MAX_CHARACTERS_FOR_PRICE = 8

  def initialize(category, months, year)
    @category = category
    @months = months
    @year = year
  end

  private

  def prepare_request_data
    @range = "'Повседневные'!#{START_COLUMN_FROM_1_ST_SEPTEMBER_2022}:F"
  end

  def parse_response
    new_result = []

    @response.values.each do |array_of_data|
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
