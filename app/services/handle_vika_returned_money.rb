class HandleVikaReturnedMoney
  include CallableService

  MAKE_REQUEST_EVERY = 10.seconds

  def initialize(price, type_returned)
    @price = price
    @type_returned = type_returned
  end

  def call
    result = FindCellToEnterVikaHalfExpenses.call

    coordinates = result[:vika_total_sum_mono_cells].split('-') if @type_returned == 'uah'
    coordinates = result[:vika_total_sum_cash_cells].split('-') if @type_returned == 'cash'

    coordinates.each do |coordinates_of_value|
      DividePriceAndMakeCellGreenJob.set(wait: MAKE_REQUEST_EVERY).perform_later(coordinates_of_value)
    end

    if @type_returned == 'uah'
      vika_total_sum_mono = "= #{result[:vika_total_sum_mono].to_s.split('.')[0]} - #{@price.to_s.split('.')[0]}"
      UpdateCellInGoogleSheet.call(vika_total_sum_mono, result[:vika_total_sum_mono_coordinates])
      UpdateCellInGoogleSheet.call('', result[:vika_total_sum_mono_cells_coordinates])

      # increase uah spent amount
      result = CalculateTotalSpentUsdAndUah.call
      UpdateCellInGoogleSheet.call(result[:total_left_uah_money] + @price, result[:coordinates_of_total_left_uah_money])
    end

    # if @type_returned == 'cash'
    #   vika_total_sum_cash = "= #{result[:vika_total_sum_cash].to_s.split('.')[0]} - #{@price.to_s.split('.')[0]}"
    #   UpdateCellInGoogleSheet.call(vika_total_sum_cash, result[:vika_total_sum_cash_coordinates])
    #   UpdateCellInGoogleSheet.call('', result[:vika_total_sum_cash_cells_coordinates])
    # end
  end
end
