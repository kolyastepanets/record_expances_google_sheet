require 'rails_helper'

RSpec.describe CalculateTotalSpentUsdAndUah, vcr: true, freezed_time: '2022-08-22T21:31:00+00:00' do
  subject{ described_class.call }

  it 'returns info about spent usd' do
    expect(subject).to eq({
      total_spent_uah_money: 115846.0,
      coordinates_of_total_spent_uah_money: "AU82",
      total_left_usd_money: 3683.0,
      coordinates_of_total_left_usd_money: "AU102"
    })
  end
end
