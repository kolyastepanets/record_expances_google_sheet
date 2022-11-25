require 'rails_helper'

RSpec.describe FindCellToEnterVikaHalfExpenses, vcr: true, freezed_time: '2022-11-25T06:05:00+00:00' do
  subject{ described_class.call }

  it 'returns coordinates' do
    expect(subject).to eq(
      {
        :vika_total_sum_mono=>4642.0,
        :vika_total_sum_mono_coordinates=>"BQ105",
        :vika_total_sum_mono_cells=>"6334-6335-6336-6337-6338-6339-6340-6341-6342-6343-6344-6345-6346-6347-6351-6352-6353-6354-6355-6356-6357-6358-6359-6360-6361-6362-6363-6364-6365-6366-6367-6368-6369-6370-6371-6372-6373-6374-6375-6376-6377-6378-6379-6380-6381-6382-6383-6384-6385-6390-6391-6392-6393-6394-6395-6396-6397-6398-6399-6400-6401-6402-6403-6404-6405-6406-6407-6408-6409-6410-6411-6412-6413-6414-6415",
        :vika_total_sum_mono_cells_coordinates=>"BQ106",
        :vika_total_sum_cash=>0.0,
        :vika_total_sum_cash_coordinates=>"BQ107",
        :vika_total_sum_cash_cells=>"",
        :vika_total_sum_cash_cells_coordinates=>"BQ108",
        :mykola_total_sum_mono=>2433.0,
        :mykola_total_sum_mono_coordinates=>"BQ109",
        :mykola_total_sum_mono_cells=>"6424-6425-6426-6427-6428-6429-6430-6431-6432-6433-6434-6435-6436-6437-6441-6442-6443-6444-6445-6446-6447-6448-6449-6450-6451-6452-6453-6454-6455-6456-6457-6458-6459-6460-6461-6462-6463-6464-6465",
        :mykola_total_sum_mono_cells_coordinates=>"BQ110"
      }
    )
  end
end
