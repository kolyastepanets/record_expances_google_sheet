class PutExpensesToGoogleSheetJob < ApplicationJob
  queue_as :default

  def perform(params)
    params = params.deep_symbolize_keys
    category_name = params[:category_name]
    sub_category_name = params[:sub_category_name]
    price_to_put_in_sheets = params[:price_to_put_in_sheets]
    detect_month = params[:detect_month]
    calculate_as_half_expenses = params[:calculate_as_half_expenses] == 'y'

    response = PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets, current_month: detect_month)
    UpdateCellBackgroundColorInExpensesPage.call(response, calculate_as_half_expenses)
  end
end
