class SendNotificationMessageToBot
  include CallableService

  def initialize(params, show_reply_markup_main_buttons: false)
    @params = params
    @show_reply_markup_main_buttons = show_reply_markup_main_buttons
  end

  def call
    reply_markup_main_buttons = {}
    reply_markup_main_buttons = { reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS } if @show_reply_markup_main_buttons

    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: "```#{BeautifulParamsMessage.call(@params)}```",
      parse_mode: :MarkdownV2,
      **reply_markup_main_buttons,
    )
  end
end
