class EnterSalaryFromSwiftJob < ApplicationJob
  queue_as :default

  def perform(params)
    EnterSalaryFromSwift.call(params)
    SendNotificationMessageToBot.call(params)
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    SendNotificationMessageToBot.call(error_message)
  end
end
