class PutCashbackToIncomePageJob < ApplicationJob
  queue_as :default

  def perform(cashback_uah)
    category = 'кэшбек'
    money_placed_to = 'cashback'
    currency_rate = MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")
    prepared_cashback_uah = cashback_uah.to_s.gsub(".", ",")
    before_taxes_currency = prepared_cashback_uah
    after_taxes_currency = prepared_cashback_uah
    before_taxes_usd = "= #{prepared_cashback_uah} / #{currency_rate}"
    after_taxes_usd = "= #{prepared_cashback_uah} / #{currency_rate}"

    PutIncomeToGoogleSheet.call(
      category,
      before_taxes_currency,
      after_taxes_currency,
      before_taxes_usd,
      after_taxes_usd,
      currency_rate,
      money_placed_to
    )
  end
end
