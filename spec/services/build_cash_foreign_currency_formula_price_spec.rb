require 'rails_helper'

RSpec.describe BuildCashForeignCurrencyFormulaPrice do
  subject{ described_class.call(price) }

  let(:price) { 29.4 }

  before do
    allow(GetGoogleSheetCurrencyExchange).to receive(:call).and_return("36,92000")
    allow(MonobankCurrencyRates).to receive(:call).and_return("37.4995")
  end

  it 'returns price ready for google sheet' do
    expect(subject).to eq("=36,92000*29,4/37,4995")
  end
end
