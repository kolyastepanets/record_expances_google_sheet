class TestJob < ApplicationJob
  queue_as :default

  def perform
    params = { abc: 123 }
    SaveDataFromMonoWebhook.call(params)
  end
end
