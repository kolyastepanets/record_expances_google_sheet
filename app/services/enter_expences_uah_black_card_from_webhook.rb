class EnterExpencesUahBlackCardFromWebhook < CommonExpensesFromWebhook
  private

  def build_params
    is_usd = false
    is_uah = true
    @total_sum_of_money_before_save = 0

    @params = {
      price_in_uah: @transaction_data[:amount].to_i.abs / 100.0,
      total_sum_of_money_before_save: @total_sum_of_money_before_save,
      **@params,
    }

    build_common_params
  end

  def call_job
    return PutExpencesUahBlackCardJob.perform_later(@params) if @params[:category_name].present?
    return PutCashbackToIncomePageJob.perform_later(@params[:price_in_uah]) if @transaction_data[:description].include?("Виведення кешбеку")

    SendMessageToBotToAskToEnterExpences.call({
      currency_rate: currency_rate,
      total_sum_of_money_before_save: @total_sum_of_money_before_save,
      can_show_final_sum: true,
      **@transaction_data,
    })
  end

  def currency_rate
    price_in_uah = @transaction_data[:amount].to_i.abs / 100.0
    operation_amount = @transaction_data[:operationAmount].to_i.abs / 100.0

    currency_rate = price_in_uah / operation_amount
    currency_rate = currency_rate.to_s
    currency_rate = currency_rate.split('.')
    "#{currency_rate[0]}.#{currency_rate[1].first(6)}".to_f
  end
end
