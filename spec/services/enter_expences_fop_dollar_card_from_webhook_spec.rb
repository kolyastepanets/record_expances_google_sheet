require 'rails_helper'

RSpec.describe EnterExpencesFopDollarCardFromWebhook do
  subject{ described_class.call(transaction_data) }

  context 'when cambridge bus 18' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "STGCOACH/CTYLINK",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Транспорт',
        sub_category_name: 'Автобус',
        price_in_usd: 4.0,
        current_month: Date.today.month,
        mono_description: "STGCOACH/CTYLINK",
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when cambridge bus 75' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "THE COACH YARD",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Транспорт',
        sub_category_name: 'Автобус',
        price_in_usd: 4.0,
        current_month: Date.today.month,
        mono_description: "THE COACH YARD",
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when mcdonalds' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "McDonald’s",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_usd: 4.0,
        current_month: Date.today.month,
        mono_description: "McDonald’s",
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when sold dollars from fop' do
    let(:transaction_data) do
      {
        amount: -10000,
        balance: 1533784,
        cashbackAmount: 0,
        commissionRate: 0,
        counterEdrpou: "3299616355",
        counterIban: "UA093220010000026002300065191",
        currencyCode: 980,
        description: "На гривневый счет ФОП для перевода на карту",
        hold: true,
        id: "q6BoObsWc4t4vdq9",
        mcc: 4829,
        operationAmount: -366500,
        originalMcc: 4829,
        time: 1661710603
      }
    end
    let(:params) do
      {
        grivnas: 3665,
        dollars: 100,
        sold_dollars_from_fop: true,
      }
    end

    it 'calls job EnterSoldDollarsFromFopJob' do
      expect(EnterSoldDollarsFromFopJob).to receive(:perform_later).with(params)

      subject
    end

    it 'does not call PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to_not receive(:perform_later)

      subject
    end
  end
end