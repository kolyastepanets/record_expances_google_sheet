class WiseWebhooksController < ApplicationController
  def create
    HandleWiseWebhook.call(params["wise_webhook"])
    render json: {}, status: 200
  end
end
