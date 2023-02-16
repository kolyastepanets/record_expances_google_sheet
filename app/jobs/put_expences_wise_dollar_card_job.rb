class PutExpencesWiseDollarCardJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys

    PutExpensesToGoogleSheet.call(
      params[:category_name],
      params[:sub_category_name],
      params[:price],
      params[:who_paid]
    )

    result = ReceiveWiseFromGoogleSheet.call
    price_to_put_in_sheets = "#{result[:wise_formula]} - #{price.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_wise_formula],
      page: 'Статистика накоплений'
    )

    SendNotificationMessageToBot.call(params)
  rescue StandardError => e
    if Rails.env.production?
      error_message = { exception: e, message: e.message }
      SendNotificationMessageToBot.call(error_message, show_reply_markup_main_buttons: true)
    else
      raise e
    end
  end
end
