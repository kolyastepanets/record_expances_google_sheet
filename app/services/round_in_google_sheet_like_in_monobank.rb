class RoundInGoogleSheetLikeInMonobank
  include CallableService

  def initialize(uah_fop_monobank)
    @uah_fop_monobank = uah_fop_monobank.split("uah in mono: ").last.delete(" грн").gsub(/[[:space:]]+/, "")
  end

  def call
    result = CalculateTotalSpentUsdAndUah.call

    UpdateCellInGoogleSheet.call(
      @uah_fop_monobank,
      result[:coordinates_of_total_left_uah_money],
    )
  end
end
