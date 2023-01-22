require 'rails_helper'

RSpec.describe DividePriceAndMakeCellGreenJob do
  subject { described_class.perform_later(coordinates_of_value) }

  let(:coordinates_of_value) { "6424" }

  it 'calls FindCellValueInEveryDayExpensesPage, UpdateCellInGoogleSheet, UpdateCellBackgroundColorRequest' do
    expect(UpdateCellBackgroundColorRequest).to receive(:call).with(ENV['EVERY_DAY_EXPENSES_PAGE'], 6424, 6425, "green")

    perform_enqueued_jobs { subject }
  end
end
