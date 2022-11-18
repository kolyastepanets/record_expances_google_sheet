require 'rails_helper'

RSpec.describe HandleHalfCalculatedExpensesJob do
  subject { described_class.perform_later(sheet_id, line_number_saved_expenses, price_to_enter, month) }

  let(:sheet_id) { 123456789 }
  let(:line_number_saved_expenses) { 5389 }
  let(:price_to_enter) { "=75000 * 0,0024204 / 37,4406" }
  let(:month) { nil }
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
    }
  end

  before do
    allow(FindCellToEnterVikaHalfExpenses).to receive(:call).and_return(result_price_and_coordinates)
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
  end

  context 'when price from uah black card' do
    let(:price_to_enter) { "=55383 * 0,0024204 / 37,4406" }

    it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1406.0, "BQ105")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("6350-6351-5389", "BQ106")
      expect(UpdateCellBackgroundColorRequest).to receive(:call).with(123456789, 5389, 'yellow')

      perform_enqueued_jobs { subject }
    end
  end

  context 'when price from usd card' do
    let(:price_to_enter) { "=55383 / 15670,7692" }

    it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1405.0, "BQ105")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("6350-6351-5389", "BQ106")
      expect(UpdateCellBackgroundColorRequest).to receive(:call).with(123456789, 5389, 'yellow')

      perform_enqueued_jobs { subject }
    end
  end

  context 'when price from cash' do
    let(:month) { '11,1' }
    let(:price_to_enter) { "=0,002457*55383/37,4406" }

    it 'calls UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
      expect(UpdateCellInGoogleSheet).to receive(:call).with(127691.0, "BQ107")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("6352-5389", "BQ108")
      expect(UpdateCellBackgroundColorRequest).to receive(:call).with(123456789, 5389, 'yellow')

      perform_enqueued_jobs { subject }
    end
  end
end
