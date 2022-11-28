class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(category_name, sub_category_name, price_to_put_in_sheets, detect_month, calculate_as_half_expenses)
    response = PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, current_month: detect_month)
    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    total_sum_usd = UsdFloatFromStringPriceToPutInSheets.call(price_to_put_in_sheets)
    WriteDownHalfExpenses.call(calculate_as_half_expenses, [cell_number], total_sum_usd, 0)
  end
end
