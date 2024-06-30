class SendMessageToBotToAskToEnterExpencesFromMonzoSchedule
  include CallableService

  def initialize
    @redis = Redis.new
  end

  def call
    @redis.scan_each(match: 'monzo_transaction_id_*') do |key|
      params = JSON.parse(@redis.get(key)).deep_symbolize_keys
      next if params[:already_sent_to_bot]

      send_message_to_bot(params)
      update_redis(key, params)
    end
  end

  private

  def send_message_to_bot(params)
    SendMessageToBotToAskToEnterExpencesFromMonzo.call(params)
  end

  def update_redis(key, params)
    params[:already_sent_to_bot] = true
    @redis.set(key, params.to_json, ex: 24.hours)
  end
end
