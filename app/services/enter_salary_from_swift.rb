class EnterSalaryFromSwift
  include CallableService

  USD_CURRENCY_CODE = 840

  def initialize(params)
    @params = params.deep_symbolize_keys
    @today_day = Date.today.day
  end

  def call
    if @today_day.between?(10, 20)
      @month_to_enter = Date.today.month + 1
      @month_to_enter = 1 if year_sheet != Date.today.year
      @cell_with_text_to_find_next_cell = 'Заплата 1ая половина $'
      @text_to_enter_nbu_usd_rate = 'курс доллара 1ая зп'
    elsif @today_day.between?(21, 31)
      @month_to_enter = Date.today.month + 1
      @month_to_enter = 1 if year_sheet != Date.today.year
      @cell_with_text_to_find_next_cell = 'Заплата 2ая половина $'
      @text_to_enter_nbu_usd_rate = 'курс доллара 2ая зп'
    else
      @month_to_enter = Date.today.month
      @cell_with_text_to_find_next_cell = 'Заплата 2ая половина $'
      @text_to_enter_nbu_usd_rate = 'курс доллара 2ая зп'
    end

    enter_salary
    enter_nbu_rate
    enter_left_usd_fop
  end

  private

  def coordinates_of_cell_to_enter_salary
    FindCellToEnterSalaryOrNbuCurrencyRate.call(@month_to_enter, year_sheet, @cell_with_text_to_find_next_cell)
  end

  def enter_salary
    UpdateCellInGoogleSheet.call(
      @params[:dollars],
      coordinates_of_cell_to_enter_salary,
      page: year_sheet,
    )
  end

  def coordinates_of_cell_to_enter_nbu_rate
    FindCellToEnterSalaryOrNbuCurrencyRate.call(@month_to_enter, year_sheet, @text_to_enter_nbu_usd_rate)
  end

  def enter_nbu_rate
    UpdateCellInGoogleSheet.call(
      nbu_usd_rate,
      coordinates_of_cell_to_enter_nbu_rate,
      page: year_sheet,
    )
  end

  def coordinates_to_enter_left_usd_and_usd
    @coordinates_to_enter_left_usd_and_usd ||= CalculateTotalSpentUsdAndUah.call(month: @month_to_enter)
  end

  def enter_left_usd_fop
    UpdateCellInGoogleSheet.call(
      coordinates_to_enter_left_usd_and_usd[:total_left_usd_money] + @params[:dollars],
      coordinates_to_enter_left_usd_and_usd[:coordinates_of_total_left_usd_money],
      page: year_sheet,
    )
  end

  def year_sheet
    year_sheet = Date.today.year

    if Date.today.month == 12 && @today_day.between?(10, 31)
      year_sheet = Date.today.year + 1
    end

    year_sheet
  end

  def nbu_usd_rate
    nbu_currency_rates = JSON.parse(Faraday.new(url: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json").get.body)
    nbu_currency_rates.detect { |rate| rate["r030"] == USD_CURRENCY_CODE }["rate"]
  end
end
