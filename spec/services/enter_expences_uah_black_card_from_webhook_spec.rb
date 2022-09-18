require 'rails_helper'

RSpec.describe EnterExpencesUahBlackCardFromWebhook do
  subject{ described_class.call(transaction_data) }

  context 'when youtube' do
    let(:transaction_data) do
      {
        amount: -14900,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "YouTube",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -14900,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'youtube',
        price_in_uah: 149.0,
        operation_amount: 149.0,
        current_month: Date.today.month,
        mono_description: "YouTube",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Liliia salary' do
    let(:transaction_data) do
      {
        amount: -1800000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лиля ❤️",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1800000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Лиля',
        sub_category_name: nil,
        price_in_uah: 18000.0,
        operation_amount: 18000.0,
        current_month: Date.today.month,
        mono_description: "Лиля ❤️",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Liliia another amount' do
    let(:transaction_data) do
      {
        amount: -10000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лиля ❤️",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end

    it 'does not call job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

  context 'when google' do
    let(:transaction_data) do
      {
        amount: -4500,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Google",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -4500,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'google',
        price_in_uah: 45.0,
        operation_amount: 45.0,
        current_month: Date.today.month,
        mono_description: "Google",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama 1st date of month' do
    let(:transaction_data) do
      {
        amount: -300000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "516875******6402",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -300000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Подарки',
        sub_category_name: 'мама Коли',
        price_in_uah: 3000.0,
        operation_amount: 3000.0,
        current_month: Date.today.month,
        mono_description: "516875******6402",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama other sum' do
    let(:transaction_data) do
      {
        amount: -200000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "516875******6402",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end

    it 'does not call job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

  context 'when kladovka_1' do
    let(:transaction_data) do
      {
        amount: -45000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "536354******0388",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -45000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'кладовка',
        price_in_uah: 450.0,
        operation_amount: 450.0,
        current_month: Date.today.month,
        mono_description: "536354******0388",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kladovka_2' do
    let(:transaction_data) do
      {
        amount: -75000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "431414******3237",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -75000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'кладовка',
        price_in_uah: 750.0,
        operation_amount: 750.0,
        current_month: Date.today.month,
        mono_description: "431414******3237",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when description does not fit anything' do
    let(:transaction_data) do
      {
        amount: -75000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "bla",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end

    it 'does not call job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

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
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "STGCOACH/CTYLINK",
        currency_rate: 0.4,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

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
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "THE COACH YARD",
        currency_rate: 0.4,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when digital ocean' do
    let(:transaction_data) do
      {
        amount: -4500,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "DigitalOcean",
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
        category_name: 'Для дома',
        sub_category_name: 'Сервак, впн',
        price_in_uah: 45.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "DigitalOcean",
        currency_rate: 4.5,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when do not round' do
    let(:transaction_data) do
      {
        amount: -35100,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "DigitalOcean",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -799,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'Сервак, впн',
        price_in_uah: 351.0,
        operation_amount: 7.99,
        current_month: Date.today.month,
        mono_description: "DigitalOcean",
        currency_rate: 43.9299,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end
end
