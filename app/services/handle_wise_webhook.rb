class HandleWiseWebhook
  include CallableService

  FINAL_WISE_STATE_WHEN_TRANSACTION_COMPLETED = "outgoing_payment_sent".freeze

  def initialize(params)
    @params = JSON.parse(params.to_json).deep_symbolize_keys
  end

  def call
    if add_usd?
      IncreaseWiseUsdSavedAmountJob.perform_later(@params[:data][:amount])
    end
    if withdraw_usd?
      EnterExpencesWiseDollarCardFromWebhook.call(@params)
    end

    TestJob.perform_later(@params)
  end

  private

  def add_usd?
    @params[:event_type] == "balances#credit" && @params[:data][:currency] == 'USD'
  end

  def withdraw_usd?
    @params[:event_type] == "transfers#state-change" && @params[:data][:current_state] == FINAL_WISE_STATE_WHEN_TRANSACTION_COMPLETED
  end
end
