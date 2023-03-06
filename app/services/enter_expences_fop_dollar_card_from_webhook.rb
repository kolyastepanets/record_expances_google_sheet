class EnterExpencesFopDollarCardFromWebhook < CommonExpensesFromWebhook
  private

  def build_params
    is_usd = true
    is_uah = false
    @total_sum_of_money_before_save = SendTextMessagesBeforeEnterPrices.call(is_usd, is_uah)

    @params = {
      price_in_usd: @transaction_data[:amount].to_i.abs / 100.0,
      total_sum_of_money_before_save: @total_sum_of_money_before_save,
      **@params,
    }

    build_common_params

    if @transaction_data[:description] == sold_dollars_from_fop
      @params = {
        sold_dollars_from_fop: true,
        grivnas: @transaction_data[:operationAmount].to_i.abs / 100.0,
        dollars: @transaction_data[:amount].to_i.abs / 100.0,
      }
    end
    if @transaction_data[:description] == sold_dollars_to_uah_fop_for_taxes
      @params = {
        sold_dollars_to_uah_fop_for_taxes: true,
        dollars: @transaction_data[:amount].to_i.abs / 100.0,
      }
    end
    if @transaction_data[:description].downcase.include?(swift_salary)
      @params = {
        swift_salary: true,
        dollars: @transaction_data[:amount].to_i.abs / 100.0,
      }
    end
  end

  def call_job
    return EnterSalaryFromSwiftJob.perform_later(@params) if @params[:swift_salary]
    return DecreaseDollarsJob.perform_later(@params) if @params[:sold_dollars_to_uah_fop_for_taxes]
    return EnterSoldDollarsFromFopJob.perform_later(@params) if @params[:sold_dollars_from_fop]
    return PutExpencesFopDollarCardJob.perform_later(@params) if @params[:category_name].present?

    SendMessageToBotToAskToEnterExpencesJob.perform_later({
      is_fop_dollar: true,
      currency_rate: currency_rate,
      total_sum_of_money_before_save: @total_sum_of_money_before_save,
      can_show_final_sum: true,
      **@transaction_data
    })
  end

  def sold_dollars_from_fop
    "На гривневий рахунок ФОП для переказу на картку"
  end

  def sold_dollars_to_uah_fop_for_taxes
    "На гривневий рахунок ФОП"
  end

  def swift_salary
    "swift"
  end

  def currency_rate
    price_in_usd = @transaction_data[:amount].to_i.abs / 100.0
    operation_amount = @transaction_data[:operationAmount].to_i.abs / 100.0

    currency_rate = operation_amount / price_in_usd
    currency_rate = currency_rate.to_s
    currency_rate = currency_rate.split('.')
    "#{currency_rate[0]}.#{currency_rate[1].first(4)}".to_f
  end
end
