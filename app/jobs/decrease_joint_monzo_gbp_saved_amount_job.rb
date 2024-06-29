class DecreaseJointMonzoGbpSavedAmountJob < ApplicationJob
  queue_as :default

  def perform(price)
    result = ReceiveJointMonzoGbpFromGoogleSheet.call
    price_to_put_in_sheets = "#{result[:gbp_joint_monzo_formula]} - #{price.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_joint_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end
end
