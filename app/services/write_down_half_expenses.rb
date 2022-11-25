class WriteDownHalfExpenses
  include CallableService

  EVERY_DAY_EXPENSES_PAGE = 2079267030
  MAKE_REQUEST_EVERY_SECONDS = 5

  def initialize(response_after_save_expenses, how_divide_expenses, price_to_enter, month: nil, index: nil)
    @response_after_save_expenses = response_after_save_expenses
    @how_divide_expenses = how_divide_expenses
    @index = calculate_index(index)
    @price_to_enter = price_to_enter
    @month = month.to_s
  end

  def call
    return if @how_divide_expenses.blank?

    WriteDownHalfExpensesJob.set(wait: @index.seconds).perform_later(EVERY_DAY_EXPENSES_PAGE, line_number_saved_expenses, @price_to_enter, @month, @how_divide_expenses)
  end

  private

  def line_number_saved_expenses
    @line_number_saved_expenses ||= @response_after_save_expenses.table_range.split(":")[-1].match(/\d.*/)[0].to_i
  end

  def calculate_index(index)
    return 0 if index.nil?

    if index > MAKE_REQUEST_EVERY_SECONDS
      return MAKE_REQUEST_EVERY_SECONDS
    end

    index
  end
end
