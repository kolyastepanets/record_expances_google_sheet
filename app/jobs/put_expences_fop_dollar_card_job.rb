class PutExpencesFopDollarCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_usd = params[:price_in_usd]
    # remove when move to USD
    price_in_uah = price_in_usd * MonobankCurrencyRates.call('USD', 'UAH')
    # remove when move to USD

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_uah,
      # price_in_usd,
      params[:current_month],
    )

    result = CalculateTotalSpentUsdAndUah.call

    # decrease usd saved amount
    UpdateCommonCurrencyExpenses.call(
      result[:total_left_usd_money] - price_in_usd,
      result[:coordinates_of_total_left_usd_money],
    )

    NotifyEnteredExpencesFromWebhook.call(params)
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    NotifyEnteredExpencesFromWebhook.call(error_message)
  end
end