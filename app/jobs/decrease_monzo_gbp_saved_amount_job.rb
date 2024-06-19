class DecreaseMonzoGbpSavedAmountJob < ApplicationJob
  queue_as :default

  def perform(price)
    result = ReceiveMonzoGbpFromGoogleSheet.call
    price_to_put_in_sheets = "#{result[:gbp_monzo_formula]} - #{price.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end
end
