class CurrencyRate
  include CallableService

  BASE_CURRENCY = 'GBP'.freeze

  def initialize(from_currency, to_currency)
    @from_currency = from_currency
    @to_currency = to_currency
    @redis = Redis.new
  end

  def call
    currency_rates.dig(0, "rate")
  end

  private

  def currency_rates
    currency_rates = @redis.get("api_currency_rates_#{@from_currency}_#{@to_currency}")

    return JSON.parse(currency_rates) if !currency_rates.nil?

    resp = Faraday.new(
      url: "https://api.transferwise.com/v1/rates?source=#{@from_currency}&target=#{@to_currency}",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['WISE_TOKEN_FULL_ACCESS']}"
      }
    ).get

    return {} if !resp.status.in?([200, 201])

    currency_rates = JSON.parse(resp.body)
    @redis.set("api_currency_rates_#{@from_currency}_#{@to_currency}", currency_rates.to_json, ex: 1.day)

    currency_rates
  end
end
