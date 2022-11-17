require 'rails_helper'

RSpec.describe ApiGoogleSheet::GetGoogleSheetCurrencyExchange, vcr: true, freezed_time: '2022-09-01T07:05:00+00:00' do
  subject{ described_class.call }

  it 'returns foreigh currency to uah' do
    expect(subject).to eq("36,92000")
  end
end
