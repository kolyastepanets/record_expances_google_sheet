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
    who_paid = params[:who_paid] if params.key?(:who_paid)

    price_to_put_in_sheets = params[:price_in_usd_to_save_in_google_sheet] || "=#{price_in_usd.to_s.gsub(".", ",")}"
    price_to_put_in_sheets = "#{price_to_put_in_sheets} / 2" if !who_paid.nil?

    response = PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_to_put_in_sheets,
      who_paid
    )

    redis.del('how_calculate_expenses_between_us')

    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    UpdateCellBackgroundColor.call(who_paid, [cell_number])

    # decrease usd saved amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCellInGoogleSheet.call(
      result[:total_left_usd_money] - price_in_usd,
      result[:coordinates_of_total_left_usd_money],
    )

    SendNotificationMessageToBot.call(params)

    if params[:can_show_final_sum]
      is_usd = true
      is_uah = false
      SendMessageTotalSumAfterFinishEnterMoney.call(is_usd, is_uah, params[:total_sum_of_money_before_save])
    end
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
