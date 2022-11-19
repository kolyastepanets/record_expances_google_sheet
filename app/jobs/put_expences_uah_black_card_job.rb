class PutExpencesUahBlackCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_uah = params[:price_in_uah]
    price_in_usd_to_put_in_google_sheets = "=#{price_in_uah.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"

    response = PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_usd_to_put_in_google_sheets,
    )

    calculate_as_half_expenses_for_us = redis.get('how_calculate_expenses_between_us') == 'calculate_as_half_expenses'
    redis.del('how_calculate_expenses_between_us')
    UpdateCellBackgroundColorInExpensesPage.call(response, calculate_as_half_expenses_for_us)

    # decrease uah spent amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCommonCurrencyExpenses.call(
      result[:total_left_uah_money] - price_in_uah,
      result[:coordinates_of_total_left_uah_money],
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
