class ReceiveCurrentBalanceInMonobankFromMono
  include CallableService

  BLACK_MONO_CARD_IBAN = "UA923220010000026201302742376".freeze

  def call
    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    @conn = Faraday.new(
      url: "https://api.monobank.ua/personal/client-info",
      headers: {
        'Content-Type' => 'application/json',
        'X-Token' => ENV['MONOBANK_TOKEN']
      }
    )
  end

  def make_request
    @response = @conn.get
  end

  def parse_response
    return "mono api error" if !@response.status.in?([200, 201])

    res = JSON.parse(@response.body)
    account = res["accounts"].detect { |acc| acc["iban"] == BLACK_MONO_CARD_IBAN }
    total_balance = account["balance"] - account["creditLimit"]
    integer_before_decimal_point = total_balance.to_s[0...-2]
    coins = total_balance.to_s.last(2)
    "uah in mono: #{integer_before_decimal_point << ",#{coins}"} грн"
  end
end
