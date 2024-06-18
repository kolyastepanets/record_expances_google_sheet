class MonzoWebhooksController < ApplicationController
  def create
    HandleMonzoWebhook.call(params["monzo_webhook"])
    render json: {}, status: 200
  end
end
