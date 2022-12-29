class UpdateCellBackgroundColor
  include CallableService

  EVERY_DAY_EXPENSES_PAGE = 2079267030

  def initialize(who_paid, all_cells)
    @who_paid = who_paid
    @all_cells = all_cells
  end

  def call
    return if @who_paid.blank?

    UpdateCellBackgroundColorRequest.call(EVERY_DAY_EXPENSES_PAGE, @all_cells[0], (@all_cells[-1] + 1), color)
  end

  private

  def color
    return 'yellow' if @who_paid == AllConstants::MYKOLA_PAYED
    return 'orange' if @who_paid == AllConstants::VIKA_PAYED
  end
end
