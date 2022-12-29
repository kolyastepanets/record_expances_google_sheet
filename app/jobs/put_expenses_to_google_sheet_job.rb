class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(category_name, sub_category_name, price_to_put_in_sheets, detect_month, who_paid)
    price_to_put_in_sheets_divided = who_paid.nil? ? price_to_put_in_sheets : "#{price_to_put_in_sheets} / 2"
    response = PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets_divided, who_paid, current_month: detect_month)
    cell_number = response.table_range.split(":")[-1].match(/\d.*/)[0].to_i
    UpdateCellBackgroundColor.call(who_paid, [cell_number])
  end
end
