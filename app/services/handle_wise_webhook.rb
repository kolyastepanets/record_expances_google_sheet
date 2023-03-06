class HandleWiseWebhook
  include CallableService

  FINAL_WISE_STATE_WHEN_TRANSACTION_COMPLETED = "outgoing_payment_sent".freeze

  def initialize(params)
    @raw_params = JSON.parse(params.to_json).deep_symbolize_keys
  end

  def call
    return if !final_transaction?

    @params = build_params(@raw_params)

    if salary_from_shiphawk?
      IncreaseWiseUsdSavedAmountJob.perform_later(@params[:salary_in_usd])
    elsif paid_for_kindergaten?
      save_as_kindergaten
    else
      SendMessageToBotToAskToEnterExpencesFromWise.call(@params)
    end

    TestJob.perform_later(@params)
  end

  private

  def build_params(data_webhook)
    transfer_object = ReceiveCurrentTransferFromWiseApi.call(data_webhook[:data][:resource][:id])
    quote_object = ReceiveQuoteFromWiseApi.call(transfer_object[:quoteUuid])
    price_in_usd = quote_object[:paymentOptions].detect { |paymentOption| paymentOption[:payIn] == 'BALANCE' }[:sourceAmount]
    price_in_usd = price_in_usd.to_s.gsub(".", ",")

    {
      id: data_webhook[:data][:resource][:id].to_s,
      reference: transfer_object[:reference],
      price_in_usd: price_in_usd,
      salary_in_usd: transfer_object[:targetValue],
      **data_webhook,
    }
  end

  def salary_from_shiphawk?
    @params[:reference] == ENV['WISE_SHIPHAWK_NAME']
  end

  def paid_for_kindergaten?
    @params[:reference] == ENV['REFERENCE_KINDERGARTEN']
  end

  def save_as_kindergaten
    kindergaten_params = {
      category_name: 'Марк',
      sub_category_name: 'Дет сад',
      price_in_usd: @params[:price_in_usd],
      wise: true,
    }
    PutExpencesWiseDollarCardJob.perform_later(kindergaten_params)
  end

  def final_transaction?
    @raw_params[:event_type] == "transfers#state-change" && @raw_params[:data][:current_state] == FINAL_WISE_STATE_WHEN_TRANSACTION_COMPLETED
  end
end
