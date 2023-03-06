class SendMessageToBotToAskToEnterExpencesJob < ApplicationJob
  queue_as :default

  def perform(params)
    params.deep_symbolize_keys!

    SendMessageToBotToAskToEnterExpences.call(params)
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
