Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  resource :monobank_webhooks, only: [:show, :create]
end
