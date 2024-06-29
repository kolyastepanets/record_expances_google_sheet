class BuildPrice
  include CallableService

  def initialize(price, session_object)
    @price = price
    @session_object = session_object
  end

  def call
    current_price = @price.to_f
    price_to_put_in_sheets = "=#{current_price.to_s.gsub(".", ",")}"
    price_to_calculate = current_price

    if @session_object[:is_grivnas]
      price_to_calculate = current_price
      price_to_put_in_sheets = "=#{current_price.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"
    end

    if @session_object[:is_gbp_monzo]
      price_to_calculate = current_price
      price_to_put_in_sheets = "=#{current_price.to_s.gsub(".", ",")} * #{CurrencyRate.call('GBP', 'USD').to_s.gsub(".", ",")}"
    end

    if @session_object[:is_gbp_joint_monzo]
      price_to_calculate = current_price
      price_to_put_in_sheets = "=#{current_price.to_s.gsub(".", ",")} * #{CurrencyRate.call('GBP', 'USD').to_s.gsub(".", ",")}"
    end

    if !@session_object[:foreigh_cash_amount].zero?
      price_to_calculate = current_price
      price_to_put_in_sheets = BuildCashForeignCurrencyFormulaPrice.call(current_price)
    end

    if !@session_object[:receipt_foreign_currency_exchange_rate].nil?
      price_to_calculate = @session_object[:receipt_foreign_currency_exchange_rate] * current_price
      price_to_put_in_sheets = "=#{@session_object[:receipt_foreign_currency_exchange_rate].to_s.gsub(".", ",")} * #{current_price.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"
    end

    if !@session_object[:receipt_dollar_foreign_currency_exchange_rate].nil?
      price_to_calculate = current_price / @session_object[:receipt_dollar_foreign_currency_exchange_rate]
      price_to_put_in_sheets = "=#{current_price.to_s.gsub(".", ",")} / #{@session_object[:receipt_dollar_foreign_currency_exchange_rate].to_s.gsub(".", ",")}"
    end

    [price_to_put_in_sheets, price_to_calculate]
  end
end
