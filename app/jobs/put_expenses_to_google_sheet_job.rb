class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(category_name, sub_category_name, price_to_put_in_sheets, detect_month, calculate_as_half_expenses)
    calculate_as_half_expenses_for_us = calculate_as_half_expenses == 'y'

    response = PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, current_month: detect_month)
    UpdateCellBackgroundColorInExpensesPageAsync.call(response, calculate_as_half_expenses_for_us)
  end
end
