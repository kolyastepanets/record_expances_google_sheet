class HandleInputPhotoJob < ApplicationJob
  queue_as :default

  def perform(message_params)
    HandleInputPhoto.call(message_params)
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    SendNotificationMessageToBot.call(error_message)
  end
end
