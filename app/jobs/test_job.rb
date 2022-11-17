class TestJob < ApplicationJob
  queue_as :default

  def perform(params)
    ApiGoogleSheet::SaveDataFromMonoWebhook.call(params)
  end
end
