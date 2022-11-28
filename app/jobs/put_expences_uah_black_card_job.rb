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

    how_divide_expenses = case redis.get('how_calculate_expenses_between_us')
                          when 'calculate_as_mykola_paid_half_expenses'
                            AllConstants::MYKOLA_PAYED
                          when 'calculate_as_vika_paid_half_expenses'
                            AllConstants::VIKA_PAYED
                          else
                            nil
                          end
    redis.del('how_calculate_expenses_between_us')
    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    WriteDownHalfExpenses.call(how_divide_expenses, [cell_number], 0, price_in_uah)

    # decrease uah spent amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCellInGoogleSheet.call(
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
