class RoundInGoogleSheetLikeInMonobank
  include CallableService

  def call
    result = CalculateTotalSpentUsdAndUah.call

    uah_to_save = ReceiveCurrentBalanceInMonobankFromMono.call.split("uah in mono: ").last.delete(" грн").gsub(/[[:space:]]+/, "")
    UpdateCellInGoogleSheet.call(
      uah_to_save,
      result[:coordinates_of_total_left_uah_money],
    )

    dollars_in_monobank = ReceiveUsdFopFromMonobank.call.split("usd fop in mono: ").last.delete("$").gsub(/[[:space:]]+/, "").gsub(",", ".").to_f.round(2)
    dollars_in_google_sheet = ReceiveTotalFopSavedMoneyFromGoogleSheet.call.split("total fop saved money in google sheet: ").last.delete("$").gsub(/[[:space:]]+/, "").gsub(",", ".").to_f.round(2)
    dollars_to_save = (result[:total_left_usd_money] - (dollars_in_google_sheet - dollars_in_monobank)).round(2).to_s.gsub(".", ",")
    UpdateCellInGoogleSheet.call(
      dollars_to_save,
      result[:coordinates_of_total_left_usd_money],
    )
  end
end
