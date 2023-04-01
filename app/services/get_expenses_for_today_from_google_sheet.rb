class GetExpensesForTodayFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  START_COLUMN_FROM_1_ST_SEPTEMBER_2022 = 'A5163' # start writing expenses in usd
  MAX_CHARACTERS_IN_STRING_COLUMN = 14
  MAX_ARRAY_SIZE_TO_FIT_TELEGRAM_MESSAGE_SIZE = 120
  EXPIRE_TIME = 30.minutes

  def initialize(requested_date_to_show_expenses)
    @dashes = "-"*MAX_CHARACTERS_IN_STRING_COLUMN
    @day_number = requested_date_to_show_expenses.day.to_s
    @month = requested_date_to_show_expenses.month.to_s
    @year = requested_date_to_show_expenses.year.to_s
    @current_date = Date.parse("#{@day_number}.#{@month}.#{@year}")
    @redis = Redis.new
  end

  private

  def prepare_request_data
    @range = "'Повседневные'!#{START_COLUMN_FROM_1_ST_SEPTEMBER_2022}:F"
  end

  def make_request
    expenses_for_today = @redis.get('expenses_for_today')
    if expenses_for_today.present?
      @response_values = JSON.parse(expenses_for_today)
      return @response_values
    end

    response_values_with_formula = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range, { value_render_option: 'FORMULA' }).values
    response_values_without_formula = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range).values
    @response_values = []
    response_values_with_formula.each_with_index do |array_of_text, index|
      extended_array = array_of_text + [response_values_without_formula[index][2]]
      @response_values << extended_array
    end
    save_to_redis!(@response_values)
  end

  def parse_response
    data_for_markdown_as_table = []
    data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"
    day_to_show = "#{@day_number} #{Date::MONTHNAMES[@month.to_i]} #{@year}, #{Date::DAYNAMES[@current_date.wday]}"
    wrapped_word_day_to_show = GenerateStringMaxLengthWithSpaces.call(day_to_show, 29)
    data_for_markdown_as_table << "|#{wrapped_word_day_to_show}|"

    @response_values.each do |array_of_text|
      next if !match_day?(array_of_text)

      data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"
      current_string = ""
      first_part_array_of_text = []
      second_part_array_of_text = []

      first_part_array_of_text << array_of_text[0] # category
      first_part_array_of_text << array_of_text[1] # sub category
      first_part_array_of_text << array_of_text[4] # month

      second_part_array_of_text << array_of_text[2] # price
      second_part_array_of_text << array_of_text[6] # calculated price

      first_part_array_of_text.each_with_index do |word, index|
        if index == 0
          max_characters = 6
        end
        if index == 1
          max_characters = 7
        end
        if index == 2
          max_characters = 14
          word = word.to_s.include?(".") ? "кэш" : ""
        end
        wrapped_word = GenerateStringMaxLengthWithSpaces.call(word, max_characters)
        wrapped_word.prepend("|")
        wrapped_word << "|" if index == (first_part_array_of_text.size - 1)

        current_string << wrapped_word
      end
      data_for_markdown_as_table << current_string
      data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"

      current_string = ""
      second_part_array_of_text.each_with_index do |word, index|
        word = word.to_s.gsub(/[[:space:]]+/, "")
        if index == 0
          max_characters = 22
        end
        if index == 1
          max_characters = 7
          word = " #{word}"
        end
        wrapped_word = GenerateStringMaxLengthWithSpaces.call(word, max_characters)
        wrapped_word.prepend("|") if index != (second_part_array_of_text.size - 1)
        wrapped_word << "|" if index == (second_part_array_of_text.size - 1)

        current_string << wrapped_word
      end
      data_for_markdown_as_table << current_string
    end

    data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"
    data_for_markdown_as_table.each_slice(MAX_ARRAY_SIZE_TO_FIT_TELEGRAM_MESSAGE_SIZE).to_a
  end

  def save_to_redis!(values)
    return if @redis.get('expenses_for_today').present?

    @redis.set('expenses_for_today', values.to_json, ex: EXPIRE_TIME)
  end

  def match_day?(array_of_text)
    array_of_text[3].to_s == @day_number &&
      (array_of_text[4].to_s == @month || array_of_text[4].to_s == "#{@month}.1") &&
      array_of_text[5].to_s == @year
  end
end
