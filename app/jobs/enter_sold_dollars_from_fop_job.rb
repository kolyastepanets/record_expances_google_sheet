class EnterSoldDollarsFromFopJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys

    result = CalculateTotalSpentUsdAndUah.call

    # increase uah amount
    UpdateCellInGoogleSheet.call(
      result[:total_left_uah_money] + params[:grivnas],
      result[:coordinates_of_total_left_uah_money],
    )

    # decrease usd amount
    UpdateCellInGoogleSheet.call(
      result[:total_left_usd_money] - params[:dollars],
      result[:coordinates_of_total_left_usd_money],
    )

    SendNotificationMessageToBot.call(params)
  rescue StandardError => e
    error_message = { exception: e, message: e.message }

    SendNotificationMessageToBot.call(error_message)
  end
end
