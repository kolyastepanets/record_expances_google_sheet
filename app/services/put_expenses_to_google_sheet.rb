class PutExpensesToGoogleSheet < GetOrSetDataInGoogleSheetBase
  def initialize(category, sub_category, price, who_paid, current_month: nil)
    @category = category
    @sub_category = sub_category
    @price = price
    @date_today = Date.today
    @current_day = @date_today.day
    @current_month = current_month || @date_today.month
    @current_year = @date_today.year
    @who_paid = who_paid
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
      MonobankCurrencyRates.call('EUR', 'USD').to_s.gsub(".", ","),
      @who_paid
    ]]
    @range = "'Повседневные'!A:J"
  end

  def make_request
    @response = service_google_sheet.append_spreadsheet_value(
      FIN_PLAN_SPREAD_SHEET_ID,
      @range,
      { values: @values },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    @response
  end
end
