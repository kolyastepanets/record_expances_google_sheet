require 'rails_helper'

RSpec.describe PutExpensesToGoogleSheetJob do
  subject { described_class.perform_later(category_name, sub_category_name, price_to_put_in_sheets, detect_month) }

  let(:category_name) { 'Еда' }
  let(:sub_category_name) { 'Фрукты' }
  let(:price_to_put_in_sheets) { '=156300 * 0,0024204 / 37,4406' }
  let(:detect_month) { "11" }
  let(:response_after_save_expenses) do
    OpenStruct.new(
      table_range: "A5389"
    )
  end

  before do
    allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
  end

  it 'calls PutExpensesToGoogleSheet' do
    expect(PutExpensesToGoogleSheet).to receive(:call).with('Еда', 'Фрукты', '=156300 * 0,0024204 / 37,4406', current_month: '11').and_return(response_after_save_expenses)

    perform_enqueued_jobs { subject }
  end
end
