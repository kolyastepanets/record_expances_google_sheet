require 'rails_helper'

RSpec.describe PrepareParamsAfterEnterSubcategoryBeforeSave do
  subject { described_class.call(telegram_message) }

  let(:telegram_message) do
    "Полуфабрикаты/м_: f1_id:1234567890123456:2.99"
  end
  let(:categories) do
    {
      "Транспорт"=>["Такси", "Автобус", "Метро", "Другой", "Поезд", "Бензин", "Проездной"],
      "Еда"=>["Молочка", "Готовая", "Полуфабрикаты/морозилка", "Фрукты", "Овощи", "Сладости", "Бакалея", "Специи, приправы", "Колбаса, сосиски", "Кофе, Чай", "Новопочта", "Рыба", "Яйца", "Вода", "Хлеб и др", "Алкоголь", "К пиву", "Мясо", "Детское питание"],
      "Развлечения"=>["Ресторан", "Кино", "Другое", "Прогулка на катере", "Квадроциклы ", "Зоопарк", "Парк развлечений"],
      "Подарки"=>["мама Лили", "мама Коли", "Аня Кошовенко", "Папа Лили", "Валера", "Лиля", "Илья крестник", "Маша Степанец", "Лена Ляшко ", "Глеб Сахно", "папа Коли", "Оля Ковалевская дети", "Марина Петренко дети", "Аня Роменская", "Вероника (Дима Вика)", "Артем Косенко", "Николь", "Стефания", "Мила", "Дима Васин", "Победа", "Викуся", "Даша днепр", "Катя Кошовенко", "John Howland Jackson", "Джеки (филип, англ)", "Rachel Howland Jackson", "Rody Howland Jackson", "Женя Куть"],
      "Для дома"=>["Онлайн-видео", "google", "инет", "инвентарь", "аренда кв", "комуналка", "кладовка", "Ванные принадлежности", "Кухонные принадлежности", "Ремонт", "УБС", "Аптека", "Уборка", "Сервак, впн"],
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
    Redis.new.set("1234567890123456", redis_params)
    allow(ReceiveCategories).to receive(:call).and_return(categories)
  end

  context 'when uah' do
    let(:redis_params) { "[{\"price\":2.65,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26582]},{\"price\":2.85,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26583]},{\"price\":1.55,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26584]},{\"price\":1.75,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26585]},{\"price\":3.35,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26586]},{\"price\":1.2,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26587]},{\"price\":1.09,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26588]},{\"price\":0.6,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26589]},{\"price\":1.29,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26590]},{\"price\":5.5,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26591]},{\"price\":2.03,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26592]},{\"price\":2.73,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26593]},{\"price\":2.99,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26594,26594],\"category_name\":\"Еда\"}]" }

    before do
      allow(MonobankCurrencyRates).to receive(:call).with('USD', 'UAH').and_return(37.4995)
    end

    it 'returns 3 values' do
      expect(subject).to eq(
        [
          {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :operation_amount=>2.99, :price_in_uah=>135.92540000000002, price_in_uah_converted_to_usd_to_save_in_google_sheet: "=2,99 * 45,46 / 37,4995"},
          [
            {"price"=>2.65, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26582]},
            {"price"=>2.85, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26583]},
            {"price"=>1.55, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26584]},
            {"price"=>1.75, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26585]},
            {"price"=>3.35, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26586]},
            {"price"=>1.2,  "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26587]},
            {"price"=>1.09, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26588]},
            {"price"=>0.6,  "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26589]},
            {"price"=>1.29, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26590]},
            {"price"=>5.5,  "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26591]},
            {"price"=>2.03, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26592]},
            {"price"=>2.73, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26593]}
          ],
          [26594, 26594]
        ]
      )
    end
  end

  context 'when usd' do
    let(:redis_params) { "[{\"price\":2.65,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26582]},{\"price\":2.85,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26583]},{\"price\":1.55,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26584]},{\"price\":1.75,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26585]},{\"price\":3.35,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26586]},{\"price\":1.2,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26587]},{\"price\":1.09,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26588]},{\"price\":0.6,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26589]},{\"price\":1.29,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26590]},{\"price\":5.5,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26591]},{\"price\":2.03,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26592]},{\"price\":2.73,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26593]},{\"price\":2.99,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26594,26594],\"category_name\":\"Еда\"}]" }

    it 'returns 3 values' do
      expect(subject).to eq(
        [
          {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :operation_amount=>2.99, :price_in_usd=>3.4340186057195363, price_in_usd_to_save_in_google_sheet: "=2,99 / 0,8707"},
          [
            {"price"=>2.65, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26582]},
            {"price"=>2.85, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26583]},
            {"price"=>1.55, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26584]},
            {"price"=>1.75, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26585]},
            {"price"=>3.35, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26586]},
            {"price"=>1.2,  "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26587]},
            {"price"=>1.09, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26588]},
            {"price"=>0.6,  "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26589]},
            {"price"=>1.29, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26590]},
            {"price"=>5.5,  "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26591]},
            {"price"=>2.03, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26592]},
            {"price"=>2.73, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26593]}
          ],
          [26594, 26594]
        ]
      )
    end
  end

  context 'when decrease total_sum_manually_entered_categories' do
    let(:redis_params) { "[{\"price\":2.99,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26582]},{\"total_sum_manually_entered_categories\":3}]" }

    it 'returns total_sum_manually_entered_categories 2' do
      expect(subject).to eq(
        [
          {
            :category_name=>nil,
            :sub_category_name=>"Полуфабрикаты/морозилка",
            :operation_amount=>2.99,
            :price_in_usd=>3.4340186057195363,
            :price_in_usd_to_save_in_google_sheet=>"=2,99 / 0,8707"
          },
          [
            {"total_sum_manually_entered_categories"=>2}
          ],
          [26582]
        ]
      )
    end
  end
end
