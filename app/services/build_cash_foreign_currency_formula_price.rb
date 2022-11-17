class BuildCashForeignCurrencyFormulaPrice
  include CallableService

  def initialize(price)
    @price = price
  end

  def call
    currency_foreign_uah = ApiGoogleSheet::GetGoogleSheetCurrencyExchange.call
    modified_price = @price.to_s.gsub(".", ",")

    "=#{currency_foreign_uah}*#{modified_price}/#{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"
  end
end
