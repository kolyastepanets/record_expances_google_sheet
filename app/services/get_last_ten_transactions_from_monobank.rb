class GetLastTenTransactionsFromMonobank
  include CallableService

  LAST_NUMBER_OF_TRANSACTIONS = 10

  def call
    prepare_request_data
    make_request
    parse_response
  end

  private

  def prepare_request_data
    from = (Date.today - 3.days).to_time.to_i

    @conn = Faraday.new(
      url: "https://api.monobank.ua/personal/statement/0/#{from}/",
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

    res.reverse.last(LAST_NUMBER_OF_TRANSACTIONS).map do |trans|
      "#{trans["description"]} - #{-trans["amount"]/100} грн, #{Time.at(trans["time"]).to_date.strftime("%d-%-m-%Y")}"
    end.unshift("Последние #{LAST_NUMBER_OF_TRANSACTIONS} транзакций в моно:").join("\n")
  end
end
