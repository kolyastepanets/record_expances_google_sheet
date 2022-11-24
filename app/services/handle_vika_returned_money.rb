class HandleVikaReturnedMoney
  class HandleVikaReturnedMoneyError < StandardError; end

  include CallableService

  MAKE_REQUEST_EVERY = 10.seconds

  def initialize(data)
    _reserved_word, price, @transaction_id = data.split(':')
    @price = price.to_f
  end

  def call
    validate!
    delete_all_messages!
    divide_price_and_make_cell_green_job!
    update_sum_when_vika_returned_money_to_mykola!
    update_sum_when_mykola_returned_money_to_vika!
  end

  private

  def validate!
    can_automatically_calculate = false
    if !half_expenses_info[:vika_total_sum_mono].zero? && half_expenses_info[:mykola_total_sum_mono].zero?
      can_automatically_calculate = true
    elsif half_expenses_info[:vika_total_sum_mono].zero? && !half_expenses_info[:mykola_total_sum_mono].zero?
      can_automatically_calculate = true
    end

    if half_expenses_info[:vika_total_sum_mono_cells].present? && half_expenses_info[:mykola_total_sum_mono_cells].blank?
      can_automatically_calculate = true
    elsif half_expenses_info[:vika_total_sum_mono_cells].blank? && half_expenses_info[:mykola_total_sum_mono_cells].present?
      can_automatically_calculate = true
    end

    return if can_automatically_calculate

    raise HandleVikaReturnedMoneyError, "Нельзя автоматически посчитать: Вика должна гривен: #{half_expenses_info[:vika_total_sum_mono]}, Микола должен гривен: #{half_expenses_info[:mykola_total_sum_mono]}"
  end

  def delete_all_messages!
    res = Redis.new.get(@transaction_id)

    return if res.nil?

    params = JSON.parse(res).deep_symbolize_keys
    DeleteMessagesJob.perform_later(params[:message_ids].uniq)
  end

  def divide_price_and_make_cell_green_job!
    coordinates = vika_coordinates.presence || mykola_coordinates
    coordinates.each do |coordinates_of_value|
      DividePriceAndMakeCellGreenJob.set(wait: MAKE_REQUEST_EVERY).perform_later(coordinates_of_value)
    end
  end

  def update_sum_when_vika_returned_money_to_mykola!
    if vika_coordinates.any?
      vika_total_sum_mono = "= #{half_expenses_info[:vika_total_sum_mono].to_s.split('.')[0]} - #{@price.to_s.split('.')[0]}"
      UpdateCellInGoogleSheet.call(vika_total_sum_mono, half_expenses_info[:vika_total_sum_mono_coordinates])
      UpdateCellInGoogleSheet.call('', half_expenses_info[:vika_total_sum_mono_cells_coordinates])

      # increase uah spent amount
      UpdateCellInGoogleSheet.call(spent_usd_and_uah[:total_left_uah_money] + @price, spent_usd_and_uah[:coordinates_of_total_left_uah_money])
    end
  end

  def update_sum_when_mykola_returned_money_to_vika!
    if mykola_coordinates.any?
      mykola_total_sum_mono = "= #{half_expenses_info[:mykola_total_sum_mono].to_s.split('.')[0]} - #{@price.to_s.split('.')[0]}"
      UpdateCellInGoogleSheet.call(mykola_total_sum_mono, half_expenses_info[:mykola_total_sum_mono_coordinates])
      UpdateCellInGoogleSheet.call('', half_expenses_info[:mykola_total_sum_mono_cells_coordinates])

      # decrease uah spent amount
      UpdateCellInGoogleSheet.call(spent_usd_and_uah[:total_left_uah_money] - @price, spent_usd_and_uah[:coordinates_of_total_left_uah_money])
    end
  end

  def vika_coordinates
    @vika_coordinates ||= half_expenses_info[:vika_total_sum_mono_cells].split('-')
  end

  def mykola_coordinates
    @mykola_coordinates ||= half_expenses_info[:mykola_total_sum_mono_cells].split('-')
  end

  def half_expenses_info
    @half_expenses_info ||= FindCellToEnterVikaHalfExpenses.call
  end

  def spent_usd_and_uah
    @spent_usd_and_uah ||= CalculateTotalSpentUsdAndUah.call
  end
end
