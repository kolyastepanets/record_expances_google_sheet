require 'rails_helper'

RSpec.describe EnterExpencesFopDollarCardFromWebhook do
  subject{ described_class.call(transaction_data) }

  before do
    allow(SendTextMessagesBeforeEnterPrices).to receive(:call).and_return(12345)
  end

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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'youtube',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "YouTube",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        can_show_final_sum: true,
        category_name: 'Для дома',
        sub_category_name: 'google',
        price_in_usd: 2.0,
        operation_amount: 2.0,
        current_month: Date.today.month,
        mono_description: "Google",
        currency_rate: 1.0,
        total_sum_of_money_before_save: 12345,
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Автобус',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "STGCOACH/CTYLINK",
          currency_rate: 2.5,
          total_sum_of_money_before_save: 12345,
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Автобус',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "THE COACH YARD",
          currency_rate: 2.5,
          total_sum_of_money_before_save: 12345,
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
          can_show_final_sum: true,
          category_name: 'Еда',
          sub_category_name: 'Готовая',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "WASABI, SUSHI & BENTO",
          currency_rate: 2.5,
          total_sum_of_money_before_save: 12345,
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Поезд',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "thetrainline.com",
          currency_rate: 2.5,
          total_sum_of_money_before_save: 12345,
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
          can_show_final_sum: true,
          category_name: 'Транспорт',
          sub_category_name: 'Поезд',
          price_in_usd: 4.0,
          operation_amount: 10.0,
          current_month: Date.today.month,
          mono_description: "trainline",
          currency_rate: 2.5,
          total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "McDonald’s",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Еда',
        sub_category_name: 'Готовая',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "McDonalds",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "KIOSK MCD",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "THE LEAVES CAFE EATERY",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Путешествия',
        sub_category_name: 'Авиа билеты',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "Wizz Air",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Путешествия',
        sub_category_name: 'аренда кв',
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "AIRBNB",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
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
        can_show_final_sum: true,
        category_name: 'Путешествия',
        sub_category_name: 'Авиа билеты',
        price_in_usd: 1.38,
        operation_amount: 1.2,
        current_month: Date.today.month,
        mono_description: "Wizz Air",
        currency_rate: 0.869565,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end

  context 'when sold dollars from fop to uah fop for taxes' do
    let(:transaction_data) do
      {
        description: "На гривневий рахунок ФОП",
        mcc: 4829,
        originalMcc: 4829,
        amount: -19367,
        operationAmount: -709800,
        currencyCode: 980,
        commissionRate: 0,
        cashbackAmount: 0,
        balance: 1,
        hold: true,
      }
    end
    let(:params) do
      {
        dollars: 193.67,
        sold_dollars_to_uah_fop_for_taxes: true,
      }
    end

    it 'calls job DecreaseDollarsJob' do
      expect(DecreaseDollarsJob).to receive(:perform_later).with(params)
      expect(EnterSoldDollarsFromFopJob).to_not receive(:perform_later)
      expect(PutExpencesFopDollarCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to_not receive(:call)

      subject
    end
  end

  context 'when swift' do
    let(:transaction_data) do
      {
        description: "SWIFT платіж: MT103 від 14/10/2022,3",
        mcc: 4829,
        originalMcc: 4829,
        amount: -19367,
        operationAmount: -709800,
        currencyCode: 980,
        commissionRate: 0,
        cashbackAmount: 0,
        balance: 1,
        hold: true,
      }
    end
    let(:params) do
      {
        dollars: 193.67,
        swift_salary: true,
      }
    end

    it 'calls job EnterSalaryFromSwiftJob' do
      expect(EnterSalaryFromSwiftJob).to receive(:perform_later).with(params)
      expect(DecreaseDollarsJob).to_not receive(:perform_later)
      expect(EnterSoldDollarsFromFopJob).to_not receive(:perform_later)
      expect(PutExpencesFopDollarCardJob).to_not receive(:perform_later)
      expect(SendMessageToBotToAskToEnterExpences).to_not receive(:call)

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
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "BAYU SANTERO 1 MBL",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "BBS - NESPRESSO BEACHW",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

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
        price_in_usd: 4.0,
        operation_amount: 10.0,
        current_month: Date.today.month,
        mono_description: "BBS - NESPRESSO BEACHWALK",
        currency_rate: 2.5,
        total_sum_of_money_before_save: 12345,
      }
    end

    it 'calls job PutExpencesFopDollarCardJob' do
      expect(PutExpencesFopDollarCardJob).to receive(:perform_later).with(params)

      subject
    end
  end
end
