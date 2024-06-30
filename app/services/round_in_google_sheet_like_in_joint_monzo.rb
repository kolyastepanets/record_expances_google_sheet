class RoundInGoogleSheetLikeInJointMonzo
  include CallableService

  def initialize(gbp_from_monzo)
    @gbp_from_monzo = gbp_from_monzo.split("gbp joint in monzo: ").last.delete("£").gsub(/[[:space:]]+/, "").gsub(",", ".").to_f.round(2)
  end

  def call
    result = ReceiveJointMonzoGbpFromGoogleSheet.call
    price_to_put_in_sheets = "=#{@gbp_from_monzo.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_joint_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end
end
