class ReceiveCurrentTransferFromWiseApi
  include CallableService

  def initialize(transfer_id)
    @transfer_id = transfer_id
  end

  def call
    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    @conn = Faraday.new(
      url: "https://api.transferwise.com/v1/transfers/#{@transfer_id}",
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
