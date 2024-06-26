class SendMessageTotalSumAfterFinishEnterMoney
  include CallableService

  def initialize(is_gbp, is_gbp_joint, is_usd, is_uah, total_sum_of_money_before_save)
    @is_gbp = is_gbp
    @is_usd = is_usd
    @is_uah = is_uah
    @is_gbp_joint = is_gbp_joint
    @total_sum_of_money_before_save = total_sum_of_money_before_save
  end

  def call
    data_text = TextMessagesAfterEnterPrices.call(@is_gbp, @is_gbp_joint, @is_usd, @is_uah, @total_sum_of_money_before_save)
    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: data_text[:total_sum_after_money_was_saved])
    Telegram.bot.send_message(
      chat_id: ENV['MY_TELEGRAM_ID'],
      text: data_text[:difference_of_saved_money],
      reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
    )
  end
end
