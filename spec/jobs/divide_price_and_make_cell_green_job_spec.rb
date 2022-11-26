require 'rails_helper'

RSpec.describe DividePriceAndMakeCellGreenJob do
  subject { described_class.perform_later(coordinates_of_value) }

  let(:coordinates_of_value) { "6424" }

  it 'calls FindCellValueInEveryDayExpensesPage, UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
    expect(FindCellValueInEveryDayExpensesPage).to receive(:call).with(6425).and_return("=156300 * 0,0024204 / 37,4406")
    expect(UpdateCellInGoogleSheet).to receive(:call).with("=156300 * 0,0024204 / 37,4406 / 2", "C6425", page: 'Повседневные')
    expect(UpdateCellBackgroundColorRequest).to receive(:call).with(2079267030, 6424, 6425, "green")

    perform_enqueued_jobs { subject }
  end

  context 'when could not find value' do
    before do
      allow(FindCellValueInEveryDayExpensesPage).to receive(:call).with(6425).and_return(nil)
    end

    it 'sends message to bot' do
      expect(SendNotificationMessageToBot).to receive(:call).with("не смог найти цену, cell: 6425")

      perform_enqueued_jobs { subject }
    end

    it 'does not call UpdateCellInGoogleSheet and UpdateCellBackgroundColorRequest' do
      expect(UpdateCellInGoogleSheet).to_not receive(:call)
      expect(UpdateCellBackgroundColorRequest).to_not receive(:call)

      perform_enqueued_jobs { subject }
    end
  end
end
