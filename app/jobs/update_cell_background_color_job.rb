class UpdateCellBackgroundColorJob < ApplicationJob
  queue_as :default

  def perform(every_day_expenses_page, line_number_saved_expenses)
    UpdateCellBackgroundColorRequest.call(every_day_expenses_page, line_number_saved_expenses)
  end
end
