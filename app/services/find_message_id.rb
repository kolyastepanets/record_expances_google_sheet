class FindMessageId
  include CallableService

  def initialize(transaction_id, price, message_id_from_response)
    @transaction_id = transaction_id
    @price = price
    @message_id_from_response = message_id_from_response
    @redis = Redis.new
  end

  def call
    return @message_id_from_response if @transaction_id.blank?

    params = JSON.parse(@redis.get(@transaction_id))
    return params["message_ids"].last if !params.is_a?(Array)

    last_price_to_message = params.select { |pri| pri["price"] == @price.to_f }[-1]
    last_price_to_message["message_ids"].last
  end
end
