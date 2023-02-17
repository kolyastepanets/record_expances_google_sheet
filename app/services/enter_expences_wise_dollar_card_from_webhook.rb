class EnterExpencesWiseDollarCardFromWebhook
  include CallableService

  def initialize(params)
    @params = build_params(params)
  end

  def call
    return save_as_kindergaten if kindergaten?

    SendMessageToBotToAskToEnterExpencesFromWise.call(@params)
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
      **data_webhook,
    }
  end

  def kindergaten?
    @params[:reference] == ENV['REFERENCE_KINDERGARTEN']
  end

  def save_as_kindergaten
    kindergaten_params = {
      category_name: 'Марк',
      sub_category_name: 'Дет сад',
      price_in_usd: @params[:price_in_usd],
      who_paid: nil,
    }
    PutExpencesWiseDollarCardJob.perform_later(kindergaten_params)
  end
end
