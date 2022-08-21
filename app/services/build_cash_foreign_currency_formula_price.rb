class BuildCashForeignCurrencyFormulaPrice
  include CallableService

  def initialize(price)
    @price = price
  end

  def call
    currency_foreign_uah = GetGoogleSheetCurrencyExchange.call
    modified_price = @price.to_s.gsub(".", ",")

    "=#{currency_foreign_uah}*#{modified_price}"
  end
end
