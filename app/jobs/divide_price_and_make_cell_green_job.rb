class DividePriceAndMakeCellGreenJob < ApplicationJob
  queue_as :default

  EVERY_DAY_EXPENSES_PAGE = 2079267030

  def perform(coordinates_of_value)
    cell_number = coordinates_of_value.to_i
    next_cell_number = cell_number + 1
    value = FindCellValueInEveryDayExpensesPage.call(next_cell_number)

    if value.nil?
      SendNotificationMessageToBot.call("не смог найти цену, cell: #{next_cell_number}")
      return
    end

    new_value = "#{value} / 2"
    price_cell = "C#{next_cell_number}"
    UpdateCellInGoogleSheet.call(new_value, price_cell, page: 'Повседневные')

    UpdateCellBackgroundColorRequest.call(EVERY_DAY_EXPENSES_PAGE, cell_number, next_cell_number, 'green')
  end
end
