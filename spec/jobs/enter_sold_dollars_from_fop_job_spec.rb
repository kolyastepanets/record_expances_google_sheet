require 'rails_helper'

RSpec.describe EnterSoldDollarsFromFopJob do
  subject { described_class.perform_later(params) }

  let(:params) do
    {
      grivnas: 123,
      dollars: 456,
    }
  end
  let(:calculate_total_spent_usd_and_uah) do
    {
      :total_left_uah_money=>16280.0,
      :coordinates_of_total_left_uah_money=>"BQ82",
      :total_left_usd_money=>3676.0,
      :coordinates_of_total_left_usd_money=>"BQ81"
    }
  end

  before do
    allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return(calculate_total_spent_usd_and_uah)
    allow(ReceiveUsdFopFromGoogleSheet).to receive(:call).and_return(1234)
  end

  it 'calls UpdateCellInGoogleSheet, SendNotificationMessageToBot' do
    expect(UpdateCellInGoogleSheet).to receive(:call).with(16403.0, "BQ82")
    expect(UpdateCellInGoogleSheet).to receive(:call).with(3220.0, "BQ81")
    expect(SendNotificationMessageToBot).to receive(:call).with(params)

    perform_enqueued_jobs { subject }
  end
end
