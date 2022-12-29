require 'rails_helper'

RSpec.describe FindCellToEnterVikaHalfExpenses, vcr: true, freezed_time: '2022-11-25T06:05:00+00:00' do
  subject{ described_class.call }

  it 'returns coordinates' do
    expect(subject).to eq(
      {:mykola_total_spent_uah=>0.0, :mykola_total_spent_usd=>"", :vika_total_spent_uah=>0.0, :vika_total_spent_usd=>""}
    )
  end
end
