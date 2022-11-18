require 'rails_helper'

RSpec.describe FindCellToEnterVikaHalfExpenses, vcr: true, freezed_time: '2022-11-19T13:33:00+00:00' do
  subject{ described_class.call }

  it 'returns coordinates' do
    expect(subject).to eq(
      {
        :vika_total_sum_mono => 24690.0,
        :vika_total_sum_mono_coordinates => "BQ105",

        :vika_total_sum_mono_cells => "6350-6351",
        :vika_total_sum_mono_cells_coordinates => "BQ106",

        :vika_total_sum_cash => 100000.0,
        :vika_total_sum_cash_coordinates => "BQ107",

        :vika_total_sum_cash_cells => "6352",
        :vika_total_sum_cash_cells_coordinates => "BQ108",
      }
    )
  end
end
