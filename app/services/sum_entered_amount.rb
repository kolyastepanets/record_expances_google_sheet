class SumEnteredAmount
  include CallableService

  def initialize(entered_amount)
    @entered_amount = entered_amount
  end

  def call
    return @entered_amount.to_f if !@entered_amount.include?("+")

    @entered_amount.split("+").map(&:to_f).sum
  end
end
