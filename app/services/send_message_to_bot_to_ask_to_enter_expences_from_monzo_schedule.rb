class SendMessageToBotToAskToEnterExpencesFromMonzoSchedule
  include CallableService

  def initialize
    @redis = Redis.new
  end

  def call
    @redis.scan_each(match: 'monzo_transaction_id_*') do |key|
      params = JSON.parse(@redis.get(key)).deep_symbolize_keys
      @redis.del(key)
      SendMessageToBotToAskToEnterExpencesFromMonzo.call(params)
    end
  end
end
