class RoundInGoogleSheetLikeInMonobankJob < ApplicationJob
  queue_as :default

  def perform
    usd_fop_monobank = ReceiveUsdFopFromMonobank.call
    uah_fop_monobank = ReceiveCurrentBalanceInMonobankFromMono.call
    gbp_from_monzo   = ReceiveMonzoFromApi.call
    gbp_monzo_in_google_sheet = ReceiveMonzoGbpFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:gbp_monzo_formula]
    gbp_from_monzo_google_sheet = "GBP Monzo google sheet: #{gbp_monzo_in_google_sheet}"
    gbp_joint_from_monzo   = ReceiveJointMonzoFromApi.call
    gbp_joint_monzo_in_google_sheet = ReceiveJointMonzoGbpFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:gbp_joint_monzo_formula]
    gbp_joint_from_monzo_google_sheet = "GBP Joint Monzo google sheet: #{gbp_joint_monzo_in_google_sheet}"

    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{usd_fop_monobank}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{uah_fop_monobank}\n#{gbp_from_monzo_google_sheet}\n#{gbp_from_monzo}\n#{gbp_joint_from_monzo_google_sheet}\n#{gbp_joint_from_monzo}",
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )

    RoundInGoogleSheetLikeInMonobank.call(usd_fop_monobank, uah_fop_monobank)
    RoundInGoogleSheetLikeInMonzo.call(gbp_from_monzo)
    RoundInGoogleSheetLikeInJointMonzo.call(gbp_joint_from_monzo)

    gbp_monzo_in_google_sheet = ReceiveMonzoGbpFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:gbp_monzo_formula]
    gbp_from_monzo_google_sheet = "GBP Monzo google sheet: #{gbp_monzo_in_google_sheet}"
    gbp_joint_monzo_in_google_sheet = ReceiveJointMonzoGbpFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:gbp_joint_monzo_formula]
    gbp_joint_from_monzo_google_sheet = "GBP Joint Monzo google sheet: #{gbp_joint_monzo_in_google_sheet}"
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "#{ReceiveUsdFopFromGoogleSheet.call}\n#{usd_fop_monobank}\n#{ReceiveCurrentBalanceInMonobankFromGoogleSheet.call}\n#{uah_fop_monobank}\n#{gbp_from_monzo_google_sheet}\n#{gbp_from_monzo}\n#{gbp_joint_from_monzo_google_sheet}\n#{gbp_joint_from_monzo}",
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
