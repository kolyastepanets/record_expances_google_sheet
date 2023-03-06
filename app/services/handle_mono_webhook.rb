class HandleMonoWebhook
  include CallableService

  FOP_DOLLAR_CARD = "IJ8Y_c1UAwxRHa4vAlTivQ".freeze
  BLACK_UAH_CARD = "C0Hfjf2vrc00CZ_1ZCjSLg".freeze

  def initialize(params)
    @params = JSON.parse(params.to_json).deep_symbolize_keys
  end

  # code must be executed less than 5 sec to not receive one mpre webhook
  def call
    return if @params.empty?

    case @params[:data][:account]
    when FOP_DOLLAR_CARD
      EnterExpencesFopDollarCardFromWebhook.call(@params[:data][:statementItem])
    when BLACK_UAH_CARD
      EnterExpencesUahBlackCardFromWebhook.call(@params[:data][:statementItem])
    end

    TestJob.perform_later(@params)
  end
end
