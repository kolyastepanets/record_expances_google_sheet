class HandleHalfCalculatedExpensesJob < ApplicationJob
  queue_as :default

  def perform(sheet_id, line_number_saved_expenses, price_to_enter, month)
    @month = month.to_s
    @price_to_enter = price_to_enter

    result = FindCellToEnterVikaHalfExpenses.call

    if month_as_cash?
      vika_total_sum_cash = result[:vika_total_sum_cash] + detect_cash_price
      UpdateCellInGoogleSheet.call(vika_total_sum_cash, result[:vika_total_sum_cash_coordinates])

      vika_total_sum_cash_cells = result[:vika_total_sum_cash_cells] + "-#{line_number_saved_expenses}"
      vika_total_sum_cash_cells = "#{line_number_saved_expenses}" if result[:vika_total_sum_cash_cells].blank?
      UpdateCellInGoogleSheet.call(vika_total_sum_cash_cells, result[:vika_total_sum_cash_cells_coordinates])
    else
      vika_total_sum_mono = result[:vika_total_sum_mono] + detect_mono_price
      UpdateCellInGoogleSheet.call(vika_total_sum_mono, result[:vika_total_sum_mono_coordinates])

      vika_total_sum_mono_cells = result[:vika_total_sum_mono_cells] + "-#{line_number_saved_expenses}"
      vika_total_sum_mono_cells = "#{line_number_saved_expenses}" if result[:vika_total_sum_mono_cells].blank?
      UpdateCellInGoogleSheet.call(vika_total_sum_mono_cells, result[:vika_total_sum_mono_cells_coordinates])
    end

    UpdateCellBackgroundColorRequest.call(sheet_id, line_number_saved_expenses, 'yellow')
  end

  # input:
  # "=75000 * 0,0024204 / 37,4406"
  # or
  # "=75000 / 15590,3682"
  #
  # output: result of 75000 * 0.0024204 / 37,4406
  def detect_mono_price
    price = @price_to_enter.delete('=')
    first_part, divide_by = price.split('/')
    divide_by_number = divide_by.gsub(',', '.').to_f

    first_part_number = first_part.to_f
    if first_part.include?('*')
      first_number, second_number = first_part.split('*')
      first_number = first_number.gsub(',', '.').to_f
      second_number = second_number.gsub(',', '.').to_f

      first_part_number = first_number * second_number
    end

    ((first_part_number / divide_by_number * MonobankCurrencyRates.call('USD', 'UAH').to_f).round(0)) / 2
  end

  # input: "=0,002457*50000/37,4406"
  #
  # output: "50000"
  def detect_cash_price
    (@price_to_enter.split('*')[-1].split('/')[0].to_f.round(0)) / 2
  end

  def month_as_cash?
    @month.include?(',')
  end
end
