




# TO DO

# Incorrect price in usd for shiphawk
#
# duplicate logic in EnterExpencesWiseDollarCardFromWebhook
#
# rerecord tests
#
# organize normal current class

class HandleWiseWebhook
  include CallableService

  FINAL_WISE_STATE_WHEN_TRANSACTION_COMPLETED = "outgoing_payment_sent".freeze

  def initialize(params)
    @params = build_params(JSON.parse(params.to_json).deep_symbolize_keys)
  end

  def call
    if add_usd?
      IncreaseWiseUsdSavedAmountJob.perform_later(@params[:data][:amount].presence || @params[:price_in_usd])
    end
    if withdraw_usd?
      EnterExpencesWiseDollarCardFromWebhook.call(@params)
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
      **data_webhook,
    }
  end

  def add_usd?
    p_2_p? || from_shiphawk?
  end

  def p_2_p?
    @params[:event_type] == "balances#credit" && @params[:data][:currency] == 'USD'
  end

  def from_shiphawk?
    @params[:reference] == ENV['WISE_SHIPHAWK_NAME']
  end

  def withdraw_usd?
    kindergaten?
  end

  def kindergaten?
    @params[:reference] == 'Mark Stepanets'
  end

  def transfer_complete?
    @params[:event_type] == "transfers#state-change" && @params[:data][:current_state] == FINAL_WISE_STATE_WHEN_TRANSACTION_COMPLETED
  end
end
