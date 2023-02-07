class HandleInputPhotoJob < ApplicationJob
  queue_as :default

  def perform(message_params)
    HandleInputPhoto.call(message_params)
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
