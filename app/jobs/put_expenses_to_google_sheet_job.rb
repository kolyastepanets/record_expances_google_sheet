class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(category_name, sub_category_name, price_to_put_in_sheets, detect_month, calculate_as_half_expenses)
    response = PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, current_month: detect_month)
    WriteDownHalfExpenses.call(response, calculate_as_half_expenses, price_to_put_in_sheets, month: detect_month)
  end
end
