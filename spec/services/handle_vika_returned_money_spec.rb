require 'rails_helper'

RSpec.describe HandleVikaReturnedMoney do
  subject{ described_class.call(price, type_returned) }

  let(:price) { 100.0 }
  let(:type_returned) { 'uah' }
  let(:find_cell_to_enter_vika_half_expenses_result) do
    {
      :vika_total_sum_mono=>2474.0,
      :vika_total_sum_mono_coordinates=>"BQ105",
      :vika_total_sum_mono_cells=>"6424-6425-6427-6428-6430-6431",
      :vika_total_sum_mono_cells_coordinates=>"BQ106",
      :vika_total_sum_cash=>0.0,
      :vika_total_sum_cash_coordinates=>"BQ107",
      :vika_total_sum_cash_cells=>"",
      :vika_total_sum_cash_cells_coordinates=>"BQ108"
    }
  end
  let(:divide_price_and_make_cell_green_job) do
    OpenStruct.new(
      perform_later: true
    )
  end

  before do
    allow(FindCellToEnterVikaHalfExpenses).to receive(:call).and_return(find_cell_to_enter_vika_half_expenses_result)
  end

  it 'calls classes' do
    expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 5.seconds).and_return(divide_price_and_make_cell_green_job)
    expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6424")

    expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 5.seconds).and_return(divide_price_and_make_cell_green_job)
    expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6425")

    expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 5.seconds).and_return(divide_price_and_make_cell_green_job)
    expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6427")

    expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 5.seconds).and_return(divide_price_and_make_cell_green_job)
    expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6428")

    expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 5.seconds).and_return(divide_price_and_make_cell_green_job)
    expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6430")

    expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 5.seconds).and_return(divide_price_and_make_cell_green_job)
    expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6431")

    expect(UpdateCellInGoogleSheet).to receive(:call).with("= 2474 - 100", "BQ105")
    expect(UpdateCellInGoogleSheet).to receive(:call).with("", "BQ106")

    subject
  end
end
