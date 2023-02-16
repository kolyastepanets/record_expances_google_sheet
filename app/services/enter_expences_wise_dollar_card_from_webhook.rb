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
    @params
  end

  def save_as_kindergaten
    kindergaten_params = {
      category_name: 'Марк',
      sub_category_name: 'Дет сад'
      price: 123,
      who_paid: nil
    }
    PutExpencesWiseDollarCardJob.perform_later(kindergaten_params)
  end
end
