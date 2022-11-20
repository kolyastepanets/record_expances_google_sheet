class PutExpencesFopDollarCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_usd = params[:price_in_usd]

    response = PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      params[:price_in_usd_to_save_in_google_sheet] || price_in_usd,
    )

    calculate_as_half_expenses_for_us = redis.get('how_calculate_expenses_between_us') == 'calculate_as_half_expenses'
    redis.del('how_calculate_expenses_between_us')
    UpdateCellBackgroundColorInExpensesPageAsync.call(response, calculate_as_half_expenses_for_us)

    # decrease usd saved amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCommonCurrencyExpenses.call(
      result[:total_left_usd_money] - price_in_usd,
      result[:coordinates_of_total_left_usd_money],
    )

    SendNotificationMessageToBot.call(params)
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    SendNotificationMessageToBot.call(error_message)
  end

  def redis
    @redis ||= Redis.new
  end
end
