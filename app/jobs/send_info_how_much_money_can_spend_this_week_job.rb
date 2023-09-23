class SendInfoHowMuchMoneyCanSpendThisWeekJob < ApplicationJob
  queue_as :default

  def perform(categories_names)
    if categories_names.include?("Еда")
      Telegram.bot.send_message(
        chat_id: ENV['MY_TELEGRAM_ID'],
        text: TextHowMuchMoneyCanSpendThisWeek::ForFood.call,
        parse_mode: :HTML,
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
    end
    if categories_names.include?("Для дома")
      Telegram.bot.send_message(
        chat_id: ENV['MY_TELEGRAM_ID'],
        text: TextHowMuchMoneyCanSpendThisWeek::ForHome.call,
        parse_mode: :HTML,
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
    end
    if categories_names.include?("Непредвиденное")
      Telegram.bot.send_message(
        chat_id: ENV['MY_TELEGRAM_ID'],
        text: TextHowMuchMoneyCanSpendThisWeek::ForUnexpected.call,
        parse_mode: :HTML,
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
    end
    if categories_names.include?("Путешествия")
      Telegram.bot.send_message(
        chat_id: ENV['MY_TELEGRAM_ID'],
        text: TextHowMuchMoneyCanSpendThisWeek::ForTravelling.call,
        parse_mode: :HTML,
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
    end
    if categories_names.include?("Развлечения")
      Telegram.bot.send_message(
        chat_id: ENV['MY_TELEGRAM_ID'],
        text: TextHowMuchMoneyCanSpendThisWeek::ForEntertainment.call,
        parse_mode: :HTML,
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
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
