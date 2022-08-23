class BuildDollarForeignCurrencyFormulaPrice
  include CallableService

  CURRENCY_TO_CODE = {
    'UAH' => 980,
    'USD' => 840,
    'EUR' => 978,
  }.freeze

  def initialize(price, session_object)
    @price = price
    @session_object = session_object
    @redis = Redis.new
  end

  def call
    usd_to_uah = currency_rates.detect do |rate|
      rate["currencyCodeA"] == CURRENCY_TO_CODE['USD'] && rate["currencyCodeB"] == CURRENCY_TO_CODE['UAH']
    end
    currency_rate = usd_to_uah["rateSell"]

    "=#{@price.to_s.gsub(".", ",")} / #{@session_object[:receipt_dollar_foreign_currency_exchange_rate].to_s.gsub(".", ",")} * #{currency_rate.to_s.gsub(".", ",")}"
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
