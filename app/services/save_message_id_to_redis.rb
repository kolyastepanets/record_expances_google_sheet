class SaveMessageIdToRedis
  include CallableService

  def initialize(message_id)
    @message_id = message_id
    @redis = Redis.new
    @key = "messages_at_#{Date.today.to_s}"
  end

  def call
    return if @message_id.nil?

    messages = @redis.get(@key)

    if messages.present?
      parsed_messages = JSON.parse(messages)
      parsed_messages << @message_id
      @redis.set(@key, parsed_messages.uniq.to_json, ex: 2.days)
      return
    end

    @redis.set(@key, [@message_id].to_json, ex: 2.days)

    nil
  end
end
