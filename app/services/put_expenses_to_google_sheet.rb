class PutExpensesToGoogleSheet < GetOrSetDataInGoogleSheetBase
  class PutCategoryToGoogleSheetError < StandardError; end

  include CallableService

  VALUE_INPUT_OPTION = 'USER_ENTERED'.freeze

  def initialize(category, sub_category, price, current_month: nil)
    @category = category
    @sub_category = sub_category
    @price = price
    @date_today = Date.today
    @current_day = @date_today.day
    @current_month = current_month || @date_today.month
    @current_year = @date_today.year
  end

  private

  def prepare_request_data
    @values = [[
      @category,
      @sub_category,
      @price,
      @current_day,
      @current_month,
      @current_year,
      @date_today.strftime("%d.%m.%Y"),
      MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ","),
      MonobankCurrencyRates.call('EUR', 'USD').to_s.gsub(".", ",")
    ]]
    @range = "'Повседневные'!A:I"
  end

  def make_request
    service_google_sheet.append_spreadsheet_value(
      FIN_PLAN_SPREAD_SHEET_ID,
      @range,
      { values: @values },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    # nothing to return
  end
end
