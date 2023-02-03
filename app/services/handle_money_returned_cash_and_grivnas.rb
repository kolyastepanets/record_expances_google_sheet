class HandleMoneyReturnedCashAndGrivnas
  include CallableService

  def initialize(grivnas, foreign_cash)
    @grivnas = grivnas
    @foreign_cash = foreign_cash
  end

  def call
    put_expenses
    increase_uah_amount
    decrease_cash_amount
  end

  private

  def put_expenses
    category_name = 'Кэш'
    sub_category_name = nil
    price_to_put_in_sheets = "=-(#{@grivnas.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")})"
    detect_month = nil
    who_paid = nil
    PutExpensesToGoogleSheetJob.perform_later(category_name, sub_category_name, price_to_put_in_sheets, detect_month, who_paid)
  end

  def increase_uah_amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCellInGoogleSheet.call(
      result[:total_left_uah_money] + @grivnas,
      result[:coordinates_of_total_left_uah_money],
    )
  end

  def decrease_cash_amount
    result = CalculateForeignCurrencyCashExpenses.call

    # decrease_total_cash
    UpdateCellInGoogleSheet.call(
      result[:withdraw_foreign_money] + " - #{@foreign_cash.to_s.gsub('.', ',')}",
      result[:coordinates_of_value_to_change_withdraw_foreign_money],
    )

    # decrease now foreign money
    UpdateCellInGoogleSheet.call(
      result[:now_foreign_money] - @foreign_cash,
      result[:coordinates_of_value_to_change_now_foreign_money],
    )

    # decrease total foreign money
    UpdateCellInGoogleSheet.call(
      result[:total_withraw_foreign_money_formula] + " - #{@foreign_cash.to_s.gsub('.', ',')}",
      result[:coordinates_of_total_withraw_foreign_money_formula],
    )
  end
end
