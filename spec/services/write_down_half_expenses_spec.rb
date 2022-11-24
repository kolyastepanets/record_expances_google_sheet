require 'rails_helper'

RSpec.describe WriteDownHalfExpenses do
  subject { described_class.call(response_after_save_expenses, how_divide_expenses, price_to_enter, month: month, index: index) }

  let(:response_after_save_expenses) do
    OpenStruct.new(
      table_range: "A5389"
    )
  end
  let(:how_divide_expenses) { AllConstants::MYKOLA_PAYED }
  let(:price_to_enter) { "=75000 * 0,0024204 / 37,4406" }
  let(:month) { 1 }
  let(:index) { 2 }

  context 'when should not divide expenses' do
    let(:how_divide_expenses) { '' }

    it 'does not call WriteDownHalfExpensesJob' do
      expect(WriteDownHalfExpensesJob).to_not receive(:perform_later)

      subject
    end
  end

  context 'when should divide expenses' do
    let(:write_down_expenses_job) do
      OpenStruct.new(
        perform_later: true
      )
    end

    it 'calls WriteDownHalfExpensesJob' do
      expect(WriteDownHalfExpensesJob).to receive(:set).with(wait: 2.seconds).and_return(write_down_expenses_job)
      expect(write_down_expenses_job).to receive(:perform_later).with(2079267030, 5389, "=75000 * 0,0024204 / 37,4406", "1", 'm')

      subject
    end
  end
end
