class PutExpencesUahWhiteCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_uah = params[:price_in_uah]

    price_in_usd_to_put_in_google_sheets = params[:price_in_uah_converted_to_usd_to_save_in_google_sheet]
    price_in_usd_to_put_in_google_sheets = "=#{price_in_uah.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}" if price_in_usd_to_put_in_google_sheets.nil?

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_usd_to_put_in_google_sheets,
    )
    SendNotificationMessageToBot.call(params)

    if params[:can_show_final_sum]
      is_gbp = false
      is_usd = false
      is_uah = true
      is_gbp_joint = false
      SendMessageTotalSumAfterFinishEnterMoney.call(is_gbp, is_gbp_joint, is_usd, is_uah, params[:total_sum_of_money_before_save])
    end
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
