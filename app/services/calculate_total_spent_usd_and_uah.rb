class CalculateTotalSpentUsdAndUah < GetOrSetDataInGoogleSheetBase
  include CallableService

  KEY_FIND_CELL_SPENT_UAH_MONEY = "Продал валюту".freeze
  # KEY_FIND_CELL_SPENT_UAH_MONEY = "Осталось черная моно грн".freeze
  KEY_FIND_CELL_LEFT_USD_MONEY = "Осталось ФОП моно $".freeze
  COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)

  def initialize
    @current_month = Date.today.month
  end

  private

  def end_line_to_search
    110
  end

  def parse_response
    index_line_to_remember = 0
    index_column_to_remember = 0
    total_spent_uah_money = 0
    total_left_usd_money = 0

    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        index_column_to_remember = index if value == @current_month.to_s
      end
    end

    index_value_to_update = index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_UAH_MONEY
          index_line_to_remember = value_array_index
          total_spent_uah_money = value_array[index_value_to_update]
        end
      end
    end
    total_spent_uah_money = total_spent_uah_money.gsub(/[[:space:]]+/, "")
    total_spent_uah_money = total_spent_uah_money.remove("грн") if total_spent_uah_money.include?("грн")
    coordinates_of_total_spent_uah_money = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_LEFT_USD_MONEY
          index_line_to_remember = value_array_index
          total_left_usd_money = value_array[index_value_to_update]
        end
      end
    end
    total_left_usd_money = total_left_usd_money.gsub(/[[:space:]]+/, "")
    total_left_usd_money = total_left_usd_money.remove("$") if total_left_usd_money.include?("$")
    coordinates_of_total_left_usd_money = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    {
      total_spent_uah_money: total_spent_uah_money.to_f,
      coordinates_of_total_spent_uah_money: coordinates_of_total_spent_uah_money,
      total_left_usd_money: total_left_usd_money.to_f,
      coordinates_of_total_left_usd_money: coordinates_of_total_left_usd_money,
    }
  end
end