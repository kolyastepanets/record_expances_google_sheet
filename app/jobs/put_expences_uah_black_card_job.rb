class PutExpencesUahBlackCardJob < ApplicationJob
  queue_as :default

  MAX_SIZE_USD = 6 # e.g. $100.01

  def perform(params)
    params = params.deep_symbolize_keys
    price_in_uah = params[:price_in_uah]

    price_in_usd_to_put_in_google_sheets = params[:price_in_uah_converted_to_usd_to_save_in_google_sheet]
    price_in_usd_to_put_in_google_sheets = "=#{price_in_uah.to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}" if price_in_usd_to_put_in_google_sheets.nil?

    if params[:category_name] == 'Кэш' && params[:operation_amount].to_s.size <= MAX_SIZE_USD
      Telegram.bot.send_message(
        chat_id: ENV['MY_TELEGRAM_ID'],
        text: "Cash was not saved, cash withdraw in usd, fill in manually, all params: #{params}",
        reply_markup: AllConstants::REPLY_MARKUP_MAIN_BUTTONS
      )
      return
    end

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      price_in_usd_to_put_in_google_sheets,
    )
    IncreaseCashAmount.call(params)

    # decrease uah spent amount
    result = CalculateTotalSpentUsdAndUah.call
    UpdateCellInGoogleSheet.call(
      result[:total_left_uah_money] - price_in_uah,
      result[:coordinates_of_total_left_uah_money],
    )
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
