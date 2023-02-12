class RoundInGoogleSheetLikeInMonobank
  include CallableService

  def initialize(usd_fop_monobank, uah_fop_monobank)
    @usd_fop_monobank = usd_fop_monobank.split("usd fop in mono: ").last.delete("$").gsub(/[[:space:]]+/, "").gsub(",", ".").to_f.round(2)
    @uah_fop_monobank = uah_fop_monobank.split("uah in mono: ").last.delete(" грн").gsub(/[[:space:]]+/, "")
  end

  def call
    result = CalculateTotalSpentUsdAndUah.call

    UpdateCellInGoogleSheet.call(
      @uah_fop_monobank,
      result[:coordinates_of_total_left_uah_money],
    )

    dollars_in_google_sheet = ReceiveTotalFopSavedMoneyFromGoogleSheet.call.split("total fop saved money in google sheet: ").last.delete("$").gsub(/[[:space:]]+/, "").gsub(",", ".").to_f.round(2)
    dollars_to_save = (result[:total_left_usd_money] - (dollars_in_google_sheet - @usd_fop_monobank)).round(2).to_s.gsub(".", ",")
    UpdateCellInGoogleSheet.call(
      dollars_to_save,
      result[:coordinates_of_total_left_usd_money],
    )
  end
end
