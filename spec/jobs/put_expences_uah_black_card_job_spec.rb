require 'rails_helper'

RSpec.describe PutExpencesUahBlackCardJob do
  subject { described_class.perform_later(params) }

  before do
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
    allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return(calculate_total_spent_usd_and_uah)
  end

  let(:params) do
    {
      category_name: 'Еда',
      sub_category_name: 'Фрукты',
      price_in_uah: 200.25
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

    it 'calls PutExpensesToGoogleSheet, UpdateCellBackgroundColor' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=200,25 / 37,4406 / 2', "m").and_return(response_after_save_expenses)
      expect(UpdateCellBackgroundColor).to receive(:call).with("m", [5389])
      expect(UpdateCellInGoogleSheet).to receive(:call).with(16079.75, 'BQ82')
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end
  end

  context 'when vika paid' do
    before do
      Redis.new.set('how_calculate_expenses_between_us', 'calculate_as_vika_paid_half_expenses')
    end

    it 'calls PutExpensesToGoogleSheet, UpdateCellBackgroundColor' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=200,25 / 37,4406 / 2', "v").and_return(response_after_save_expenses)
      expect(UpdateCellBackgroundColor).to receive(:call).with("v", [5389])
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end
  end

  context 'when all our expenses' do
    it 'calls PutExpensesToGoogleSheet, UpdateCellBackgroundColor' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=200,25 / 37,4406', nil).and_return(response_after_save_expenses)
      expect(UpdateCellBackgroundColor).to receive(:call).with(nil, [5389])
      expect(UpdateCellInGoogleSheet).to receive(:call).with(16079.75, 'BQ82')
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end
  end
end
