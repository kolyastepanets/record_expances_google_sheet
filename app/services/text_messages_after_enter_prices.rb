class TextMessagesAfterEnterPrices
  include CallableService

  def initialize(is_usd, is_uah, total_sum_of_money_before_save)
    @is_usd = is_usd
    @is_uah = is_uah
    @total_sum_of_money_before_save = total_sum_of_money_before_save
  end

  def call
    if @is_usd
      total_sum_of_money = ReceiveUsdFopFromGoogleSheet.call
      total_sum_of_money_after_save = total_sum_of_money.split("usd fop in google sheet: $")[-1].gsub(/[[:space:]]+/, "").to_f
    end
    if @is_uah
      total_sum_of_money = ReceiveCurrentBalanceInMonobankFromGoogleSheet.call
      total_sum_of_money_after_save = total_sum_of_money.split("uah in google sheet: ")[-1].split("грн")[0].gsub(/[[:space:]]+/, "").to_f
    end

    {
      total_sum_after_money_was_saved: "Общая сумма уже сохраненная после заполнения: \n#{total_sum_of_money}",
      difference_of_saved_money: "Разница денег на основе сохраненных сумм, сравнить с ценой в чеке: #{(@total_sum_of_money_before_save - total_sum_of_money_after_save)}"
    }
  end
end
