class ReceiveMonzoFromApi
  include CallableService

  def call
    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    @conn = Faraday.new(
      url: "https://api.monzo.com/balance?account_id=#{ENV['MONZO_ACCOUNT_ID']}",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ReceiveMonzoFromApiAccessToken.call}"
      }
    )
  end

  def make_request
    @response = @conn.get
  end

  def parse_response
    res = JSON.parse(@response.body)
    return "invalid response" if res["balance"].blank?

    gbp_amount = (res["balance"] / 100.0).round(2)
    "gbp in monzo: £#{gbp_amount}"
  end
end
