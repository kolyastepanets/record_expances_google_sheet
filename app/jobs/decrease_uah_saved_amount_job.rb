class DecreaseUahSavedAmountJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys

    result = CalculateTotalSpentUsdAndUah.call

    UpdateCommonCurrencyExpenses.call(
      result[:total_left_uah_money] - params[:price_in_uah],
      result[:coordinates_of_total_left_uah_money],
    )
  end
end
