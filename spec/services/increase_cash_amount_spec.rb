require 'rails_helper'

RSpec.describe IncreaseCashAmount do
  subject { described_class.call(data) }

  let(:data) do
    {
      price_in_uah: 2448.32,
      category_name: "Кэш",
      sub_category_name: nil,
      operation_amount: 1000000.0,
      current_month: 12,
      mono_description: "Банкомат BANK NEGARA IND",
      currency_rate: 0.0024,
    }
  end
  let(:foreign_cash_expenses) do
    {
      withdraw_foreign_money: "=4000000+1000000",
      coordinates_of_value_to_change_withdraw_foreign_money: "CB64",
      currency_rate_uah_to_foreigh_currency: "=(0,00251325+0,0024)/2",
      coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency: "CB65",
      spent_foreign_money: 4850000.0,
      coordinates_of_value_to_change_spent_foreign_money: "CB74",
      now_foreign_money: 2236000.0,
      coordinates_of_value_to_change_now_foreign_money: "CB75",
      total_withraw_foreign_money: 7086000.0,
      total_withraw_foreign_money_formula: "=786000+4000000+300000+1000000+1000000",
      coordinates_of_total_withraw_foreign_money_formula: "CB76",
    }
  end

  before do
    allow(CalculateForeignCurrencyCashExpenses).to receive(:call).and_return(foreign_cash_expenses)
  end

  context 'when cash category' do
    it 'calls UpdateCellInGoogleSheet' do
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=4000000+1000000+1000000,0", "CB64")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=(0,00251325+0,0024+0,0024)/3", "CB65")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(3236000, "CB75")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=786000+4000000+300000+1000000+1000000+1000000,0", "CB76")

      subject
    end
  end

  context 'when 1 currency rate from previous month' do
    let(:foreign_cash_expenses) do
      {
        withdraw_foreign_money: "=0",
        coordinates_of_value_to_change_withdraw_foreign_money: "CE64",
        currency_rate_uah_to_foreigh_currency: "=(BX65)/1",
        coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency: "CE65",
        spent_foreign_money: 0.0,
        coordinates_of_value_to_change_spent_foreign_money: "CE74",
        now_foreign_money: 0.0,
        coordinates_of_value_to_change_now_foreign_money: "CE75",
        total_withraw_foreign_money: 0.0,
        total_withraw_foreign_money_formula: "=BX75",
        coordinates_of_total_withraw_foreign_money_formula: "CE76"
      }
    end

    it 'calls UpdateCellInGoogleSheet' do
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=0+1000000,0", "CE64")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=(BX65+0,0024)/2", "CE65")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000000, "CE75")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=BX75+1000000,0", "CE76")

      subject
    end
  end

  context 'when 1 currency rate from previous year' do
    let(:foreign_cash_expenses) do
      {
        withdraw_foreign_money: "=0",
        coordinates_of_value_to_change_withdraw_foreign_money: "CE64",
        currency_rate_uah_to_foreigh_currency: "=('2022'!CB75)/1",
        coordinates_of_value_to_change_currency_rate_uah_to_foreigh_currency: "CE65",
        spent_foreign_money: 0.0,
        coordinates_of_value_to_change_spent_foreign_money: "CE74",
        now_foreign_money: 0.0,
        coordinates_of_value_to_change_now_foreign_money: "CE75",
        total_withraw_foreign_money: 0.0,
        total_withraw_foreign_money_formula: "=BX75",
        coordinates_of_total_withraw_foreign_money_formula: "CE76"
      }
    end

    it 'calls UpdateCellInGoogleSheet' do
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=0+1000000,0", "CE64")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=('2022'!CB75+0,0024)/2", "CE65")
      expect(UpdateCellInGoogleSheet).to receive(:call).with(1000000, "CE75")
      expect(UpdateCellInGoogleSheet).to receive(:call).with("=BX75+1000000,0", "CE76")

      subject
    end
  end

  context 'when not cash category' do
    let(:data) do
      {
        price_in_uah: 2448.32,
        category_name: "DigitalOcean",
        sub_category_name: nil,
        operation_amount: 1000000.0,
        current_month: 12,
        mono_description: "Банкомат BANK NEGARA IND",
        currency_rate: 0.0024,
      }
    end

    it 'does nothing' do
      expect(subject).to be_nil
    end
  end
end
