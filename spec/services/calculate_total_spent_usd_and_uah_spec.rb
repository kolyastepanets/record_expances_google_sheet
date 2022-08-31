require 'rails_helper'

RSpec.describe CalculateTotalSpentUsdAndUah, vcr: true, freezed_time: '2022-08-31T21:43:00+00:00' do
  subject{ described_class.call }

  # should rewrite vcr on 1st september
  xit 'returns info about spent usd' do
    expect(subject).to eq({
      total_left_uah_money: 31880.0,
      coordinates_of_total_left_uah_money: "BC82",
      total_left_usd_money: 3100.0,
      coordinates_of_total_left_usd_money: "BC81"
    })
  end
end
