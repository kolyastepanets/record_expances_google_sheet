class DecreaseWiseUsdSavedAmountJob < ApplicationJob
  queue_as :default

  def perform(price)
    result = ReceiveWiseFromGoogleSheet.call
    price_to_put_in_sheets = "#{result[:wise_formula]} - #{price.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_wise_formula],
      page: 'Статистика накоплений'
    )
  end
end
