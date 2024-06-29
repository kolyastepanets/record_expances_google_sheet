class PutExpencesGbpMonzoCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_gbp = params[:price_in_gbp]
    price_to_put_in_sheets = params[:price_in_gbp_to_save_in_google_sheet]

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_to_put_in_sheets
    )

    # decrease gbp saved amount
    result = ReceiveMonzoGbpFromGoogleSheet.call
    decreased_price_to_put_in_sheets = "#{result[:gbp_monzo_formula]} - #{price_in_gbp.to_s.gsub(".", ",")}"
    UpdateCellInGoogleSheet.call(
      decreased_price_to_put_in_sheets,
      result[:coordinates_of_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )

    SendNotificationMessageToBot.call(params)

    if params[:can_show_final_sum]
      is_gbp = true
      is_usd = false
      is_uah = false
      is_gbp_joint = false
      SendMessageTotalSumAfterFinishEnterMoney.call(is_gbp, is_gbp_joint, is_usd, is_uah, params[:total_sum_of_money_before_save])
      SendInfoHowMuchMoneyCanSpendThisWeekJob.perform_later([params[:category_name]])
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
