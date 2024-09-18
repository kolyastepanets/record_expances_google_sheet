class EnterSalaryFromSwift
  include CallableService

  def initialize(params)
    @params = params.deep_symbolize_keys
    @today_day = Date.today.day
    @month_to_enter, @cell_with_text_to_find_next_cell, @text_to_enter_nbu_usd_rate = init_params
  end

  def call
    enter_salary
    enter_nbu_rate
    enter_left_usd_fop
    # put_salary_to_income_page
  end

  private

  def init_params
    if Date.today.day.between?(10, 20)
      month_to_enter = Date.today.month + 1
      month_to_enter = 1 if year_sheet != Date.today.year
      cell_with_text_to_find_next_cell = 'Заплата 1ая половина $'
      text_to_enter_nbu_usd_rate = 'курс доллара 1ая зп'
    elsif Date.today.day.between?(21, 31)
      month_to_enter = Date.today.month + 1
      month_to_enter = 1 if year_sheet != Date.today.year
      cell_with_text_to_find_next_cell = 'Заплата 2ая половина $'
      text_to_enter_nbu_usd_rate = 'курс доллара 2ая зп'
    else
      month_to_enter = Date.today.month
      cell_with_text_to_find_next_cell = 'Заплата 2ая половина $'
      text_to_enter_nbu_usd_rate = 'курс доллара 2ая зп'
    end

    [month_to_enter, cell_with_text_to_find_next_cell, text_to_enter_nbu_usd_rate]
  end

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
      NbuUsdRate.call,
      coordinates_of_cell_to_enter_nbu_rate,
      page: year_sheet,
    )
  end

  def coordinates_to_enter_left_usd_and_usd
    return @coordinates_to_enter_left_usd_and_usd if defined? @coordinates_to_enter_left_usd_and_usd

    options = { month: @month_to_enter, year: year_sheet }
    @coordinates_to_enter_left_usd_and_usd = CalculateTotalSpentUsdAndUah.call(**options)
  end

  def enter_left_usd_fop
    UpdateCellInGoogleSheet.call(
      coordinates_to_enter_left_usd_and_usd[:total_left_usd_money] + @params[:dollars],
      coordinates_to_enter_left_usd_and_usd[:coordinates_of_total_left_usd_money],
      page: year_sheet,
    )
  end

  def put_salary_to_income_page
    PutSalaryToIncomePage.call(@params[:dollars], AllConstants::SALARY_ON_USD_FOP)
  end

  def year_sheet
    year_sheet = Date.today.year

    if Date.today.month == 12 && @today_day.between?(10, 31)
      year_sheet = Date.today.year + 1
    end

    year_sheet
  end
end
