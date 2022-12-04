require 'rails_helper'

RSpec.describe BuildPrice do
  subject{ described_class.call(price, session_object) }

  let(:price) { 1.85 }
  let(:session_object) do
    {
      foreigh_cash_amount: 0,
    }
  end

  before do
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4995")
  end

  it 'returns prices' do
    expect(subject).to eq([1.85, 1.85])
  end

  context 'when foreigh_cash_amount' do
    before do
      allow(BuildCashForeignCurrencyFormulaPrice).to receive(:call).and_return("=36,92000*1.85")
    end

    let(:session_object) do
      {
        foreigh_cash_amount: 10,
      }
    end

    it 'returns prices' do
      expect(subject).to eq(["=36,92000*1.85", 1.85])
    end
  end

  context 'when is_metro' do
    let(:session_object) do
      {
        foreigh_cash_amount: 0,
        is_metro: true,
      }
    end

    it 'returns prices' do
      expect(subject).to eq(["=(1,85 + 1,85 * 0,2) / 37,4995", 2.22])
    end
  end

  context 'when receipt_foreign_currency_exchange_rate' do
    let(:session_object) do
      {
        foreigh_cash_amount: 0,
        receipt_foreign_currency_exchange_rate: 45,
      }
    end

    it 'returns prices' do
      expect(subject).to eq(["=45 * 1,85 / 37,4995", 83.25])
    end
  end

  context 'when receipt_dollar_foreign_currency_exchange_rate' do
    before do
      allow(BuildDollarForeignCurrencyFormulaPrice).to receive(:call).and_return("=1,85 / 0,8363 * 37,4995")
    end

    let(:session_object) do
      {
        foreigh_cash_amount: 0,
        receipt_dollar_foreign_currency_exchange_rate: 0.8363,
      }
    end

    it 'returns prices' do
      expect(subject).to eq(["=1,85 / 0,8363", 2.2121248355853163])
    end
  end
end
