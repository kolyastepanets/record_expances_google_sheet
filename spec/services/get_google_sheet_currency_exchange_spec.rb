require 'rails_helper'

RSpec.describe GetGoogleSheetCurrencyExchange, vcr: true, freezed_time: '2022-08-23T14:08:00+00:00' do
  subject{ described_class.call }

  it 'returns foreigh currency to uah' do
    expect(subject).to eq("36,92000")
  end
end
