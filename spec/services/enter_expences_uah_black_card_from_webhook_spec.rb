require 'rails_helper'

RSpec.describe EnterExpencesUahBlackCardFromWebhook do
  subject{ described_class.call(transaction_data) }

  before do
    allow(SendTextMessagesBeforeEnterPrices).to receive(:call).and_return(12345)
  end

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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'youtube',
        price_in_uah: 149.0,
        operation_amount: 149.0,
        current_month: Date.today.month,
        mono_description: "YouTube",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Liliia salary', freezed_time: '2022-08-01' do
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
        can_show_final_sum: true,
        category_name: 'Лиля',
        sub_category_name: nil,
        price_in_uah: 18000.0,
        operation_amount: 18000.0,
        current_month: Date.today.month,
        mono_description: "Лиля ❤️",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Mark salary', freezed_time: '2022-08-01' do
    let(:transaction_data) do
      {
        amount: -250000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лиля ❤️",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -250000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Марк',
        sub_category_name: nil,
        price_in_uah: 2500.0,
        operation_amount: 2500.0,
        current_month: Date.today.month,
        mono_description: "Лиля ❤️",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Mark salary 2', freezed_time: '2022-08-01' do
    let(:transaction_data) do
      {
        amount: -250000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лілія С.",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -250000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Марк',
        sub_category_name: nil,
        price_in_uah: 2500.0,
        operation_amount: 2500.0,
        current_month: Date.today.month,
        mono_description: "Лілія С.",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Mark salary 3', freezed_time: '2022-08-01' do
    let(:transaction_data) do
      {
        amount: -250000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лілія С",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -250000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Марк',
        sub_category_name: nil,
        price_in_uah: 2500.0,
        operation_amount: 2500.0,
        current_month: Date.today.month,
        mono_description: "Лілія С",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when subscription to fairy tales', freezed_time: '2022-08-13' do
    let(:transaction_data) do
      {
        amount: -4500,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Apple",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -299,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Марк',
        sub_category_name: 'Книги',
        price_in_uah: 45.0,
        operation_amount: 2.99,
        current_month: 8,
        mono_description: "Apple",
        currency_rate: 15.050167,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Liliia another day', freezed_time: '2022-08-02' do
    let(:transaction_data) do
      {
        amount: -10000,
        balance: 2876000,
        can_show_final_sum: true,
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
        currency_rate: 10.0,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'google',
        price_in_uah: 45.0,
        operation_amount: 45.0,
        current_month: Date.today.month,
        mono_description: "Google",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when google through Apple', freezed_time: '2022-08-03' do
    let(:transaction_data) do
      {
        amount: -4500,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Apple",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -199,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'google',
        price_in_uah: 45.0,
        operation_amount: 1.99,
        current_month: 8,
        mono_description: "Apple",
        currency_rate: 22.613065,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama 1st date of month', freezed_time: '2022-08-01' do
    let(:transaction_data) do
      {
        amount: -500000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "516875******6402",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -500000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Подарки',
        sub_category_name: 'мама Коли',
        price_in_uah: 5000.0,
        operation_amount: 5000.0,
        current_month: Date.today.month,
        mono_description: "516875******6402",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama other day', freezed_time: '2022-08-02' do
    let(:transaction_data) do
      {
        amount: -200000,
        balance: 2876000,
        can_show_final_sum: true,
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
        currency_rate: 200.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'does not call job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

  context 'when liliia papa 1st date of month', freezed_time: '2023-01-01' do
    let(:transaction_data) do
      {
        amount: -500000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "414949******0254",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -500000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Подарки',
        sub_category_name: 'Папа Лили',
        price_in_uah: 5000.0,
        operation_amount: 5000.0,
        current_month: Date.today.month,
        mono_description: "414949******0254",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama other day', freezed_time: '2023-01-02' do
    let(:transaction_data) do
      {
        amount: -200000,
        balance: 2876000,
        can_show_final_sum: true,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "414949******0254",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
        currency_rate: 200.0,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'кладовка',
        price_in_uah: 450.0,
        operation_amount: 450.0,
        current_month: Date.today.month,
        mono_description: "536354******0388",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'кладовка',
        price_in_uah: 750.0,
        operation_amount: 750.0,
        current_month: Date.today.month,
        mono_description: "431414******3237",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'Сервак, впн',
        price_in_uah: 45.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "DigitalOcean",
        currency_rate: 4.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when uk' do
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Автобус',
          price_in_uah: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "STGCOACH/CTYLINK",
          currency_rate: 0.4,
          total_sum_of_money_before_save: 12345,
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Автобус',
          price_in_uah: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "THE COACH YARD",
          currency_rate: 0.4,
          total_sum_of_money_before_save: 12345,
        }
      end

      it 'calls job PutExpencesUahBlackCardJob' do
        expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

        subject
      end
    end

    context 'when WASABI, SUSHI & BENTO' do
      let(:transaction_data) do
        {
          amount: -400,
          balance: 2876000,
          cashbackAmount: 0,
          commissionRate: 0,
          currencyCode: 980,
          description: "WASABI, SUSHI & BENTO",
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
          can_show_final_sum: true,
          category_name: 'Еда',
          sub_category_name: 'Готовая',
          price_in_uah: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "WASABI, SUSHI & BENTO",
          currency_rate: 0.4,
          total_sum_of_money_before_save: 12345,
        }
      end

      it 'calls job PutExpencesUahBlackCardJob' do
        expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

        subject
      end
    end

    context 'when thetrainline.com' do
      let(:transaction_data) do
        {
          amount: -400,
          balance: 2876000,
          cashbackAmount: 0,
          commissionRate: 0,
          currencyCode: 980,
          description: "thetrainline.com",
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Поезд',
          price_in_uah: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "thetrainline.com",
          currency_rate: 0.4,
          total_sum_of_money_before_save: 12345,
        }
      end

      it 'calls job PutExpencesUahBlackCardJob' do
        expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

        subject
      end
    end

    context 'when trainline' do
      let(:transaction_data) do
        {
          amount: -400,
          balance: 2876000,
          cashbackAmount: 0,
          commissionRate: 0,
          currencyCode: 980,
          description: "trainline",
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Поезд',
          price_in_uah: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "trainline",
          currency_rate: 0.4,
          total_sum_of_money_before_save: 12345,
        }
      end

      it 'calls job PutExpencesUahBlackCardJob' do
        expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

        subject
      end
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
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "McDonald’s",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when mcdonalds different description' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "McDonalds",
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
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "McDonalds",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when mcdonalds indonesia' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "KIOSK MCD",
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
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "KIOSK MCD",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when cafe indonesia' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "THE LEAVES CAFE EATERY",
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
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "THE LEAVES CAFE EATERY",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when mykola top up phone number' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Vodafone\n#{ENV['MYKOLA_PHONE_NUMBER']}",
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
        can_show_final_sum: true,
        category_name: 'Коля',
        sub_category_name: 'Мобильный',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "Vodafone\n#{ENV['MYKOLA_PHONE_NUMBER']}",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when liliia top up phone number' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Vodafone\n#{ENV['LILIIA_PHONE_NUMBER']}",
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
        can_show_final_sum: true,
        category_name: 'Лиля',
        sub_category_name: 'Мобильный',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "Vodafone\n#{ENV['LILIIA_PHONE_NUMBER']}",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Wizz Air' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Wizz Air",
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
        can_show_final_sum: true,
        category_name: 'Путешествия',
        sub_category_name: 'Авиа билеты',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "Wizz Air",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when AIRBNB' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "AIRBNB",
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
        can_show_final_sum: true,
        category_name: 'Путешествия',
        sub_category_name: 'аренда кв',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "AIRBNB",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
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
        currency_rate: 75.0,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'does not call job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

  context 'when do not round to bigger number currency rate' do
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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'Сервак, впн',
        price_in_uah: 351.0,
        operation_amount: 7.99,
        current_month: Date.today.month,
        mono_description: "DigitalOcean",
        currency_rate: 43.929912,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when withdraw from atm' do
    let(:transaction_data) do
      {
        time: 1667098010,
        description: "Банкомат BANK NEGARA IND",
        mcc: 6011,
        originalMcc: 6011,
        amount: -245786,
        operationAmount: -100000000,
        currencyCode: 360,
        commissionRate: 4819,
        cashbackAmount: 0,
        balance: 123,
        hold: true,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Кэш',
        sub_category_name: nil,
        price_in_uah: 2457.86,
        operation_amount: 1000000.0,
        current_month: Date.today.month,
        mono_description: "Банкомат BANK NEGARA IND",
        currency_rate: 0.002457,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when bali visa' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "BAYU SANTERO 1 MBL",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "123-123-123-123",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Путешествия',
        sub_category_name: 'Виза',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "BAYU SANTERO 1 MBL",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when bali coffee 1' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "BBS - NESPRESSO BEACHW",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "123-123-123-123",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Кофе, Чай',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "BBS - NESPRESSO BEACHW",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when bali coffee 2' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "BBS - NESPRESSO BEACHWALK",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -1000,
        originalMcc: 4829,
        receiptId: "123-123-123-123",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Кофе, Чай',
        price_in_uah: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "BBS - NESPRESSO BEACHWALK",
        currency_rate: 0.4,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesUahBlackCardJob' do
      expect(PutExpencesUahBlackCardJob).to receive(:perform_later).with(params)

      subject
    end
  end
end
