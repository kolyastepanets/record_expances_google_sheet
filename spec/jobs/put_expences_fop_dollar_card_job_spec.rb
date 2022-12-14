require 'rails_helper'

RSpec.describe PutExpencesFopDollarCardJob do
  subject { described_class.perform_later(params) }

  before do
    allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return(calculate_total_spent_usd_and_uah)
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
  end

  let(:params) do
    {
      category_name: 'Еда',
      sub_category_name: 'Фрукты',
      price_in_usd: 100,
      price_in_usd_to_save_in_google_sheet: "=15000,0 / 15202,0"
    }
  end
  let(:calculate_total_spent_usd_and_uah) do
    {
      :total_left_uah_money=>16280.0,
      :coordinates_of_total_left_uah_money=>"BQ82",
      :total_left_usd_money=>3676.0,
      :coordinates_of_total_left_usd_money=>"BQ81"
    }
  end
  let(:response_after_save_expenses) do
    OpenStruct.new(
      table_range: "A5389"
    )
  end

  context 'when mykola paid' do
    before do
      Redis.new.set('how_calculate_expenses_between_us', 'calculate_as_mykola_paid_half_expenses')
    end

    it 'calls PutExpensesToGoogleSheet, WriteDownHalfExpenses' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', "=15000,0 / 15202,0", "m").and_return(response_after_save_expenses)
      expect(WriteDownHalfExpenses).to receive(:call).with("m", [5389], 1, 0)
      expect(UpdateCellInGoogleSheet).to receive(:call).with(3576.0, 'BQ81')
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end

    context 'when price_in_usd_to_save_in_google_sheet nil' do
      let(:params) do
        {
          category_name: 'Еда',
          sub_category_name: 'Фрукты',
          price_in_usd: 100,
          price_in_usd_to_save_in_google_sheet: nil
        }
      end

      it 'calls PutExpensesToGoogleSheet, WriteDownHalfExpenses' do
        expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', 100, "m").and_return(response_after_save_expenses)
        expect(WriteDownHalfExpenses).to receive(:call).with("m", [5389], 100, 0)
        expect(UpdateCellInGoogleSheet).to receive(:call).with(3576.0, 'BQ81')
        expect(SendNotificationMessageToBot).to receive(:call).with(params)

        perform_enqueued_jobs { subject }
      end
    end
  end

  context 'when vika paid' do
    before do
      Redis.new.set('how_calculate_expenses_between_us', 'calculate_as_vika_paid_half_expenses')
    end

    it 'calls PutExpensesToGoogleSheet, WriteDownHalfExpenses' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', "=15000,0 / 15202,0", "v").and_return(response_after_save_expenses)
      expect(WriteDownHalfExpenses).to receive(:call).with("v", [5389], 1, 0)
      expect(UpdateCellInGoogleSheet).to receive(:call).with(3576.0, 'BQ81')
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end
  end
end
