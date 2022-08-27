class DecreaseUahSavedAmount
  include CallableService

  def initialize(price_in_uah)
    @price_in_uah = price_in_uah
  end

  def call
    DecreaseUahSavedAmountJob.perform_later({ price_in_uah: @price_in_uah })
  end
end
