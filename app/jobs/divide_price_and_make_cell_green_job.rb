class DividePriceAndMakeCellGreenJob < ApplicationJob
  queue_as :default

  def perform(coordinates_of_value)
    cell_number = coordinates_of_value.to_i
    next_cell_number = cell_number + 1

    UpdateCellBackgroundColorRequest.call(ENV['EVERY_DAY_EXPENSES_PAGE'], cell_number, next_cell_number, 'green')
  end
end
