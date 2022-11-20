require 'rails_helper'

RSpec.describe UpdateCellBackgroundColorInExpensesPageAsync do
  subject { described_class.call(response_after_save_expenses, should_divide_expenses, index: index) }

  let(:response_after_save_expenses) do
    OpenStruct.new(
      table_range: "A5389"
    )
  end
  let(:should_divide_expenses) { true }
  let(:index) { 2 }

  context 'when should not divide expenses' do
    let(:should_divide_expenses) { false }

    it 'does not call UpdateCellBackgroundColorJob' do
      expect(UpdateCellBackgroundColorJob).to_not receive(:perform_later)

      subject
    end
  end

  context 'when should divide expenses' do
    let(:update_cell_background_color_job) do
      OpenStruct.new(
        perform_later: true
      )
    end

    it 'calls UpdateCellBackgroundColorJob' do
      expect(UpdateCellBackgroundColorJob).to receive(:set).with(wait: 2.seconds).and_return(update_cell_background_color_job)
      expect(update_cell_background_color_job).to receive(:perform_later).with(2079267030, 5389)

      subject
    end

    context 'when index 11' do
      let(:index) { 11 }

      it 'calls UpdateCellBackgroundColorJob in 10 seconds' do
        expect(UpdateCellBackgroundColorJob).to receive(:set).with(wait: 10.seconds).and_return(update_cell_background_color_job)
        expect(update_cell_background_color_job).to receive(:perform_later).with(2079267030, 5389)

        subject
      end
    end
  end
end
