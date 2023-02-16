class EnterExpencesWiseDollarCardFromWebhook
  include CallableService

  def initialize(params)
    @params = params
  end

  def call
    return save_as_kindergaten if kindergaten?

    SendMessageToBotToAskToEnterExpencesFromWise.call(@params)
  end

  private

  def kindergaten?
    @params[:reference] == 'Mark Stepanets'
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
