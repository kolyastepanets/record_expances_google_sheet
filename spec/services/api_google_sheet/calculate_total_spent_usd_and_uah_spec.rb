require 'rails_helper'

RSpec.describe ApiGoogleSheet::CalculateTotalSpentUsdAndUah, vcr: true, freezed_time: '2022-09-01T07:01:00+00:00' do
  subject{ described_class.call }

  it 'returns info about spent usd' do
    expect(subject).to eq({
      total_left_uah_money: 10430.0,
      coordinates_of_total_left_uah_money: "BC82",
      total_left_usd_money: 3100.0,
      coordinates_of_total_left_usd_money: "BC81"
    })
  end
end
