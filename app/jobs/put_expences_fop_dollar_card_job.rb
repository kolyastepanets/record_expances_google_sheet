class PutExpencesFopDollarCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_usd = params[:price_in_usd]

    who_paid = case redis.get('how_calculate_expenses_between_us')
               when 'calculate_as_mykola_paid_half_expenses'
                 AllConstants::MYKOLA_PAYED
               when 'calculate_as_vika_paid_half_expenses'
                AllConstants::VIKA_PAYED
               else
                 nil
               end

    response = PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      params[:price_in_usd_to_save_in_google_sheet] || price_in_usd,
      who_paid
    )

    redis.del('how_calculate_expenses_between_us')

    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    total_sum_usd = UsdFloatFromStringPriceToPutInSheets.call(params[:price_in_usd_to_save_in_google_sheet]) || price_in_usd
    WriteDownHalfExpenses.call(who_paid, [cell_number], total_sum_usd, 0)

    # decrease usd saved amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCellInGoogleSheet.call(
      result[:total_left_usd_money] - price_in_usd,
      result[:coordinates_of_total_left_usd_money],
    )

    SendNotificationMessageToBot.call(params)
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message)
    else
      raise e
    end
  end

  def redis
    @redis ||= Redis.new
  end
end
