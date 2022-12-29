require 'rails_helper'

RSpec.describe SendMessageToBotToAskToEnterExpences do
  subject { described_class.call(transaction_data) }

  let(:id) { "6mIsfyeVdVbitoSl" }
  let(:redis) { Redis.new }
  let(:transaction_data) do
    {
      amount: -53362,
      balance: 3332238,
      cashbackAmount: 0,
      commissionRate: 0,
      currencyCode: 826,
      description: "Amazon.co.uk",
      hold: true,
      id: id,
      mcc: 5969,
      operationAmount: -1195,
      originalMcc: 5969,
      receiptId: "X5H9-3T1K-4HB8-CMC5",
      time: 1661777571,
      currency_rate: 0.8707,
    }
  end
  let(:categories) do
    {
      "Транспорт"=>["Такси", "Автобус", "Метро", "Другой", "Поезд", "Бензин", "Проездной"],
      "Еда"=>["Молочка", "Готовая", "Полуфабрикаты/морозилка", "Фрукты", "Овощи", "Сладости", "Бакалея", "Специи, приправы", "Колбаса, сосиски", "Кофе, Чай", "Новопочта", "Рыба", "Яйца", "Вода", "Хлеб и др", "Алкоголь", "К пиву", "Мясо", "Детское питание"],
      "Развлечения"=>["Ресторан", "Кино", "Другое", "Прогулка на катере", "Квадроциклы ", "Зоопарк", "Парк развлечений"],
      "Подарки"=>["мама Лили", "мама Коли", "Аня Кошовенко", "Папа Лили", "Валера", "Лиля", "Илья крестник", "Маша Степанец", "Лена Ляшко ", "Глеб Сахно", "папа Коли", "Оля Ковалевская дети", "Марина Петренко дети", "Аня Роменская", "Вероника (Дима Вика)", "Артем Косенко", "Николь", "Стефания", "Мила", "Дима Васин", "Победа", "Викуся", "Даша днепр", "Катя Кошовенко", "John Howland Jackson", "Джеки (филип, англ)", "Rachel Howland Jackson", "Rody Howland Jackson", "Женя Куть"],
      "Для дома"=>["youtube", "google", "инет", "инвентарь", "аренда кв", "комуналка", "кладовка", "Ванные принадлежности", "Кухонные принадлежности", "Ремонт", "УБС", "Аптека", "Уборка", "Сервак, впн"],
      "Коля"=>["Документы ", "Подарки", "Цветы", "Здоровье", "Одежда", "Обучение", "Мобильный", "Спорт", "Виктория", "Парикмахерская ", "Книги", "Хобби", "Игры ", "Банка", "Ванные принадлежности"],
      "Валди"=>["Корм", "Вкусняшки", "Игрушки", "Крем", "Больница", "Прививки", "Витамины", "Поводок", "Пакеты", "Коврик"],
      "Непредвиденное"=>["ж/д билеты", "% за кр лимит", "% за наличку", "Одежда", "Аптека", "Виктория папа ", "Виктория мама", "Новая почта", "Не знаю", "Фотосессия", "Недостача ", "Дорога родителям", "Кошачий корм", "Благотворительность"],
      "Марк"=>["Одежда", "Памперсы", "Больница", "Посуда", "Книги", "Игрушки", "Документы", "Обучение", "Парикмахерская ", "Дет сад"],
      "Лиля"=>["Одежда", "Красота", "Медицина", "Образование", "Мобильный", "Украшения", "Документы ", "Ванные принадлежности", "Книги"],
      "Путешествия"=>["Австрия Наличка € в гривнах ", "Танзания Наличка $ в гривнах", "Египет Наличка $ в гривнах", "Танзания тур", "Виза", "Бердянск отель", "Бердянск еда", "Бердянск билеты", "Австрия билеты", "Валди отель", "Тест на корону", "3 страховки в Европу ", "Австрия поезд", "Австрия Фуникулёр", "Австрия Сувениры", "Австрия музей", "Австрия еда, автобус, наличка", "Австрия аренда авто", "Перенос билетов", "Египет тур", "Египет штуки для тела", "Страховка", "Доверенность", "Авиа билеты", "аренда кв", "наличка $ в гривнах", "чаевые", "экскурсия", "сувениры"],
      "Инвестиции, фз"=>["фз", "инвест капитал"],
      "Авто бмоно"=>["бензин", "сто", "Акссесуары", "Мойка", "Страховка", "Парковка"],
      "Крупные покупки"=>["Кофемашина", "Airpods pro 2", "Посудомоечная машина", "Чемодан", "Фен", "iPhone", "Телек"],
      "Капитал"=>["дал в долг", "долг в путешествия", "годовой взнос клуб ч.и."],
      "Кэш"=>[]
    }
  end

  before do
    allow(ReceiveCategories).to receive(:call).and_return(categories)
  end

  context 'when telegram bot sends message' do
    let(:response_message_with_params) do
      {
        "result" => {
          "message_id" => 123
        }
      }
    end
    let(:response_message_with_categories) do
      {
        "result" => {
          "message_id" => 456
        }
      }
    end

    before do
      allow_any_instance_of(described_class).to receive(:send_message_with_params).and_return(response_message_with_params)
      allow_any_instance_of(described_class).to receive(:send_message_with_categories).and_return(response_message_with_categories)
      allow_any_instance_of(described_class).to receive(:send_message_with_categories_when_calculate_as_half_expenses).and_return(response_message_with_categories)
    end

    it "saves message ids to redis" do
      subject

      expect(JSON.parse(redis.get(id)).deep_symbolize_keys).to eq({
        description: "Amazon.co.uk",
        message_ids: [123, 456, 456],
        price_in_uah: 533.62,
        operation_amount: 11.95,
        price_in_usd: nil,
        currency_rate: 0.8707,
      })
    end
  end

  context 'expenses to skip' do
    context 'when on jar' do
      let(:transaction_data) do
        {
          amount: -53362,
          balance: 3332238,
          cashbackAmount: 0,
          commissionRate: 0,
          currencyCode: 826,
          description: "На награду в моно",
          hold: true,
          id: id,
          mcc: 5969,
          operationAmount: -1195,
          originalMcc: 5969,
          receiptId: "X5H9-3T1K-4HB8-CMC5",
          time: 1661777571
        }
      end

      it 'does not call telegram bot' do
        expect_any_instance_of(described_class).to_not receive(:send_message_with_params)
        expect_any_instance_of(described_class).to_not receive(:send_message_with_categories)
        expect_any_instance_of(described_class).to_not receive(:send_message_with_categories_when_calculate_as_half_expenses)

        subject
      end

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'when sold dollars from fop' do
      let(:transaction_data) do
        {
          amount: -53362,
          balance: 3332238,
          cashbackAmount: 0,
          commissionRate: 0,
          currencyCode: 826,
          description: "З гривневого рахунка ФОП",
          hold: true,
          id: id,
          mcc: 5969,
          operationAmount: -1195,
          originalMcc: 5969,
          receiptId: "X5H9-3T1K-4HB8-CMC5",
          time: 1661777571
        }
      end

      it 'does not call telegram bot' do
        expect_any_instance_of(described_class).to_not receive(:send_message_with_params)
        expect_any_instance_of(described_class).to_not receive(:send_message_with_categories)
        expect_any_instance_of(described_class).to_not receive(:send_message_with_categories_when_calculate_as_half_expenses)

        subject
      end

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'when withdraw cashback' do
      let(:transaction_data) do
        {
          amount: -53362,
          balance: 3332238,
          cashbackAmount: 0,
          commissionRate: 0,
          currencyCode: 826,
          description: "Виведення кешбеку 123",
          hold: true,
          id: id,
          mcc: 5969,
          operationAmount: -1195,
          originalMcc: 5969,
          receiptId: "X5H9-3T1K-4HB8-CMC5",
          time: 1661777571
        }
      end

      it 'does not call telegram bot' do
        expect_any_instance_of(described_class).to_not receive(:send_message_with_params)
        expect_any_instance_of(described_class).to_not receive(:send_message_with_categories)
        expect_any_instance_of(described_class).to_not receive(:send_message_with_categories_when_calculate_as_half_expenses)

        subject
      end

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end
  end

  context '#categories_to_show' do
    let(:result) do
      [
        [
          {callback_data: "Транспорт: c_id:6mIsfyeVdVbitoSl", text: "Транспорт"},
          {callback_data: "Еда: c_id:6mIsfyeVdVbitoSl", text: "Еда"}
        ],
        [
          {callback_data: "Развлечения: c_id:6mIsfyeVdVbitoSl", text: "Развлечения"},
          {callback_data: "Подарки: c_id:6mIsfyeVdVbitoSl", text: "Подарки"}
        ],
        [
          {callback_data: "Для дома: c_id:6mIsfyeVdVbitoSl", text: "Для дома"},
          {callback_data: "Коля: c_id:6mIsfyeVdVbitoSl", text: "Коля"}
        ],
        [
          {callback_data: "Валди: c_id:6mIsfyeVdVbitoSl", text: "Валди"},
          {callback_data: "Непредвиденное: c_id:6mIsfyeVdVbitoSl", text: "Непредвиденное"}
        ],
        [
          {callback_data: "Марк: c_id:6mIsfyeVdVbitoSl", text: "Марк"},
          {callback_data: "Лиля: c_id:6mIsfyeVdVbitoSl", text: "Лиля"}
        ],
        [
          {callback_data: "Путешествия: c_id:6mIsfyeVdVbitoSl", text: "Путешествия"},
          {callback_data: "Инвестиции, фз: c_id:6mIsfyeVdVbitoSl", text: "Инвестиции, фз"}
        ],
        [
          {callback_data: "Авто бмоно: c_id:6mIsfyeVdVbitoSl", text: "Авто бмоно"},
          {callback_data: "Крупные покупки: c_id:6mIsfyeVdVbitoSl", text: "Крупные покупки"}
        ],
        [
          {callback_data: "Капитал: c_id:6mIsfyeVdVbitoSl", text: "Капитал"},
          {callback_data: "Кэш: c_id:6mIsfyeVdVbitoSl", text: "Кэш"}
        ],
        [
          {callback_data: "remove_messages: 6mIsfyeVdVbitoSl", text: "Удалить сообщения этой транзакции"},
        ]
      ]
    end

    it 'returns categories and btn messages to delete' do
      expect(described_class.new(transaction_data).send(:categories_to_show)).to eq(result)
    end
  end

  context '#categories_to_show_as_half_expenses' do
    let(:result) do
      [
        [
          {callback_data: "Транспорт: h_id:6mIsfyeVdVbitoSl", text: "Транспорт"},
          {callback_data: "Еда: h_id:6mIsfyeVdVbitoSl", text: "Еда"}
        ],
        [
          {callback_data: "Развлечения: h_id:6mIsfyeVdVbitoSl", text: "Развлечения"},
          {callback_data: "Подарки: h_id:6mIsfyeVdVbitoSl", text: "Подарки"}
        ],
        [
          {callback_data: "Для дома: h_id:6mIsfyeVdVbitoSl", text: "Для дома"},
          {callback_data: "Коля: h_id:6mIsfyeVdVbitoSl", text: "Коля"}
        ],
        [
          {callback_data: "Валди: h_id:6mIsfyeVdVbitoSl", text: "Валди"},
          {callback_data: "Непредвиденное: h_id:6mIsfyeVdVbitoSl", text: "Непредвиденное"}
        ],
        [
          {callback_data: "Марк: h_id:6mIsfyeVdVbitoSl", text: "Марк"},
          {callback_data: "Лиля: h_id:6mIsfyeVdVbitoSl", text: "Лиля"}
        ],
        [
          {callback_data: "Путешествия: h_id:6mIsfyeVdVbitoSl", text: "Путешествия"},
          {callback_data: "Инвестиции, фз: h_id:6mIsfyeVdVbitoSl", text: "Инвестиции, фз"}
        ],
        [
          {callback_data: "Авто бмоно: h_id:6mIsfyeVdVbitoSl", text: "Авто бмоно"},
          {callback_data: "Крупные покупки: h_id:6mIsfyeVdVbitoSl", text: "Крупные покупки"}
        ],
        [
          {callback_data: "Капитал: h_id:6mIsfyeVdVbitoSl", text: "Капитал"},
          {callback_data: "Кэш: h_id:6mIsfyeVdVbitoSl", text: "Кэш"}
        ],
        [
          {callback_data: "remove_messages: 6mIsfyeVdVbitoSl", text: "Удалить сообщения этой транзакции"}
        ]
      ]
    end

    it 'returns categories and btn messages to delete' do
      expect(described_class.new(transaction_data).send(:categories_to_show_as_half_expenses)).to eq(result)
    end
  end

  context 'when fop dollar usd' do
    let(:transaction_data) do
      {
        amount: -53362,
        balance: 3332238,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 826,
        description: "Amazon.co.uk",
        hold: true,
        id: id,
        mcc: 5969,
        operationAmount: -1195,
        originalMcc: 5969,
        receiptId: "X5H9-3T1K-4HB8-CMC5",
        time: 1661777571,
        is_fop_dollar: true,
        currency_rate: 0.8707,
      }
    end
    let(:response_message_with_params) do
      {
        "result" => {
          "message_id" => 123
        }
      }
    end
    let(:response_message_with_categories) do
      {
        "result" => {
          "message_id" => 456
        }
      }
    end

    before do
      allow_any_instance_of(described_class).to receive(:send_message_with_params).and_return(response_message_with_params)
      allow_any_instance_of(described_class).to receive(:send_message_with_categories).and_return(response_message_with_categories)
      allow_any_instance_of(described_class).to receive(:send_message_with_categories_when_calculate_as_half_expenses).and_return(response_message_with_categories)
    end

    it "saves message ids to redis" do
      subject

      expect(JSON.parse(redis.get(id)).deep_symbolize_keys).to eq({
        description: "Amazon.co.uk",
        message_ids: [123, 456, 456],
        price_in_uah: nil,
        operation_amount: 11.95,
        price_in_usd: 533.62,
        currency_rate: 0.8707,
      })
    end
  end
end
