require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(username),
    ::Digest::SHA256.hexdigest(ENV.fetch('ADMIN_NAME'))
  ) & ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(password),
    ::Digest::SHA256.hexdigest(ENV.fetch('ADMIN_PASSWORD'))
  )
end

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  telegram_webhook TelegramWebhooksController

  resource :monobank_webhooks, only: [:show, :create]
  resource :wise_webhooks, only: [:create]
  resource :health_checks, only: [:show]
end
