class SendMessageToBotToAskIfKomankCameToday
  include CallableService

  def call
    redis = Redis.new

    response = Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: 'Did Komank come today?',
      reply_markup: {
        inline_keyboard: [
          [{ text: 'yes', callback_data: 'komank_came_today' }],
          [{ text: 'no', callback_data: 'komank_did_not_come_today' }],
        ]
      },
    )

    redis.set('message_id_ask_if_komank_came_today', response["result"]["message_id"], ex: 1.day)

    nil
  end
end
