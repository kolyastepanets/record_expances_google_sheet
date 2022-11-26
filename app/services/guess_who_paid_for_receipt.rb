class GuessWhoPaidForReceipt
  include CallableService

  def call
    case redis.get('how_calculate_expenses_between_us')
    when 'calculate_as_mykola_paid_half_expenses'
      AllConstants::MYKOLA_PAYED
    when 'calculate_as_vika_paid_half_expenses'
      AllConstants::VIKA_PAYED
    else
      nil
    end
  end

  private

  def redis
    @redis ||= Redis.new
  end
end
