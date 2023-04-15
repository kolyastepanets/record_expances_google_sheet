class GetStatisticByKomankForTwoMonthsFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN = 'A2'
  MONTH_INDEX = 1
  YEAR_INDEX = 2
  FULL_DATE_INDEX = 3
  PAID_COLUMN_INDEX = 4
  MAX_CHARACTERS = 12

  def initialize
    @previous_month = (Date.today.month - 1).to_s
    @current_month = Date.today.month.to_s
    @year = Date.today.year.to_s
  end

  private

  def prepare_request_data
    @range = "'Komank Ary'!#{START_COLUMN}:E"
  end

  def parse_response
    data_for_2_months = []

    @response.values.each do |array_of_data|
      data_for_2_months << [array_of_data[FULL_DATE_INDEX], array_of_data[PAID_COLUMN_INDEX]] if [@previous_month, @current_month].include?(array_of_data[MONTH_INDEX]) && array_of_data[YEAR_INDEX] == @year
    end

    dashes = "-"*MAX_CHARACTERS
    date_to_display = GenerateStringMaxLengthWithSpaces.call('Date', MAX_CHARACTERS)
    price_to_display = GenerateStringMaxLengthWithSpaces.call('Paid', MAX_CHARACTERS)

    data_for_markdown_as_table = []
    data_for_markdown_as_table << "|#{dashes}|#{dashes}|"
    data_for_markdown_as_table << "|#{date_to_display}|#{price_to_display}|"

    data_for_2_months.each do |array_of_text|
      data_for_markdown_as_table << "|#{dashes}|#{dashes}|"
      current_string = ""

      array_of_text.each_with_index do |word, index|
        wrapped_word = GenerateStringMaxLengthWithSpaces.call(word, MAX_CHARACTERS)
        wrapped_word.prepend("|")
        wrapped_word << "|" if index == (array_of_text.size - 1)

        current_string << wrapped_word
      end

      data_for_markdown_as_table << current_string
    end

    data_for_markdown_as_table << "|#{dashes}|#{dashes}|"

    data_for_markdown_as_table.join("\n")
  end
end
