class CalculateForeignCurrencyCashExpenses < GetOrSetDataInGoogleSheetBase
  KEY_FIND_CELL_WITHDRAW_FOREIGN_MONEY = "снял валюты".freeze
  KEY_FIND_CELL_CURRENCY_RATE_UAH_TO_FOREIGH_CURRENCY = "курс гривна/валюта".freeze
  KEY_FIND_CELL_TOTAL_MONEY = "Всего денег:".freeze
  KEY_FIND_CELL_SPENT_MONEY = "Потрачено денег:".freeze
  KEY_FIND_CELL_NOW_MONEY = "Сейчас денег:".freeze
  MONTH_POINT_ONE = ".1".freeze

  def initialize
    @current_month = Date.today.month
    @value_render_option = 'FORMULA'
  end

  private

  def make_request
    @response = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range, value_render_option: @value_render_option)
  end

  def parse_response
    index_line_to_remember = 0
    index_column_to_remember = 0
    withdraw_foreign_money = ''
    currency_rate_uah_to_foreigh_currency = ''
    total_withraw_foreign_money = 0
    spent_foreign_money = 0
    now_foreign_money = 0
    calculated_total_withraw_foreign_money = 0

    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        index_column_to_remember = index if value.to_s == "#{@current_month}#{MONTH_POINT_ONE}"
      end
      break if !index_column_to_remember.zero?
    end

    index_value_to_update = index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_WITHDRAW_FOREIGN_MONEY
          index_line_to_remember = value_array_index
          withdraw_foreign_money = value_array[index_value_to_update]
        end
        break if withdraw_foreign_money.is_a?(String) && withdraw_foreign_money.present?
      end
    end
    coordinates_of_value_to_change_withdraw_foreign_money = "#{AllConstants::ALL_COLUMN_LETTERS[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_CURRENCY_RATE_UAH_TO_FOREIGH_CURRENCY
          index_line_to_remember = value_array_index
          currency_rate_uah_to_foreigh_currency = value_array[index_value_to_update]
        end
        break if currency_rate_uah_to_foreigh_currency.is_a?(String) && currency_rate_uah_to_foreigh_currency.present?
      end
    end
    coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency = "#{AllConstants::ALL_COLUMN_LETTERS[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_TOTAL_MONEY
          index_line_to_remember = value_array_index
          total_withraw_foreign_money = value_array[index_value_to_update]
        end
      end
    end
    coordinates_of_total_withraw_foreign_money_formula = "#{AllConstants::ALL_COLUMN_LETTERS[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_MONEY
          index_line_to_remember = value_array_index
          spent_foreign_money = value_array[index_value_to_update].to_f
        end
      end
    end
    coordinates_of_value_to_change_spent_foreign_money = "#{AllConstants::ALL_COLUMN_LETTERS[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_NOW_MONEY
          index_line_to_remember = value_array_index
          now_foreign_money = value_array[index_value_to_update].to_f
        end
      end
    end
    coordinates_of_value_to_change_now_foreign_money = "#{AllConstants::ALL_COLUMN_LETTERS[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @value_render_option = 'UNFORMATTED_VALUE'
    make_request

    @response.values.each do |value_array|
      value_array.each_with_index do |value, value_index|
        if value == KEY_FIND_CELL_TOTAL_MONEY
          calculated_total_withraw_foreign_money = value_array[index_value_to_update].to_f
        end
        break if !calculated_total_withraw_foreign_money.zero?
      end
    end

    @response.values.each do |value_array|
      value_array.each_with_index do |value, value_index|
        if value == KEY_FIND_CELL_NOW_MONEY
          now_foreign_money = value_array[index_value_to_update].to_f
        end
        break if !now_foreign_money.zero?
      end
    end

    {
      withdraw_foreign_money: withdraw_foreign_money,
      coordinates_of_value_to_change_withdraw_foreign_money: coordinates_of_value_to_change_withdraw_foreign_money,

      currency_rate_uah_to_foreigh_currency: currency_rate_uah_to_foreigh_currency,
      coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency: coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency,

      spent_foreign_money: spent_foreign_money,
      coordinates_of_value_to_change_spent_foreign_money: coordinates_of_value_to_change_spent_foreign_money,

      now_foreign_money: now_foreign_money,
      coordinates_of_value_to_change_now_foreign_money: coordinates_of_value_to_change_now_foreign_money,

      total_withraw_foreign_money: calculated_total_withraw_foreign_money,
      total_withraw_foreign_money_formula: total_withraw_foreign_money,
      coordinates_of_total_withraw_foreign_money_formula: coordinates_of_total_withraw_foreign_money_formula,
    }
  end
end
