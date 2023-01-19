class DeleteAllTodaysMessages
  include CallableService

  def initialize
    @redis = Redis.new
    @key = "messages_at_#{Date.today.to_s}"
  end

  def call
    messages = @redis.get(@key)

    return if messages.nil?

    DeleteMessagesJob.perform_later(JSON.parse(messages), nil, nil, nil)
  end
end
