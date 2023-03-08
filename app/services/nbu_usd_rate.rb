# VPN is needed to make request to NBU

class NbuUsdRate
  include CallableService

  USD_CURRENCY_CODE = 840

  def call
    nbu_currency_rates = JSON.parse(Faraday.new(url: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json").get.body)
    nbu_currency_rates.detect { |rate| rate["r030"] == USD_CURRENCY_CODE }["rate"]
  end
end
