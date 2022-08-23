# code is cool, but it seems useless :((
# because it is better to take usd/uah on current day.
# For example
# today sold $1000, it will be 29_000 uah
# in 1 week currency exchange will be 1 usd / 35 uah
# so in market I will spend less than $1000 => $828
class FindLatestCurrencyExchangeUsdToUahFromFop < GetOrSetDataInGoogleSheetBase
  include CallableService

  KEY_FIND_CELL_CURRENCY_EXCHANGE_FIRST_HALF_MONTH = "курс доллара 1ая зп".freeze
  KEY_FIND_CELL_CURRENCY_EXCHANGE_SECOND_HALF_MONTH = "курс доллара 2ая зп".freeze
  CURRENCY_EXCHANGE_IS_NOT_SET = 1.0
  COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CN').to_a)

  def initialize
    @current_month = Date.today.month
  end

  private

  def end_line_to_search
    75
  end

  def parse_response
    @index_line_to_remember = 0
    @index_column_to_remember = 0
    @currency_exchange_usd_to_uah = 0

    loop do
      find_in_second_half_month
      break @currency_exchange_usd_to_uah if @currency_exchange_usd_to_uah > CURRENCY_EXCHANGE_IS_NOT_SET

      find_in_first_half_month
      break @currency_exchange_usd_to_uah if @currency_exchange_usd_to_uah > CURRENCY_EXCHANGE_IS_NOT_SET

      @current_month = @current_month - 1
    end

    @currency_exchange_usd_to_uah
  end

  def find_in_second_half_month
    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        @index_column_to_remember = index if value == @current_month.to_s
      end
    end

    @index_value_to_update = @index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_CURRENCY_EXCHANGE_SECOND_HALF_MONTH
          index_line_to_remember = value_array_index
          @currency_exchange_usd_to_uah = value_array[@index_value_to_update]
        end
      end
    end

    @currency_exchange_usd_to_uah = @currency_exchange_usd_to_uah.gsub(",", ".").to_f
  end

  def find_in_first_half_month
    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_CURRENCY_EXCHANGE_FIRST_HALF_MONTH
          index_line_to_remember = value_array_index
          @currency_exchange_usd_to_uah = value_array[@index_value_to_update]
        end
      end
    end

    @currency_exchange_usd_to_uah = @currency_exchange_usd_to_uah.gsub(",", ".").to_f
  end
end
