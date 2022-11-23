class DecreaseUsdSavedAmountJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys

    result = CalculateTotalSpentUsdAndUah.call

    UpdateCellInGoogleSheet.call(
      result[:total_left_usd_money] - params[:price_in_usd],
      result[:coordinates_of_total_left_usd_money],
    )
  end
end
