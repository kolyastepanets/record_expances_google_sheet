class HandleMonoWebhook
  include CallableService

  def initialize(params)
    @params = params
  end

  def call
    SaveDataFromMonoWebhook.call(@params)
  end
end
