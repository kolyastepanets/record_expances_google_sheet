class HandleMonoWebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook_params)
    params = webhook_params.deep_symbolize_keys

    case params[:data][:account]
    when ENV['FOP_DOLLAR_CARD']
      EnterExpencesFopDollarCardFromWebhook.call(params[:data][:statementItem])
    when ENV['BLACK_UAH_CARD']
      EnterExpencesUahBlackCardFromWebhook.call(params[:data][:statementItem])
    when ENV['WHITE_UAH_CARD']
      EnterExpencesUahWhiteCardFromWebhook.call(params[:data][:statementItem])
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
