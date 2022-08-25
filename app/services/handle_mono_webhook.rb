class HandleMonoWebhook
  include CallableService

  FOP_DOLLAR_CARD = "IJ8Y_c1UAwxRHa4vAlTivQ".freeze
  # GET_SALARY_FOP_DOLLAR_ACCOUNT = "".freeze

  def initialize(params)
    @params = params
  end

  def call
    return if @params.empty?

    case @params["data"]["account"]
    when FOP_DOLLAR_CARD
      EnterExpencesFopDollarCardFromWebhook.call(@params["data"]["statementItem"])
    end

    SaveDataFromMonoWebhook.call(@params)
  end
end
