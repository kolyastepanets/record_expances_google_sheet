class EnterExpencesFopDollarCardFromWebhook < CommonExpensesFromWebhook
  private

  def build_params
    @params = {
      price_in_usd: @transaction_data[:amount].abs / 100.0,
      **@params,
    }

    build_common_params

    if @transaction_data[:description] == sold_dollars_from_fop
      @params = {
        sold_dollars_from_fop: true,
        grivnas: @transaction_data[:operationAmount].abs / 100.0,
        dollars: @transaction_data[:amount].abs / 100.0,
      }
    end
  end

  def call_job
    return EnterSoldDollarsFromFopJob.perform_later(@params) if @params[:sold_dollars_from_fop]
    return PutExpencesFopDollarCardJob.perform_later(@params) if @params[:category_name].present?

    SendMessageToBotToAskToEnterExpences.call(@transaction_data.merge(is_fop_dollar: true, currency_rate: currency_rate))
  end

  def sold_dollars_from_fop
    "На гривневий рахунок ФОП для переказу на картку"
  end

  def salary
    "SWIFT платіж"
  end

  def currency_rate
    price_in_usd = @transaction_data[:amount].abs / 100.0
    operation_amount = @transaction_data[:operationAmount].abs / 100.0

    currency_rate = operation_amount / price_in_usd
    currency_rate = currency_rate.to_s
    currency_rate = currency_rate.split('.')
    "#{currency_rate[0]}.#{currency_rate[1].first(4)}".to_f
  end
end
