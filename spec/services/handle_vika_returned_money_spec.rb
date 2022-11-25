require 'rails_helper'

RSpec.describe HandleVikaReturnedMoney do
  subject { described_class.call(data) }

  let(:data) { "vika:100:JEMXm-kC9iSZNfGJ" }
  let(:vika_total_sum_mono) { 2474.0 }
  let(:mykola_total_sum_mono) { 0 }
  let(:vika_total_sum_mono_cells) { "6424-6425-6427-6428-6430-6431" }
  let(:mykola_total_sum_mono_cells) { "6432-6433-6434-6435-6436" }
  let(:find_cell_to_enter_vika_half_expenses_result) do
    {
      :vika_total_sum_mono=>vika_total_sum_mono,
      :vika_total_sum_mono_coordinates=>"BQ105",
      :vika_total_sum_mono_cells=>vika_total_sum_mono_cells,
      :vika_total_sum_mono_cells_coordinates=>"BQ106",
      :vika_total_sum_cash=>0.0,
      :vika_total_sum_cash_coordinates=>"BQ107",
      :vika_total_sum_cash_cells=>"",
      :vika_total_sum_cash_cells_coordinates=>"BQ108",
      :mykola_total_sum_mono=>mykola_total_sum_mono,
      :mykola_total_sum_mono_coordinates=>"BQ109",
      :mykola_total_sum_mono_cells=>mykola_total_sum_mono_cells,
      :mykola_total_sum_mono_cells_coordinates=>"BQ110"
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
  let(:divide_price_and_make_cell_green_job) do
    OpenStruct.new(
      perform_later: true
    )
  end

  before do
    allow(FindCellToEnterVikaHalfExpenses).to receive(:call).and_return(find_cell_to_enter_vika_half_expenses_result)
    allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return(calculate_total_spent_usd_and_uah)
  end

  context 'validate!' do
    before do
      allow(DividePriceAndMakeCellGreenJob).to receive_message_chain(:set, :perform_later)
      allow(UpdateCellInGoogleSheet).to receive(:call)
    end

    context 'when *_total_sum_mono' do
      context 'when mykola and vika should return money to each other' do
        let(:mykola_total_sum_mono) { 2433.0 }

        it 'raises error' do
          expect { subject }.to raise_error(HandleVikaReturnedMoney::HandleVikaReturnedMoneyError, "Нельзя автоматически посчитать: Вика должна гривен: 2474.0, Микола должен гривен: 2433.0")
        end
      end

      context 'when vika should return money' do
        let(:mykola_total_sum_mono) { 0 }

        it 'does not raise error' do
          expect { subject }.to_not raise_error
        end
      end

      context 'when mykola should return money' do
        let(:vika_total_sum_mono) { 0 }
        let(:mykola_total_sum_mono) { 2433.0 }

        it 'does not raise error' do
          expect { subject }.to_not raise_error
        end
      end
    end

    context 'when *_total_sum_mono_cells' do
      context 'when mykola and vika cells present' do
        let(:mykola_total_sum_mono) { 2433.0 }

        it 'raises error' do
          expect { subject }.to raise_error(HandleVikaReturnedMoney::HandleVikaReturnedMoneyError, "Нельзя автоматически посчитать: Вика должна гривен: 2474.0, Микола должен гривен: 2433.0")
        end
      end

      context 'when vika_total_sum_mono_cells present, mykola blank' do
        let(:mykola_total_sum_mono_cells) { '' }

        it 'does not raise error' do
          expect { subject }.to_not raise_error
        end
      end

      context 'when mykola_total_sum_mono_cells present, vika blank' do
        let(:vika_total_sum_mono_cells) { '' }

        it 'does not raise error' do
          expect { subject }.to_not raise_error
        end
      end
    end
  end

  context 'delete_all_messages!' do
    let(:redis_response) do
      {
        message_ids: [123, 456, 789, 789]
      }.to_json
    end

    before do
      allow(DividePriceAndMakeCellGreenJob).to receive_message_chain(:set, :perform_later)
      allow(UpdateCellInGoogleSheet).to receive(:call)
      allow(Redis).to receive_message_chain(:new, :get).and_return(redis_response)
    end

    it 'deletes all messages from redis' do
      expect(DeleteMessagesJob).to receive(:perform_later).with([123, 456, 789])

      subject
    end
  end

  context 'divide_price_and_make_cell_green_job!' do
    before do
      allow(UpdateCellInGoogleSheet).to receive(:call)
    end

    context 'when vika cells present' do
      it 'calls DividePriceAndMakeCellGreenJob for vika' do
        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6424")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6425")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6427")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6428")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6430")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6431")

        subject
      end
    end

    context 'when vika cells blank' do
      let(:vika_total_sum_mono_cells) { '' }

      it 'calls DividePriceAndMakeCellGreenJob for mykola' do
        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6432")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6433")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6434")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6435")

        expect(DividePriceAndMakeCellGreenJob).to receive(:set).with(wait: 10.seconds).and_return(divide_price_and_make_cell_green_job)
        expect(divide_price_and_make_cell_green_job).to receive(:perform_later).with("6436")

        subject
      end
    end
  end

  context 'update_sum_when_vika_returned_money_to_mykola!' do
    before do
      allow(DividePriceAndMakeCellGreenJob).to receive_message_chain(:set, :perform_later)
    end

    context 'when vika cells present' do
      let(:mykola_total_sum_mono_cells) { '' }

      it 'calls UpdateCellInGoogleSheet for vika' do
        expect(UpdateCellInGoogleSheet).to receive(:call).with("= 2474 - 100", "BQ105")
        expect(UpdateCellInGoogleSheet).to receive(:call).with("", "BQ106")
        expect(UpdateCellInGoogleSheet).to receive(:call).with(16380.0, "BQ82")

        subject
      end
    end
  end

  context 'update_sum_when_mykola_returned_money_to_vika!' do
    before do
      allow(DividePriceAndMakeCellGreenJob).to receive_message_chain(:set, :perform_later)
    end

    context 'when vika cells blank' do
      let(:vika_total_sum_mono_cells) { '' }

      it 'calls UpdateCellInGoogleSheet for mykola' do
        expect(UpdateCellInGoogleSheet).to receive(:call).with("= 0 - 100", "BQ109")
        expect(UpdateCellInGoogleSheet).to receive(:call).with("", "BQ110")
        expect(UpdateCellInGoogleSheet).to receive(:call).with(16180.0, "BQ82")

        subject
      end
    end
  end
end
