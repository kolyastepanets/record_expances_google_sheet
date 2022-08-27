class PutExpencesUahBlackCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_uah = params[:price_in_uah]
    # uncomment when move to dollars
    # price_in_usd_to_put_in_google_sheets = "=#{price_in_uah.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"
    # uncomment when move to dollars

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_uah,
      # price_in_usd_to_put_in_google_sheets,
      params[:current_month],
    )

    result = CalculateTotalSpentUsdAndUah.call

    # decrease uah spent amount
    UpdateCommonCurrencyExpenses.call(
      result[:total_left_uah_money] - price_in_uah,
      result[:coordinates_of_total_left_uah_money],
    )

    NotifyEnteredExpencesFromWebhook.call(params)
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    NotifyEnteredExpencesFromWebhook.call(error_message)
  end
end
