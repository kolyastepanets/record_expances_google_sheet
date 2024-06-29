class SendTextMessagesBeforeEnterPrices
  include CallableService

  def initialize(is_usd, is_uah, is_gbp, is_gbp_joint)
    @is_usd = is_usd
    @is_uah = is_uah
    @is_gbp = is_gbp
    @is_gbp_joint = is_gbp_joint
  end

  def call
    if @is_usd
      total_sum_of_money = ReceiveUsdFopFromGoogleSheet.call
      total_sum_of_money_before_save = total_sum_of_money.split("usd fop in google sheet: $")[-1].gsub(/[[:space:]]+/, "").gsub(",", ".").to_f
    end
    if @is_gbp
      total_sum_of_money = ReceiveMonzoGbpFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:gbp_monzo_formula]
      total_sum_of_money_before_save = total_sum_of_money
    end
    if @is_uah
      total_sum_of_money = ReceiveCurrentBalanceInMonobankFromGoogleSheet.call
      total_sum_of_money_before_save = total_sum_of_money.split("uah in google sheet: ")[-1].split("грн")[0].gsub(/[[:space:]]+/, "").gsub(",", ".").to_f
    end
    if @is_gbp_joint
      total_sum_of_money = ReceiveJointMonzoGbpFromGoogleSheet.call(value_render_option: 'UNFORMATTED_VALUE')[:gbp_joint_monzo_formula]
      total_sum_of_money_before_save = total_sum_of_money
    end

    Telegram.bot.send_message(chat_id: ENV['MY_TELEGRAM_ID'], text: "Общая сумма перед заполнением: \n#{total_sum_of_money}")

    total_sum_of_money_before_save
  end
end
