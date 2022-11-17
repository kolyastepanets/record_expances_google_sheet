module ApiGoogleSheet
  class CalculateForeignCurrencyCashExpenses < GetOrSetDataInGoogleSheetBase
    KEY_FIND_CELL_TOTAL_MONEY = "Всего денег:".freeze
    KEY_FIND_CELL_SPENT_MONEY = "Потрачено денег:".freeze
    KEY_FIND_CELL_NOW_MONEY = "Сейчас денег:".freeze
    MONTH_POINT_ONE = ",1".freeze
    COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)

    def initialize
      @current_month = Date.today.month
    end

    private

    def parse_response
      index_line_to_remember = 0
      index_column_to_remember = 0
      total_withraw_foreign_money = 0
      spent_foreign_money = 0
      now_foreign_money = 0

      @response.values.each do |value_array|
        value_array.each_with_index do |value, index|
          index_column_to_remember = index if value == "#{@current_month}#{MONTH_POINT_ONE}"
        end
      end

      index_value_to_update = index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

      @response.values.each_with_index do |value_array, value_array_index|
        value_array.each do |value|
          if value == KEY_FIND_CELL_TOTAL_MONEY
            index_line_to_remember = value_array_index
            total_withraw_foreign_money = value_array[index_value_to_update]
          end
        end
      end

      @response.values.each_with_index do |value_array, value_array_index|
        value_array.each do |value|
          if value == KEY_FIND_CELL_SPENT_MONEY
            index_line_to_remember = value_array_index
            spent_foreign_money = value_array[index_value_to_update]
          end
        end
      end
      coordinates_of_value_spent_money = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

      @response.values.each_with_index do |value_array, value_array_index|
        value_array.each do |value|
          if value == KEY_FIND_CELL_NOW_MONEY
            index_line_to_remember = value_array_index
            now_foreign_money = value_array[index_value_to_update]
          end
        end
      end
      coordinates_of_value_now_money = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

      {
        total_withraw_foreign_money: total_withraw_foreign_money.to_f,
        spent_foreign_money: spent_foreign_money.to_f,
        now_foreign_money: now_foreign_money.to_f,
        coordinates_of_value_to_change_spent_foreign_money: coordinates_of_value_spent_money,
        coordinates_of_value_to_change_now_foreign_money: coordinates_of_value_now_money,
      }
    end
  end
end
