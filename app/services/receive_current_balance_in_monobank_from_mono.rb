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
    res = JSON.parse(@response.body)
    account = res["accounts"].detect { |acc| acc["iban"] == BLACK_MONO_CARD_IBAN }
    coins = account["balance"] - account["creditLimit"]
    "uah in mono: #{coins / 100} грн"
  end
end
