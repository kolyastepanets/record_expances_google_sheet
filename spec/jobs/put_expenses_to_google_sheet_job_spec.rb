require 'rails_helper'

RSpec.describe PutExpensesToGoogleSheetJob do
  subject { described_class.perform_later(category_name, sub_category_name, price_to_put_in_sheets, detect_month, calculate_as_half_expenses) }

  let(:category_name) { 'Еда' }
  let(:sub_category_name) { 'Фрукты' }
  let(:price_to_put_in_sheets) { '=156300 * 0,0024204 / 37,4406' }
  let(:detect_month) { "11" }
  let(:calculate_as_half_expenses) { "m" }

  it 'calls PutExpensesToGoogleSheet, WriteDownHalfExpenses' do
    expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=156300 * 0,0024204 / 37,4406', current_month: '11').and_return(nil)
    expect(WriteDownHalfExpenses).to receive(:call).with(nil, 'm', '=156300 * 0,0024204 / 37,4406', month: '11')

    perform_enqueued_jobs { subject }
  end
end
