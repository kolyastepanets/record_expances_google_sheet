class BeautifulParamsMessage
  include CallableService

  MAX_CHARACTERS = 14
  ORDER_ROWS = [:category_name, :sub_category_name, :description, :price_in_usd, :price_in_uah, :operation_amount, :currency_rate, :total_sum_of_money_before_save].freeze

  def initialize(params)
    @params = params
    @dashes = "-"*MAX_CHARACTERS
  end

  def call
    prepared_data = []
    prepared_data << ["Сохраненные данные:", ""]

    ORDER_ROWS.each do |key_name|
      prepared_data << [key_name, @params[key_name]]
    end


    data_for_markdown_as_table = []
    data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"

    prepared_data.each do |array_of_text|
      data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"
      current_string = ""

      array_of_text.each_with_index do |word, index|
        wrapped_word = GenerateStringMaxLengthWithSpaces.call(word, MAX_CHARACTERS)
        wrapped_word.prepend("|")
        wrapped_word << "|" if index == (array_of_text.size - 1)

        current_string << wrapped_word
      end

      data_for_markdown_as_table << current_string
    end

    data_for_markdown_as_table << "|#{@dashes}|#{@dashes}|"

    data_for_markdown_as_table.join("\n")
  end
end
