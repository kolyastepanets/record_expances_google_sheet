class HandleWiseWebhook
  include CallableService

  def initialize(params)
    @params = JSON.parse(params.to_json).deep_symbolize_keys
  end

  def call
    if add_usd?
      IncreaseWiseUsdSavedAmountJob.perform_later(wise_salary)
    end
    if withdraw_usd?
      EnterExpencesWiseDollarCardFromWebhook.call(@params)
    end

    TestJob.perform_later(@params)
  end

  private

  def add_usd?
    # +
  end

  def withdraw_usd?
    # -
  end

  def wise_salary
    @params
    # extract usd amount
  end
end
