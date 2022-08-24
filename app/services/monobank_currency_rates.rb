class MonobankCurrencyRates
  include CallableService

  CURRENCY_TO_CODE = {
    'UAH' => 980,
    'USD' => 840,
    'EUR' => 978,
  }.freeze

  def initialize(from_currency, to_currency)
    @from_currency = from_currency
    @to_currency = to_currency
    @redis = Redis.new
  end

  def call
    found_rate = currency_rates.detect do |rate|
      rate["currencyCodeA"] == CURRENCY_TO_CODE[@from_currency] && rate["currencyCodeB"] == CURRENCY_TO_CODE[@to_currency]
    end

    return if found_rate.nil?

    found_rate["rateSell"]
  end

  private

  def currency_rates
    currency_rates = @redis.get("currency_rates")

    return JSON.parse(currency_rates) if !currency_rates.nil?

    currency_rates = JSON.parse(Faraday.new(url: "https://api.monobank.ua/bank/currency").get.body)
    @redis.set("currency_rates", currency_rates.to_json, ex: 1.day)

    currency_rates
  end
end
