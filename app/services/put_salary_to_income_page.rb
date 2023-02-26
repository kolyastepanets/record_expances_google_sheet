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
      esv_taxes = 0

      if Date.today.day.between?(10, 20)
        esv_taxes = "#{ESV_IN_UAH_PER_MONTH} / #{nbu_usd_rate.to_s.gsub(".", ",")}"
      end

      "= #{salary_in_usd} - (#{salary_in_usd} * #{SINGLE_TAX}) - (#{esv_taxes})"
    end
  end

  # VPN is needed to make request to NBU
  def nbu_usd_rate
    nbu_currency_rates = JSON.parse(Faraday.new(url: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json").get.body)
    nbu_currency_rates.detect { |rate| rate["r030"] == USD_CURRENCY_CODE }["rate"]
  end
end
