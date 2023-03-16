class HandleMonoWebhookJob < ApplicationJob
  queue_as :default

  FOP_DOLLAR_CARD = "IJ8Y_c1UAwxRHa4vAlTivQ".freeze
  BLACK_UAH_CARD = "C0Hfjf2vrc00CZ_1ZCjSLg".freeze

  def perform(webhook_params)
    params = webhook_params.deep_symbolize_keys

    case params[:data][:account]
    when FOP_DOLLAR_CARD
      EnterExpencesFopDollarCardFromWebhook.call(params[:data][:statementItem])
    when BLACK_UAH_CARD
      EnterExpencesUahBlackCardFromWebhook.call(params[:data][:statementItem])
    end
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
