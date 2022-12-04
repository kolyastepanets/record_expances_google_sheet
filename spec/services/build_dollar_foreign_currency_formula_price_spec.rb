require 'rails_helper'

RSpec.describe BuildDollarForeignCurrencyFormulaPrice do
  subject{ described_class.call(price, session) }

  let(:price) { 1.85 }
  let(:session) { { receipt_dollar_foreign_currency_exchange_rate: 0.8363 } }

  context 'when currency exchange in redis' do
    let(:currency_rates) do
      [
        {"currencyCodeA"=>840, "currencyCodeB"=>980, "date"=>1661116208, "rateBuy"=>36.65,    "rateSell"=>37.4995 },
        {"currencyCodeA"=>978, "currencyCodeB"=>980, "date"=>1661168409, "rateBuy"=>36.7,     "rateSell"=>37.5996 },
        {"currencyCodeA"=>978, "currencyCodeB"=>840, "date"=>1661176809, "rateBuy"=>0.997,    "rateSell"=>1.014   },
        {"currencyCodeA"=>826, "currencyCodeB"=>980, "date"=>1661201719, "rateCross"=>44.3995                     },
        {"currencyCodeA"=>392, "currencyCodeB"=>980, "date"=>1661200643, "rateCross"=>0.2763                      }
      ]
    end

    before do
      Redis.new.set("currency_rates", currency_rates.to_json)
    end

    it 'build formula for google sheet' do
      expect(subject).to eq("=1,85 / 0,8363 * 37,4995")
    end
  end

  context 'when currency exchange not in redis', vcr: true, freezed_time: '2022-08-22' do
    it 'makes request to monobank' do
      expect(subject).to eq("=1,85 / 0,8363 * 37,4995")
    end

    it 'saves to redis' do
      subject

      expect(Redis.new.get("currency_rates")).to_not be_nil
    end
  end
end
