require 'rails_helper'

RSpec.describe CalculateForeignCurrencyCashExpenses, vcr: true, freezed_time: '2022-08-22T21:28:00+00:00' do
  subject{ described_class.call }

  it 'returns info about cash' do
    expect(subject).to eq({
      total_withraw_foreign_money: 76.0,
      spent_foreign_money: 0.0,
      now_foreign_money: 76.0,
      coordinates_of_value_to_change_spent_foreign_money: "AZ74",
      coordinates_of_value_to_change_now_foreign_money: "AZ75"
    })
  end
end
