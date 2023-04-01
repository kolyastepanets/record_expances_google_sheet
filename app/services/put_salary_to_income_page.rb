class PutSalaryToIncomePage
  include CallableService

  ESV_IN_UAH_PER_MONTH = 1474
  SINGLE_TAX = "0,05"

  def initialize(salary_in_usd, money_placed_to)
    @money_placed_to = money_placed_to
    @category = 'зп'
    @currency_rate = 1
    @before_taxes_currency = 0
    @after_taxes_currency = 0
    @before_taxes_usd = salary_in_usd.to_s.gsub(".", ",")
    @after_taxes_usd = calculate_after_taxes(salary_in_usd.to_s.gsub(".", ","))
  end

  def call
    PutIncomeToGoogleSheet.call(
      @category,
      @before_taxes_currency,
      @after_taxes_currency,
      @before_taxes_usd,
      @after_taxes_usd,
      @currency_rate,
      @money_placed_to
    )
  end

  private

  def calculate_after_taxes(salary_in_usd)
    case @money_placed_to
    when AllConstants::SALARY_ON_WISE
      salary_in_usd
    when AllConstants::SALARY_ON_USD_FOP
      esv_taxes = "#{ESV_IN_UAH_PER_MONTH} / #{NbuUsdRate.call.to_s.gsub(".", ",")}"

      "= #{salary_in_usd} - (#{salary_in_usd} * #{SINGLE_TAX}) - (#{esv_taxes})"
    end
  end
end
