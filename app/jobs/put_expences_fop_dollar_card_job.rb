class PutExpencesFopDollarCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_usd = params[:price_in_usd]
    price_to_put_in_sheets = params[:price_in_usd_to_save_in_google_sheet] || "=#{price_in_usd.to_s.gsub(".", ",")}"

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_to_put_in_sheets
    )

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
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end

  def redis
    @redis ||= Redis.new
  end
end
