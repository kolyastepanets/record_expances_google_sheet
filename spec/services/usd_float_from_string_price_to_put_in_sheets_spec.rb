require 'rails_helper'

RSpec.describe UsdFloatFromStringPriceToPutInSheets do
  subject { described_class.call(price_to_put_in_sheets) }

  before do
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
  end

  context 'when price from uah black card' do
    let(:price_to_put_in_sheets) { "=55383 * 0,0024204 / 37,4406" }

    it 'return in usd' do
      expect(subject).to eq(4)
    end
  end

  context 'when price from usd card' do
    let(:price_to_put_in_sheets) { "=55383 / 15670,7692" }

    it 'return in usd' do
      expect(subject).to eq(4)
    end
  end

  context 'when price from cash' do
    let(:price_to_put_in_sheets) { "=0,0024204*55383/37,4406" }

    it 'return in usd' do
      expect(subject).to eq(4)
    end
  end

  context 'when price from metro' do
    let(:price_to_put_in_sheets) { "=(149,0 + 149,0 * 0,2) / 37,4406" }

    it 'return in usd' do
      expect(subject).to eq(5)
    end
  end

  context 'when nil' do
    let(:price_to_put_in_sheets) { nil }

    it 'return in usd' do
      expect(subject).to be_nil
    end
  end

  context 'when empty string' do
    let(:price_to_put_in_sheets) { "" }

    it 'return in usd' do
      expect(subject).to be_nil
    end
  end

  context 'when just usd price' do
    let(:price_to_put_in_sheets) { "=10000,0" }

    it 'return in usd' do
      expect(subject).to be_nil
    end
  end
end
