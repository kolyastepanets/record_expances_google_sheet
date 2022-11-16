class GetGoogleSheetCurrencyExchange < GetOrSetDataInGoogleSheetBase
  MONTH_POINT_ONE = ",1".freeze
  CURRENCY_UAH_FOREIGN = "курс гривна/валюта".freeze

  def initialize
    @current_month = Date.today.month
  end

  private

  def start_line_to_search
    60
  end

  def end_line_to_search
    80
  end

  def parse_response
    last_value_key_index = 0
    last_value_value_index = 0
    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        if value == "#{@current_month}#{MONTH_POINT_ONE}"
          last_value_key_index = index
          last_value_value_index = index + 1
        end
      end
    end

    currency_foreign_uah = ""
    @response.values.each do |value_array|
      if value_array[last_value_key_index] == CURRENCY_UAH_FOREIGN
        currency_foreign_uah = value_array[last_value_value_index]
      end
    end

    currency_foreign_uah
  end
end
