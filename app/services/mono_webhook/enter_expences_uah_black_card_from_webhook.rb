module MonoWebhook
  class EnterExpencesUahBlackCardFromWebhook < CommonExpensesFromWebhook
    private

    def build_params
      @params = {
        price_in_uah: @transaction_data[:amount].abs / 100.0,
        **@params,
      }

      build_common_params
    end

    def call_job
      return PutExpencesUahBlackCardJob.perform_later(@params) if @params[:category_name].present?

      SendMessageToBotToAskToEnterExpences.call(@transaction_data.merge(currency_rate: currency_rate))
    end

    def currency_rate
      price_in_uah = @transaction_data[:amount].abs / 100.0
      operation_amount = @transaction_data[:operationAmount].abs / 100.0

      currency_rate = price_in_uah / operation_amount
      currency_rate = currency_rate.to_s
      currency_rate = currency_rate.split('.')
      "#{currency_rate[0]}.#{currency_rate[1].first(4)}".to_f
    end
  end
end
