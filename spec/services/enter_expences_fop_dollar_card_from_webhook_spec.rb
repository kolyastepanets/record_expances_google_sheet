require 'rails_helper'

RSpec.describe EnterExpencesFopDollarCardFromWebhook do
  subject{ described_class.call(transaction_data) }

  context 'when youtube' do
    let(:transaction_data) do
      {
        amount: -400,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "YouTube",
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
        sub_category_name: 'youtube',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "YouTube",
        currency_rate: 2.5,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Liliia salary', freezed_time: '2022-08-01' do
    let(:transaction_data) do
      {
        amount: -50000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лиля ❤️",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -50000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Лиля',
        sub_category_name: nil,
        price_in_usd: 500.0,
        operation_amount: 500.0,
        current_month: Date.today.month,
        mono_description: "Лиля ❤️",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when Liliia salary another day', freezed_time: '2022-08-02' do
    let(:transaction_data) do
      {
        amount: -50000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Лиля ❤️",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -50000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
        is_fop_dollar: true,
        currency_rate: 1.0,
      }
    end
    let(:params) do
      {
        category_name: 'Лиля',
        sub_category_name: nil,
        price_in_usd: 500.0,
        operation_amount: 500.0,
        current_month: Date.today.month,
        mono_description: "Лиля ❤️",
        currency_rate: 1.0,
      }
    end

    it 'does not call job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

  context 'when google' do
    let(:transaction_data) do
      {
        amount: -200,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Google",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -200,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'google',
        price_in_usd: 2.0,
        operation_amount: 2.0,
        current_month: Date.today.month,
        mono_description: "Google",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama 1st date of month', freezed_time: '2022-08-01' do
    let(:transaction_data) do
      {
        amount: -10000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "516875******6402",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -10000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Подарки',
        sub_category_name: 'мама Коли',
        price_in_usd: 100.0,
        operation_amount: 100.0,
        current_month: Date.today.month,
        mono_description: "516875******6402",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when kolya mama other day', freezed_time: '2022-08-02' do
    let(:transaction_data) do
      {
        amount: -10000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "516875******6402",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -10000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
        is_fop_dollar: true,
        currency_rate: 1.0,
      }
    end

    it 'does not call job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to receive(:call).with(transaction_data)

      subject
    end
  end

  context 'when kladovka_1' do
    let(:transaction_data) do
      {
        amount: -10000,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "536354******0388",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -10000,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'кладовка',
        price_in_usd: 100.0,
        operation_amount: 100.0,
        current_month: Date.today.month,
        mono_description: "536354******0388",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        price_in_usd: 750.0,
        operation_amount: 750.0,
        current_month: Date.today.month,
        mono_description: "431414******3237",
        currency_rate: 1.0,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        operationAmount: -4500,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Для дома',
        sub_category_name: 'Сервак, впн',
        price_in_usd: 45.0,
        operation_amount: 45.0,
        current_month: Date.today.month,
        mono_description: "DigitalOcean",
        currency_rate: 1,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
          category_name: 'Транспорт',
          sub_category_name: 'Автобус',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "STGCOACH/CTYLINK",
          currency_rate: 2.5,
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
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "THE COACH YARD",
          currency_rate: 2.5,
        }
      end

      it 'calls job PutExpencesFopDollarCardJob' do
        expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
          category_name: 'Еда',
          sub_category_name: 'Готовая',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "WASABI, SUSHI & BENTO",
          currency_rate: 2.5,
        }
      end

      it 'calls job PutExpencesFopDollarCardJob' do
        expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
          category_name: 'Транспорт',
          sub_category_name: 'Поезд',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "thetrainline.com",
          currency_rate: 2.5,
        }
      end

      it 'calls job PutExpencesFopDollarCardJob' do
        expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
          category_name: 'Транспорт',
          sub_category_name: 'Поезд',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "trainline",
          currency_rate: 2.5,
        }
      end

      it 'calls job PutExpencesFopDollarCardJob' do
        expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "McDonald’s",
        currency_rate: 2.5,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "McDonalds",
        currency_rate: 2.5,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        category_name: 'Путешествия',
        sub_category_name: 'Авиа билеты',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "Wizz Air",
        currency_rate: 2.5,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        category_name: 'Путешествия',
        sub_category_name: 'аренда кв',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "AIRBNB",
        currency_rate: 2.5,
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
        description: "На гривневий рахунок ФОП для переказу на картку",
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

  context 'when do not round to bigger number currency rate' do
    let(:transaction_data) do
      {
        amount: -138,
        balance: 2876000,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 980,
        description: "Wizz Air",
        hold: true,
        id: "JEMXm-kC9iSZNfGJ",
        mcc: 4829,
        operationAmount: -120,
        originalMcc: 4829,
        receiptId: "E4HC-1552-737M-HAC7",
        time: 1661541332,
      }
    end
    let(:params) do
      {
        category_name: 'Путешествия',
        sub_category_name: 'Авиа билеты',
        price_in_usd: 1.38,
        operation_amount: 1.2,
        current_month: Date.today.month,
        mono_description: "Wizz Air",
        currency_rate: 0.8695,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end
end
