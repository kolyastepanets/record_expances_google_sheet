require 'rails_helper'

RSpec.describe EnterSalaryFromSwift do
  subject{ described_class.call(params) }

  context 'when got salary on 10th of month', freezed_time: '2022-11-10' do
    let(:params) do
      { dollars: 1000 }
    end

    it 'enters salary' do
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      expect(FindCellToEnterSalaryOrNbuCurrencyRate).to receive(:call).with(12, 2022, "Заплата 1ая половина $")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000, nil, page: 2022)

      subject
    end

    it 'enters nbu rate' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      allow(NbuUsdRate).to receive(:call).and_return(36.56)
      allow_any_instance_of(described_class).to receive(:coordinates_of_cell_to_enter_nbu_rate).and_return('BX80')
      expect(UpdateCellInGoogleSheet).to receive(:call).with(36.56, 'BX80', page: 2022)

      subject
    end

    it 'enters left usd fop mono' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:coordinates_to_enter_left_usd_and_usd).and_return({
        total_left_usd_money: 10,
        coordinates_of_total_left_usd_money: 'BX80',
      })
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1010, 'BX80', page: 2022)

      subject
    end

    it 'enters salary to income page' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)

      subject
    end
  end

  context 'when got salary on 20th of month', freezed_time: '2022-11-20' do
    let(:params) do
      { dollars: 1000 }
    end

    it 'enters salary' do
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      expect(FindCellToEnterSalaryOrNbuCurrencyRate).to receive(:call).with(12, 2022, "Заплата 1ая половина $")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000, nil, page: 2022)

      subject
    end

    it 'enters nbu rate' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      allow(NbuUsdRate).to receive(:call).and_return(36.56)
      allow_any_instance_of(described_class).to receive(:coordinates_of_cell_to_enter_nbu_rate).and_return('BX80')
      expect(UpdateCellInGoogleSheet).to receive(:call).with(36.56, "BX80", page: 2022)

      subject
    end

    it 'enters left usd fop mono' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:coordinates_to_enter_left_usd_and_usd).and_return({
        total_left_usd_money: 10,
        coordinates_of_total_left_usd_money: 'BX80',
      })
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1010, 'BX80', page: 2022)

      subject
    end

    it 'enters salary to income page' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)

      subject
    end
  end

  context 'when got salary on 21st of month', freezed_time: '2022-11-21' do
    let(:params) do
      { dollars: 1000 }
    end

    it 'enters salary' do
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      expect(FindCellToEnterSalaryOrNbuCurrencyRate).to receive(:call).with(12, 2022, "Заплата 2ая половина $")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000, nil, page: 2022)

      subject
    end

    it 'enters salary to income page' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)

      subject
    end
  end

  context 'when got salary on 31st of month', freezed_time: '2022-10-31' do
    let(:params) do
      { dollars: 1000 }
    end

    it 'enters salary' do
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      expect(FindCellToEnterSalaryOrNbuCurrencyRate).to receive(:call).with(11, 2022, "Заплата 2ая половина $")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000, nil, page: 2022)

      subject
    end

    it 'enters salary to income page' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)

      subject
    end
  end

  context 'when got salary on 10th of december', freezed_time: '2022-12-10' do
    let(:params) do
      { dollars: 1000 }
    end

    it 'enters salary' do
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      expect(FindCellToEnterSalaryOrNbuCurrencyRate).to receive(:call).with(1, 2023, "Заплата 1ая половина $")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000, nil, page: 2023)

      subject
    end

    it 'enters salary to income page' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)

      subject
    end
  end

  context 'when got salary on 9th of december', freezed_time: '2022-12-09' do
    let(:params) do
      { dollars: 1000 }
    end

    it 'enters salary' do
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)
      expect(FindCellToEnterSalaryOrNbuCurrencyRate).to receive(:call).with(12, 2022, "Заплата 2ая половина $")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000, nil, page: 2022)

      subject
    end

    it 'enters salary to income page' do
      allow_any_instance_of(described_class).to receive(:enter_salary)
      allow_any_instance_of(described_class).to receive(:enter_nbu_rate)
      allow_any_instance_of(described_class).to receive(:enter_left_usd_fop)

      subject
    end
  end
end
