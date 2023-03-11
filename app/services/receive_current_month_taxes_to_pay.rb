class ReceiveCurrentMonthTaxesToPay < GetOrSetDataInGoogleSheetBase
  KEY_FIND_CELL_TAXES_IN_UAH = "Налоги в грн".freeze
  COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)

  private

  def end_line_to_search
    85
  end

  def parse_response
    index_line_to_remember = 0
    index_column_to_remember = 0
    taxes_amount = ''

    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        index_column_to_remember = index if value.to_s == Date.today.month.to_s
      end
      break if !index_column_to_remember.zero?
    end

    index_value_to_update = index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_TAXES_IN_UAH
          index_line_to_remember = value_array_index
          taxes_amount = value_array[index_value_to_update]
        end
        break if taxes_amount.is_a?(String) && taxes_amount.present?
      end
    end
    taxes_amount_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    {
      taxes_amount: taxes_amount,
      taxes_amount_coordinates: taxes_amount_coordinates,
      full_text: "To pay taxes in #{Date::MONTHNAMES[Date.today.month]}: #{taxes_amount} uah",
    }
  end
end
