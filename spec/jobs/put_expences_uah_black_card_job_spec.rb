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

  context 'when mykola paid' do
    around(:each) do |example|
      Redis.new.set('how_calculate_expenses_between_us', 'calculate_as_mykola_paid_half_expenses')
      example.run
      Redis.new.del('how_calculate_expenses_between_us')
    end

    it 'calls PutExpensesToGoogleSheet, WriteDownHalfExpenses' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=200,25 / 37,4406').and_return(nil)
      expect(WriteDownHalfExpenses).to receive(:call).with(nil, 'm', '=200,25 / 37,4406')
      expect(UpdateCellInGoogleSheet).to receive(:call).with(16079.75, 'BQ82')
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end
  end

  context 'when vika paid' do
    around(:each) do |example|
      Redis.new.set('how_calculate_expenses_between_us', 'calculate_as_vika_paid_half_expenses')
      example.run
      Redis.new.del('how_calculate_expenses_between_us')
    end

    it 'calls PutExpensesToGoogleSheet, WriteDownHalfExpenses' do
      expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=200,25 / 37,4406').and_return(nil)
      expect(WriteDownHalfExpenses).to receive(:call).with(nil, 'v', '=200,25 / 37,4406')
      expect(UpdateCellInGoogleSheet).to receive(:call).with(16079.75, 'BQ82')
      expect(SendNotificationMessageToBot).to receive(:call).with(params)

      perform_enqueued_jobs { subject }
    end
  end
end