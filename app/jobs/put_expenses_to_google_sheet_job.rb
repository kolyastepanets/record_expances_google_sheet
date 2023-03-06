class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(category_name, sub_category_name, price_to_put_in_sheets, detect_month)
    PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, current_month: detect_month)
  end
end
