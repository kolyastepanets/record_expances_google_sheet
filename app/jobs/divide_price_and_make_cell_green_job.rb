class DividePriceAndMakeCellGreenJob < ApplicationJob
  queue_as :default

  EVERY_DAY_EXPENSES_PAGE = 2079267030

  def perform(coordinates_of_value)
    value = FindCellValueInEveryDayExpensesPage.call(coordinates_of_value.to_i + 1)

    if value.nil?
      SendNotificationMessageToBot.call("не смог найти цену, cell: #{coordinates_of_value.to_i + 1}")
      return
    end

    new_value = value.gsub(/[[:space:]]+/, "")
    new_value = "= #{new_value.delete('$')} / 2"
    price_cell = "C#{coordinates_of_value.to_i + 1}"
    UpdateCellInGoogleSheet.call(new_value, price_cell, page: 'Повседневные')

    UpdateCellBackgroundColorRequest.call(EVERY_DAY_EXPENSES_PAGE, coordinates_of_value, 'green')
  end
end
