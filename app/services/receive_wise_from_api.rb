class ReceiveWiseFromApi
  include CallableService

  def call
    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    @conn = Faraday.new(
      url: "https://api.transferwise.com/v4/profiles/#{ENV['MY_WISE_ID']}/balances?types=STANDARD",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['WISE_TOKEN']}"
      }
    )
  end

  def make_request
    @response = @conn.get
  end

  def parse_response
    res = JSON.parse(@response.body)
    usd_amount = res.detect { |balance| balance["id"].to_s == ENV['WISE_ACCOUNT_ID_DOLLAR'] }["amount"]["value"]
    "usd in wise: $#{usd_amount}"
  end
end
