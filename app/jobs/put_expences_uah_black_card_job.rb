class PutExpencesUahBlackCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_uah = params[:price_in_uah]
    # uncomment when move to dollars
    # price_in_usd = MonobankCurrencyRates.call('USD', 'UAH') * price_in_uah
    # uncomment when move to dollars

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_uah,
      params[:current_month],
    )

    result = CalculateTotalSpentUsdAndUah.call

    # increase uah spent amount
    UpdateCommonCurrencyExpenses.call(
      result[:total_spent_uah_money] + price_in_uah,
      result[:coordinates_of_total_spent_uah_money],
    )
  end
end
