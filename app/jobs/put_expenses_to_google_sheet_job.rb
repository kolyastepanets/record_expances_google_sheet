class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(category_name, sub_category_name, price_to_put_in_sheets, detect_month, who_paid)
    response = PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, who_paid, current_month: detect_month)
    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    total_sum_usd = UsdFloatFromStringPriceToPutInSheets.call(price_to_put_in_sheets)
    WriteDownHalfExpenses.call(who_paid, [cell_number], total_sum_usd, 0)
  end
end
