class SendMessageTotalSumAfterFinishEnterMoney
  include CallableService

  def initialize(is_usd, is_uah, can_show_final_message, total_sum_of_money_before_save)
    @is_usd = is_usd
    @is_uah = is_uah
    @can_show_final_message = can_show_final_message
    @total_sum_of_money_before_save = total_sum_of_money_before_save
  end

  def call
    return if !@can_show_final_message

    data_text = TextMessagesAfterEnterPrices.call(@is_usd, @is_uah, @total_sum_of_money_before_save)
    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: data_text[:total_sum_after_money_was_saved])
    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: data_text[:difference_of_saved_money])
  end
end
