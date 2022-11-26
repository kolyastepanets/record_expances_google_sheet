require 'rails_helper'

RSpec.describe WriteDownHalfExpenses do
  subject { described_class.call(how_divide_expenses, all_cells, total_sum_usd, total_sum_uah) }

  let(:how_divide_expenses) { AllConstants::MYKOLA_PAYED }
  let(:all_cells) { [5389, 5390, 5391, 5392, 5393, 5394] }
  let(:total_sum_usd) { 100 }
  let(:total_sum_uah) { 0 }
  let(:result_price_and_coordinates) do
    {
      :vika_total_sum_mono => 1340.0, # uah
      :vika_total_sum_mono_coordinates => "BQ105",

      :vika_total_sum_mono_cells => "6350-6351",
      :vika_total_sum_mono_cells_coordinates => "BQ106",

      :vika_total_sum_cash => 100000.0, # rupiah
      :vika_total_sum_cash_coordinates => "BQ107",

      :vika_total_sum_cash_cells => "6352",
      :vika_total_sum_cash_cells_coordinates => "BQ108",

      :mykola_total_sum_mono=>2433.0,
      :mykola_total_sum_mono_coordinates=>"BQ109",

      :mykola_total_sum_mono_cells=>"6424-6425-6426-6427",
      :mykola_total_sum_mono_cells_coordinates=>"BQ110"
    }
  end

  before do
    allow(FindCellToEnterVikaHalfExpenses).to receive(:call).and_return(result_price_and_coordinates)
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
  end

  context 'when should not divide expenses' do
    let(:how_divide_expenses) { '' }

    it 'does not call UpdateCellInGoogleSheet' do
      expect(UpdateCellInGoogleSheet).to_not receive(:call)
      expect(UpdateCellBackgroundColorRequest).to_not receive(:call)

      subject
    end
  end

  context 'when mykola paid' do
    context 'when price from uah black card' do
      let(:total_sum_usd) { 0 }
      let(:total_sum_uah) { 100 }

      it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
        expect(UpdateCellInGoogleSheet).to receive(:call).with(1390.0, "BQ105")
        expect(UpdateCellInGoogleSheet).to receive(:call).with("6350-6351-5389-5390-5391-5392-5393-5394", "BQ106")
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, 'yellow')

        subject
      end
    end

    context 'when price from usd card' do
      it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
        expect(UpdateCellInGoogleSheet).to receive(:call).with(3190.0, "BQ105")
        expect(UpdateCellInGoogleSheet).to receive(:call).with("6350-6351-5389-5390-5391-5392-5393-5394", "BQ106")
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, 'yellow')

        subject
      end
    end
  end

  context 'when vika paid' do
    let(:how_divide_expenses) { AllConstants::VIKA_PAYED }

    context 'when price from uah black card' do
      let(:total_sum_usd) { 0 }
      let(:total_sum_uah) { 100 }

      it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
        expect(UpdateCellInGoogleSheet).to receive(:call).with(2483.0, "BQ109")
        expect(UpdateCellInGoogleSheet).to receive(:call).with("6424-6425-6426-6427-5389-5390-5391-5392-5393-5394", "BQ110")
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, "orange")

        subject
      end
    end

    context 'when price from usd card' do
      let(:price_to_enter) { "=55383 / 15670,7692" }

      it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
        expect(UpdateCellInGoogleSheet).to receive(:call).with(4283.0, "BQ109")
        expect(UpdateCellInGoogleSheet).to receive(:call).with("6424-6425-6426-6427-5389-5390-5391-5392-5393-5394", "BQ110")
        expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 5389, 5395, 'orange')

        subject
      end
    end
  end
end
