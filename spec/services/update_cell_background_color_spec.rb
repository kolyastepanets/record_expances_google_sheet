require 'rails_helper'

RSpec.describe UpdateCellBackgroundColor do
  subject { described_class.call(who_paid, all_cells) }

  let(:who_paid) { AllConstants::MYKOLA_PAYED }
  let(:all_cells) { [5389, 5390, 5391, 5392, 5393, 5394] }

  before do
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
  end

  context 'when should not divide expenses' do
    let(:who_paid) { '' }

    it 'does not call UpdateCellBackgroundColorRequest' do
      expect(UpdateCellBackgroundColorRequest).to_not receive(:call)

      subject
    end
  end

  context 'when mykola paid' do
    context 'when price from uah black card' do
      it 'calls UpdateCellBackgroundColorRequest' do
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, 'yellow')

        subject
      end
    end

    context 'when price from usd card' do
      it 'calls UpdateCellBackgroundColorRequest' do
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, 'yellow')

        subject
      end
    end
  end

  context 'when vika paid' do
    let(:who_paid) { AllConstants::VIKA_PAYED }

    context 'when price from uah black card' do
      it 'calls UpdateCellBackgroundColorRequest' do
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, "orange")

        subject
      end
    end

    context 'when price from usd card' do
      it 'calls UpdateCellBackgroundColorRequest' do
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, 'orange')

        subject
      end
    end
  end
end
