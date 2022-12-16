class WriteDownHalfExpenses
  include CallableService

  EVERY_DAY_EXPENSES_PAGE = 2079267030

  def initialize(how_divide_expenses, all_cells, total_sum_usd, total_sum_uah)
    @how_divide_expenses = how_divide_expenses
    @all_cells = all_cells
    @all_cells_to_save = all_cells.join('-')
    @total_sum_price = calculate_total_sum(total_sum_usd, total_sum_uah)
  end

  def call
    return if @how_divide_expenses.blank?

    result = FindCellToEnterVikaHalfExpenses.call

    if @how_divide_expenses == AllConstants::MYKOLA_PAYED
      vika_total_sum_mono = result[:vika_total_sum_mono] + @total_sum_price
      UpdateCellInGoogleSheet.call(vika_total_sum_mono, result[:vika_total_sum_mono_coordinates])

      vika_total_sum_mono_cells = result[:vika_total_sum_mono_cells] + "-#{@all_cells_to_save}"
      vika_total_sum_mono_cells = "#{@all_cells_to_save}" if result[:vika_total_sum_mono_cells].blank?
      UpdateCellInGoogleSheet.call(vika_total_sum_mono_cells, result[:vika_total_sum_mono_cells_coordinates])
    end

    if @how_divide_expenses == AllConstants::VIKA_PAYED
      mykola_total_sum_mono = result[:mykola_total_sum_mono] + @total_sum_price
      UpdateCellInGoogleSheet.call(mykola_total_sum_mono, result[:mykola_total_sum_mono_coordinates])

      mykola_total_sum_mono_cells = result[:mykola_total_sum_mono_cells] + "-#{@all_cells_to_save}"
      mykola_total_sum_mono_cells = "#{@all_cells_to_save}" if result[:mykola_total_sum_mono_cells].blank?
      UpdateCellInGoogleSheet.call(mykola_total_sum_mono_cells, result[:mykola_total_sum_mono_cells_coordinates])
    end

    UpdateCellBackgroundColorRequest.call(EVERY_DAY_EXPENSES_PAGE, @all_cells[0], (@all_cells[-1] + 1), color)
  end

  private

  def color
    return 'yellow' if @how_divide_expenses == AllConstants::MYKOLA_PAYED
    return 'orange' if @how_divide_expenses == AllConstants::VIKA_PAYED
  end

  def calculate_total_sum(total_sum_usd, total_sum_uah)
    total_sum_price = 0

    total_sum_price = total_sum_usd * MonobankCurrencyRates.call('USD', 'UAH').to_f
    total_sum_price = total_sum_uah if total_sum_usd.zero?

    (total_sum_price / 2).round(2)
  end
end
