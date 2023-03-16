class HandleMonoWebhook
  include CallableService

  def initialize(params)
    @params = JSON.parse(params.to_json).deep_symbolize_keys
  end

  def call
    return if @params.empty?

    HandleMonoWebhookJob.perform_later(@params)
    TestJob.perform_later(@params)
  end
end
