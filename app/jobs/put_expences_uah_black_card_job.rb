class PutExpencesUahBlackCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_uah = params[:price_in_uah]

    who_paid = case redis.get('how_calculate_expenses_between_us')
               when 'calculate_as_mykola_paid_half_expenses'
                 AllConstants::MYKOLA_PAYED
               when 'calculate_as_vika_paid_half_expenses'
                AllConstants::VIKA_PAYED
               else
                 nil
               end
    who_paid = params[:who_paid] if params.key?(:who_paid)

    price_in_usd_to_put_in_google_sheets = params[:price_in_uah_converted_to_usd_to_save_in_google_sheet]
    price_in_usd_to_put_in_google_sheets = "=#{price_in_uah.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}" if price_in_usd_to_put_in_google_sheets.nil?
    price_in_usd_to_put_in_google_sheets = "#{price_in_usd_to_put_in_google_sheets} / 2" if !who_paid.nil?

    response = PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_usd_to_put_in_google_sheets,
      who_paid,
    )
    IncreaseCashAmount.call(params)

    redis.del('how_calculate_expenses_between_us')
    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    UpdateCellBackgroundColor.call(who_paid, [cell_number])

    if who_paid != AllConstants::VIKA_PAYED
      # decrease uah spent amount
      result = CalculateTotalSpentUsdAndUah.call
      UpdateCellInGoogleSheet.call(
        result[:total_left_uah_money] - price_in_uah,
        result[:coordinates_of_total_left_uah_money],
      )
    end

    SendNotificationMessageToBot.call(params)

    if params[:can_show_final_sum]
      is_usd = false
      is_uah = true
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
