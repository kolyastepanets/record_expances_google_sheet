if Rails.env.production?
  Telegram.bots_config = {
    default: ENV['TELEGRAM_BOT_TOKEN'],
  }
else
  Telegram.bots_config = {
    default: ENV['TEST_TELEGRAM_BOT_TOKEN'],
  }
end
