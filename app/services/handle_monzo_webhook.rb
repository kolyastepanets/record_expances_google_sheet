class HandleMonzoWebhook
  include CallableService

  def initialize(params)
    @params = JSON.parse(params.to_json).deep_symbolize_keys
  end

  def call
    TestJob.perform_later(@params)
  end
end
