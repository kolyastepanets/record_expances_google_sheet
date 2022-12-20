require 'rails_helper'

RSpec.describe CalculateForeignCurrencyCashExpenses, vcr: true, freezed_time: '2022-12-20T14:55:00+00:00' do
  subject{ described_class.call }

  it 'returns info about cash' do
    expect(subject).to eq(
      {
        :withdraw_foreign_money=>"=4000000",
        :coordinates_of_value_to_change_withdraw_foreign_money=>"CB64",
        :currency_rate_uah_to_foreigh_currency=>"=(0,00251325)/1",
        :coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency=>"CB65",
        :spent_foreign_money=>4850000.0,
        :coordinates_of_value_to_change_spent_foreign_money=>"CB74",
        :now_foreign_money=>1236000.0,
        :coordinates_of_value_to_change_now_foreign_money=>"CB75",
        :total_withraw_foreign_money=>6086000.0,
        :total_withraw_foreign_money_formula=>"=786000+4000000+300000+1000000",
        :coordinates_of_total_withraw_foreign_money_formula=>"CB76"
      }
     )
  end
end
