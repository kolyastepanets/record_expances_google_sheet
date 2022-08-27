class DecreaseUsdSavedAmount
  include CallableService

  def initialize(price_in_usd)
    @price_in_usd = price_in_usd
  end

  def call
    DecreaseUsdSavedAmountJob.perform_later({ price_in_usd: @price_in_usd })
  end
end
