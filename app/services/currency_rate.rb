class CurrencyRate
  include CallableService

  BASE_CURRENCY = 'GBP'.freeze

  def initialize(from_currency, to_currency)
    @from_currency = from_currency
    @to_currency = to_currency
    @redis = Redis.new
  end

  def call
    currency_rate.dig("data", @to_currency, "value")
  end

  private

  def currency_rate
    currency_rates = @redis.get("api_currency_rates_#{@to_currency}")

    return JSON.parse(currency_rates) if !currency_rates.nil?

    resp = Faraday.new(url: "https://api.currencyapi.com/v3/latest?apikey=#{ENV['API_CURRENCY_RATE']}&currencies=#{@from_currency}%2C#{@to_currency}&base_currency=#{BASE_CURRENCY}").get
    return {} if !resp.status.in?([200, 201])

    currency_rates = JSON.parse(resp.body)
    @redis.set("api_currency_rates_#{@to_currency}", currency_rates.to_json, ex: 1.day)

    currency_rates
  end
end
