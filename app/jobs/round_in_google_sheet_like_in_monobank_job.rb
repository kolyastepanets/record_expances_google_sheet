class RoundInGoogleSheetLikeInMonobankJob < ApplicationJob
  queue_as :default

  def perform
    usd_fop_monobank = ReceiveUsdFopFromMonobank.call
    uah_fop_monobank = ReceiveCurrentBalanceInMonobankFromMono.call

    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{usd_fop_monobank}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{uah_fop_monobank}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )

    RoundInGoogleSheetLikeInMonobank.call(usd_fop_monobank, uah_fop_monobank)

    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{usd_fop_monobank}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{uah_fop_monobank}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
