class PutIncomeToGoogleSheet < GetOrSetDataInGoogleSheetBase
  def initialize(category, before_taxes_currency, after_taxes_currency, before_taxes_usd, after_taxes_usd, currency_rate, money_placed_to)
    @category = category
    @before_taxes_currency = before_taxes_currency
    @after_taxes_currency = after_taxes_currency
    @before_taxes_usd = before_taxes_usd
    @after_taxes_usd = after_taxes_usd
    @currency_rate = currency_rate
    @money_placed_to = money_placed_to
    @date_today = Date.today
    @current_day = @date_today.day
    @current_month = @date_today.month
    @current_year = @date_today.year
  end

  private

  def prepare_request_data
    @values = [[
      @category,
      @before_taxes_currency,
      @after_taxes_currency,
      @before_taxes_usd,
      @after_taxes_usd,
      @current_day,
      @current_month,
      @current_year,
      @date_today.strftime("%d.%m.%Y"),
      @currency_rate,
      @money_placed_to
    ]]
    @range = "'Доходы'!A:K"
  end

  def make_request
    @response = service_google_sheet.append_spreadsheet_value(
      ENV['FIN_PLAN_SPREAD_SHEET_ID'],
      @range,
      { values: @values },
      value_input_option: VALUE_INPUT_OPTION
    )
  end

  def parse_response
    @response
  end
end
