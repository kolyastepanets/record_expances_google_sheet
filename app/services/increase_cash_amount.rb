class IncreaseCashAmount
  include CallableService

  def initialize(params)
    @category_name = params[:category_name]
    @operation_amount = params[:operation_amount]
    @currency_rate = params[:currency_rate]
  end

  def call
    return if @category_name != 'Кэш'

    @result = CalculateForeignCurrencyCashExpenses.call

    increase_total_cash
    add_currency_rate
    increase_now_foreign_money
    increase_total_foreign_money
  end

  def increase_total_cash
    UpdateCellInGoogleSheet.call(
      @result[:withdraw_foreign_money] + "+#{@operation_amount.to_s.gsub('.', ',')}",
      @result[:coordinates_of_value_to_change_withdraw_foreign_money],
    )
  end

  def add_currency_rate
    currency_formula = @result[:currency_rate_uah_to_foreigh_currency]
    in_brakets, _divider = currency_formula.split('/')
    currency_rates = in_brakets.delete('=').delete('(').delete(')').split('+')
    new_currency_rates = currency_rates << @currency_rate.to_s.gsub('.', ',')
    final_formula = "=(#{currency_rates.join('+')})/#{new_currency_rates.size}"

    UpdateCellInGoogleSheet.call(
      final_formula,
      @result[:coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency],
    )
  end

  def increase_now_foreign_money
    UpdateCellInGoogleSheet.call(
      @result[:now_foreign_money] + @operation_amount,
      @result[:coordinates_of_value_to_change_now_foreign_money],
    )
  end

  def increase_total_foreign_money
    UpdateCellInGoogleSheet.call(
      @result[:total_withraw_foreign_money_formula] + "+#{@operation_amount.to_s.gsub('.', ',')}",
      @result[:coordinates_of_total_withraw_foreign_money_formula],
    )
  end
end
