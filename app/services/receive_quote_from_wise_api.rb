class ReceiveQuoteFromWiseApi
  include CallableService

  def initialize(uuid)
    @uuid = uuid
  end

  def call
    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    @conn = Faraday.new(
      url: "https://api.transferwise.com/v3/profiles/#{ENV['MY_WISE_ID']}/quotes/#{@uuid}",
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
    JSON.parse(@response.body).deep_symbolize_keys
  end
end
