class MonobankWebhooksController < ApplicationController
  def show
    # check that webhook work for Mono API
    render json: {}, status: 200
  end

  def create
    MonoWebhook::HandleMonoWebhook.call(params["monobank_webhook"])
    render json: {}, status: 200
  end
end
