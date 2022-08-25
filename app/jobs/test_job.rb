class TestJob < ApplicationJob
  queue_as :default

  def perform(params)
    SaveDataFromMonoWebhook.call(params)
  end
end
