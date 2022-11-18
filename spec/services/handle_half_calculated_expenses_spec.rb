require 'rails_helper'

RSpec.describe HandleHalfCalculatedExpenses do
  subject { described_class.call(response_after_save_expenses, should_divide_expenses, price_to_enter, month: month, index: index) }

  let(:response_after_save_expenses) do
    OpenStruct.new(
      table_range: "A5389"
    )
  end
  let(:should_divide_expenses) { true }
  let(:price_to_enter) { "=75000 * 0,0024204 / 37,4406" }
  let(:month) { 1 }
  let(:index) { 2 }

  context 'when should not divide expenses' do
    let(:should_divide_expenses) { false }

    it 'does not call HandleHalfCalculatedExpensesJob' do
      expect(HandleHalfCalculatedExpensesJob).to_not receive(:perform_later)

      subject
    end
  end

  context 'when should divide expenses' do
    let(:handle_half_calculated_expenses_job) do
      OpenStruct.new(
        perform_later: true
      )
    end

    it 'calls HandleHalfCalculatedExpensesJob' do
      expect(HandleHalfCalculatedExpensesJob).to receive(:set).with(wait: 2.seconds).and_return(handle_half_calculated_expenses_job)
      expect(handle_half_calculated_expenses_job).to receive(:perform_later).with(2079267030, 5389, "=75000 * 0,0024204 / 37,4406", "1")

      subject
    end
  end
end
