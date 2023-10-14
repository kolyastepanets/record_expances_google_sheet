require 'rails_helper'

RSpec.describe HandleInputPhoto do
  subject { described_class.call(message_params) }

  describe 'when prices and categories' do
    let(:message_params) do
      {
        "message_id"=>26318,
        "from"=>{"id"=>ENV['MY_TELEGRAM_ID'], "is_bot"=>false, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>ENV['MY_USER_NAME'], "language_code"=>"en"},
        "chat"=>{"id"=>ENV['MY_TELEGRAM_ID'], "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>ENV['MY_USER_NAME'], "type"=>"private"},
        "date"=>1663427720,
        "photo"=>[
          {"file_id"=>"AgACAgIAAxkBAAJmzmMl5Ijq_uV3T2BfhulWCdL9pkKbAAJOvDEbR_gxSXhC7HjCBn8cAQADAgADcwADKQQ", "file_unique_id"=>"AQADTrwxG0f4MUl4", "file_size"=>1282, "width"=>67, "height"=>90},
          {"file_id"=>"AgACAgIAAxkBAAJmzmMl5Ijq_uV3T2BfhulWCdL9pkKbAAJOvDEbR_gxSXhC7HjCBn8cAQADAgADbQADKQQ", "file_unique_id"=>"AQADTrwxG0f4MUly", "file_size"=>18670, "width"=>240, "height"=>320},
          {"file_id"=>"AgACAgIAAxkBAAJmzmMl5Ijq_uV3T2BfhulWCdL9pkKbAAJOvDEbR_gxSXhC7HjCBn8cAQADAgADeAADKQQ", "file_unique_id"=>"AQADTrwxG0f4MUl9", "file_size"=>77109, "width"=>600, "height"=>800},
          {"file_id"=>"AgACAgIAAxkBAAJmzmMl5Ijq_uV3T2BfhulWCdL9pkKbAAJOvDEbR_gxSXhC7HjCBn8cAQADAgADeQADKQQ", "file_unique_id"=>"AQADTrwxG0f4MUl-", "file_size"=>103661, "width"=>960, "height"=>1280}
        ],
        "caption"=>caption
     }
    end
    let(:caption) { "Usd 15202 m" }
    let(:collected_prices_with_categories) do
      [
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>15000.0},
        {:category_name=>"Еда",      :sub_category_name=>"Новопочта", :price=>38000.0},
        {:category_name=>"Еда",      :sub_category_name=>"К пиву",    :price=>282500.0},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>25000.0},
        {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>16500.0},
      ]
    end
    let(:total_sum_in_receipt) { 377000.0 }
    let(:file_id) { "AQADuLwxG--FGEl-" }
    let(:response_after_save_expenses) do
      OpenStruct.new(
        table_range: "A5389"
      )
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
      allow(PricesFromImage).to receive(:call).and_return([collected_prices_with_categories, total_sum_in_receipt, file_id])
      allow(MonobankCurrencyRates).to receive(:call).and_return("37,4406")
      allow(ReceiveCategories).to receive(:call).and_return(categories)
      allow(SendTextMessagesBeforeEnterPrices).to receive(:call)
      allow(TextMessagesAfterEnterPrices).to receive(:call).and_return({
        total_sum_after_money_was_saved: "Общая сумма уже сохраненная после заполнения: 123",
        difference_of_saved_money: "Разница денег на основе сохраненных сумм, сравнить с ценой в чеке: 321",
      })
    end

    context 'when all categories present' do
      context 'when usd' do
        it 'calls PutExpensesToGoogleSheet, UpdateCellInGoogleSheet, SendNotificationMessageToBot' do
          allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_usd_money: 3100.0, coordinates_of_total_left_usd_money: "BC81"})

          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке в иностранной валюте: 377000.0")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: $24.8")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая сумма уже сохраненная после заполнения: 123")
          expect_any_instance_of(described_class).to receive(:send_message).with("Разница денег на основе сохраненных сумм, сравнить с ценой в чеке: 321", show_reply_markup_main_buttons: true)

          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 / 15202,0").and_return(response_after_save_expenses)
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 / 15202,0")
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "К пиву", "=282500,0 / 15202,0")
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 / 15202,0")
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Сладости", "=16500,0 / 15202,0")

          expect(UpdateCellInGoogleSheet).to receive(:call).with(3075.2, "BC81")

          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>15000.0,
              :price_in_usd=>0.99,
              :price_in_usd_to_save_in_google_sheet=>"=15000,0 / 15202,0",
              :sub_category_name=>"Ванные принадлежности"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>38000.0,
              :price_in_usd=>2.5,
              :price_in_usd_to_save_in_google_sheet=>"=38000,0 / 15202,0",
              :sub_category_name=>"Новопочта"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>282500.0,
              :price_in_usd=>18.58,
              :price_in_usd_to_save_in_google_sheet=>"=282500,0 / 15202,0",
              :sub_category_name=>"К пиву"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>25000.0,
              :price_in_usd=>1.64,
              :price_in_usd_to_save_in_google_sheet=>"=25000,0 / 15202,0",
              :sub_category_name=>"Ванные принадлежности"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>16500.0,
              :price_in_usd=>1.09,
              :price_in_usd_to_save_in_google_sheet=>"=16500,0 / 15202,0",
              :sub_category_name=>"Сладости"
            }
          )

          subject
        end
      end

      context 'when uah' do
        let(:caption) { "Uah 0.00242025 m" }

        it 'calls PutExpensesToGoogleSheet, UpdateCellInGoogleSheet, SendNotificationMessageToBot' do
          allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_uah_money: 3100.0, coordinates_of_total_left_uah_money: "BC81"})

          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке в иностранной валюте: 377000.0")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 912.43 грн")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая сумма уже сохраненная после заполнения: 123")
          expect_any_instance_of(described_class).to receive(:send_message).with("Разница денег на основе сохраненных сумм, сравнить с ценой в чеке: 321", show_reply_markup_main_buttons: true)

          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 * 0,00242025 / 37,4406").and_return(response_after_save_expenses)
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 * 0,00242025 / 37,4406")
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "К пиву", "=282500,0 * 0,00242025 / 37,4406")
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 * 0,00242025 / 37,4406")
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Сладости", "=16500,0 * 0,00242025 / 37,4406")

          expect(UpdateCellInGoogleSheet).to receive(:call).with(2187.57, "BC81")

          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>15000.0,
              :price_in_uah=>36.3,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=15000,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Ванные принадлежности"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>38000.0,
              :price_in_uah=>91.97,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=38000,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Новопочта"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>282500.0,
              :price_in_uah=>683.72,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=282500,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"К пиву"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>25000.0,
              :price_in_uah=>60.51,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=25000,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Ванные принадлежности"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>16500.0,
              :price_in_uah=>39.93,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=16500,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Сладости"
            }
          )

          expect(SendInfoHowMuchMoneyCanSpendThisWeekJob).to receive(:perform_later).with(["Для дома", "Еда", "Еда", "Для дома", "Еда"])

          subject
        end
      end
    end

    context 'when some categories absent' do
      let(:collected_prices_with_categories) do
        [
          {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>15000.0},
          {:category_name=>"Еда",      :sub_category_name=>"Новопочта", :price=>38000.0},
          {:category_name=>nil,        :sub_category_name=>nil,    :price=>282500.0},
          {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>25000.0},
          {:category_name=>nil,        :sub_category_name=>nil, :price=>16500.0},
        ]
      end
      let(:request_params_1) do
        [
          [
            {callback_data: "Транспорт:f_id:AQADuLwxG--FGEl-:282500.0", text: "Транспорт"},
            {callback_data: "Еда:f_id:AQADuLwxG--FGEl-:282500.0", text: "Еда"}
          ],
          [
            {callback_data: "Развлечения:f_id:AQADuLwxG--FGEl-:282500.0", text: "Развлечения"},
            {callback_data: "Подарки:f_id:AQADuLwxG--FGEl-:282500.0", text: "Подарки"}
          ],
          [
            {callback_data: "Для дома:f_id:AQADuLwxG--FGEl-:282500.0", text: "Для дома"},
            {callback_data: "Коля:f_id:AQADuLwxG--FGEl-:282500.0", text: "Коля"}
          ],
          [
            {callback_data: "Валди:f_id:AQADuLwxG--FGEl-:282500.0", text: "Валди"},
            {callback_data: "Непредвиденное:f_id:AQADuLwxG--FGEl-:282500.0", text: "Непредвиденное"}
          ],
          [
            {callback_data: "Марк:f_id:AQADuLwxG--FGEl-:282500.0", text: "Марк"},
            {callback_data: "Лиля:f_id:AQADuLwxG--FGEl-:282500.0", text: "Лиля"}
          ],
          [
            {callback_data: "Путешествия:f_id:AQADuLwxG--FGEl-:282500.0", text: "Путешествия"},
            {callback_data: "Инвестиции, фз:f_id:AQADuLwxG--FGEl-:282500.0", text: "Инвестиции, фз"}
          ],
          [
            {callback_data: "Авто бмоно:f_id:AQADuLwxG--FGEl-:282500.0", text: "Авто бмоно"},
            {callback_data: "Крупные покупки:f_id:AQADuLwxG--FGEl-:282500.0", text: "Крупные покупки"}
          ],
          [
            {callback_data: "Капитал:f_id:AQADuLwxG--FGEl-:282500.0", text: "Капитал"},
            {callback_data: "Кэш:f_id:AQADuLwxG--FGEl-:282500.0", text: "Кэш"}
          ]
        ]
      end
      let(:result1) do
        {
          "result" => {
            "message_id" => 456789
          }
        }
      end
      let(:request_params_2) do
        [
          [
            {callback_data: "Транспорт:f_id:AQADuLwxG--FGEl-:16500.0", text: "Транспорт"},
            {callback_data: "Еда:f_id:AQADuLwxG--FGEl-:16500.0", text: "Еда"}
          ],
          [
            {callback_data: "Развлечения:f_id:AQADuLwxG--FGEl-:16500.0", text: "Развлечения"},
            {callback_data: "Подарки:f_id:AQADuLwxG--FGEl-:16500.0", text: "Подарки"}
          ],
          [
            {callback_data: "Для дома:f_id:AQADuLwxG--FGEl-:16500.0", text: "Для дома"},
            {callback_data: "Коля:f_id:AQADuLwxG--FGEl-:16500.0", text: "Коля"}
          ],
          [
            {callback_data: "Валди:f_id:AQADuLwxG--FGEl-:16500.0", text: "Валди"},
            {callback_data: "Непредвиденное:f_id:AQADuLwxG--FGEl-:16500.0", text: "Непредвиденное"}
          ],
          [
            {callback_data: "Марк:f_id:AQADuLwxG--FGEl-:16500.0", text: "Марк"},
            {callback_data: "Лиля:f_id:AQADuLwxG--FGEl-:16500.0", text: "Лиля"}
          ],
          [
            {callback_data: "Путешествия:f_id:AQADuLwxG--FGEl-:16500.0", text: "Путешествия"},
            {callback_data: "Инвестиции, фз:f_id:AQADuLwxG--FGEl-:16500.0", text: "Инвестиции, фз"}
          ],
          [
            {callback_data: "Авто бмоно:f_id:AQADuLwxG--FGEl-:16500.0", text: "Авто бмоно"},
            {callback_data: "Крупные покупки:f_id:AQADuLwxG--FGEl-:16500.0", text: "Крупные покупки"}
          ],
          [
            {callback_data: "Капитал:f_id:AQADuLwxG--FGEl-:16500.0", text: "Капитал"},
            {callback_data: "Кэш:f_id:AQADuLwxG--FGEl-:16500.0", text: "Кэш"}
          ]
        ]
      end
      let(:result2) do
        {
          "result" => {
            "message_id" => 789123
          }
        }
      end

      context 'when usd' do
        it 'calls PutExpensesToGoogleSheet, UpdateCellInGoogleSheet, SendNotificationMessageToBot' do
          allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_usd_money: 3100.0, coordinates_of_total_left_usd_money: "BC81"})

          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке в иностранной валюте: 377000.0")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: $24.8")

          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 / 15202,0").and_return(response_after_save_expenses)
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 / 15202,0")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>282500.0}, request_params_1).and_return(result1)
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 / 15202,0")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>16500.0}, request_params_2).and_return(result2)

          expect(UpdateCellInGoogleSheet).to receive(:call).with(3094.87, "BC81")

          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>15000.0,
              :price_in_usd=>0.99,
              :price_in_usd_to_save_in_google_sheet=>"=15000,0 / 15202,0",
              :sub_category_name=>"Ванные принадлежности"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>38000.0,
              :price_in_usd=>2.5,
              :price_in_usd_to_save_in_google_sheet=>"=38000,0 / 15202,0",
              :sub_category_name=>"Новопочта"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>25000.0,
              :price_in_usd=>1.64,
              :price_in_usd_to_save_in_google_sheet=>"=25000,0 / 15202,0",
              :sub_category_name=>"Ванные принадлежности"
            }
          )

          subject
        end
      end

      context 'when uah' do
        let(:caption) { "Uah 0.00242025 m" }

        it 'calls PutExpensesToGoogleSheet, UpdateCellInGoogleSheet, SendNotificationMessageToBot' do
          allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_uah_money: 3100.0, coordinates_of_total_left_uah_money: "BC81"})

          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке в иностранной валюте: 377000.0")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 912.43 грн")

          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 * 0,00242025 / 37,4406").and_return(response_after_save_expenses)
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 * 0,00242025 / 37,4406")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>282500.0}, request_params_1).and_return(result1)
          expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 * 0,00242025 / 37,4406")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>16500.0}, request_params_2).and_return(result2)

          expect(UpdateCellInGoogleSheet).to receive(:call).with(2911.22, "BC81")

          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>15000.0,
              :price_in_uah=>36.3,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=15000,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Ванные принадлежности"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Еда",
              :operation_amount=>38000.0,
              :price_in_uah=>91.97,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=38000,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Новопочта"
            }
          )
          expect(SendNotificationMessageToBot).to receive(:call).with(
            {
              :category_name=>"Для дома",
              :operation_amount=>25000.0,
              :price_in_uah=>60.51,
              :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=25000,0 * 0,00242025 / 37,4406",
              :sub_category_name=>"Ванные принадлежности"
            }
          )

          subject
        end
      end
    end

    context 'when difference too big between sum and total_sum_in_receipt (more than 200)' do
      let(:total_sum_in_receipt) { 376799.0 }

      it 'sends to bot error message' do
        expect_any_instance_of(described_class).to receive(:send_message).with("не смог распарсить все цены в чеке :(((, сумма всех цен: 377000.0, сумма: 376799.0")

        subject
      end
    end

    context 'when sum of all prices more than 201 of total_sum_in_receipt' do
      let(:total_sum_in_receipt) { 377201.0 }

      it 'sends to bot error message' do
        expect_any_instance_of(described_class).to receive(:send_message).with("не смог распарсить все цены в чеке :(((, сумма всех цен: 377000.0, сумма: 377201.0")

        subject
      end
    end

    context 'when difference more/less than 200 rupiah' do
      # category_name nil to not stub PutExpensesToGoogleSheet and other classes
      let(:collected_prices_with_categories) do
        [
          {:category_name=>nil, :sub_category_name=>nil, :price=>15000.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>38000.0},
        ]
      end
      let(:request_params_1) do
        [
          [
            {callback_data: "Транспорт:f_id:AQADuLwxG--FGEl-:15000.0", text: "Транспорт"},
            {callback_data: "Еда:f_id:AQADuLwxG--FGEl-:15000.0", text: "Еда"}
          ],
          [
            {callback_data: "Развлечения:f_id:AQADuLwxG--FGEl-:15000.0", text: "Развлечения"},
            {callback_data: "Подарки:f_id:AQADuLwxG--FGEl-:15000.0", text: "Подарки"}
          ],
          [
            {callback_data: "Для дома:f_id:AQADuLwxG--FGEl-:15000.0", text: "Для дома"},
            {callback_data: "Коля:f_id:AQADuLwxG--FGEl-:15000.0", text: "Коля"}
          ],
          [
            {callback_data: "Валди:f_id:AQADuLwxG--FGEl-:15000.0", text: "Валди"},
            {callback_data: "Непредвиденное:f_id:AQADuLwxG--FGEl-:15000.0", text: "Непредвиденное"}
          ],
          [
            {callback_data: "Марк:f_id:AQADuLwxG--FGEl-:15000.0", text: "Марк"},
            {callback_data: "Лиля:f_id:AQADuLwxG--FGEl-:15000.0", text: "Лиля"}
          ],
          [
            {callback_data: "Путешествия:f_id:AQADuLwxG--FGEl-:15000.0", text: "Путешествия"},
            {callback_data: "Инвестиции, фз:f_id:AQADuLwxG--FGEl-:15000.0", text: "Инвестиции, фз"}
          ],
          [
            {callback_data: "Авто бмоно:f_id:AQADuLwxG--FGEl-:15000.0", text: "Авто бмоно"},
            {callback_data: "Крупные покупки:f_id:AQADuLwxG--FGEl-:15000.0", text: "Крупные покупки"}
          ],
          [
            {callback_data: "Капитал:f_id:AQADuLwxG--FGEl-:15000.0", text: "Капитал"},
            {callback_data: "Кэш:f_id:AQADuLwxG--FGEl-:15000.0", text: "Кэш"}
          ]
        ]
      end
      let(:result1) do
        {
          "result" => {
            "message_id" => 456789
          }
        }
      end
      let(:request_params_2) do
        [
          [
            {callback_data: "Транспорт:f_id:AQADuLwxG--FGEl-:38000.0", text: "Транспорт"},
            {callback_data: "Еда:f_id:AQADuLwxG--FGEl-:38000.0", text: "Еда"}
          ],
          [
            {callback_data: "Развлечения:f_id:AQADuLwxG--FGEl-:38000.0", text: "Развлечения"},
            {callback_data: "Подарки:f_id:AQADuLwxG--FGEl-:38000.0", text: "Подарки"}
          ],
          [
            {callback_data: "Для дома:f_id:AQADuLwxG--FGEl-:38000.0", text: "Для дома"},
            {callback_data: "Коля:f_id:AQADuLwxG--FGEl-:38000.0", text: "Коля"}
          ],
          [
            {callback_data: "Валди:f_id:AQADuLwxG--FGEl-:38000.0", text: "Валди"},
            {callback_data: "Непредвиденное:f_id:AQADuLwxG--FGEl-:38000.0", text: "Непредвиденное"}
          ],
          [
            {callback_data: "Марк:f_id:AQADuLwxG--FGEl-:38000.0", text: "Марк"},
            {callback_data: "Лиля:f_id:AQADuLwxG--FGEl-:38000.0", text: "Лиля"}
          ],
          [
            {callback_data: "Путешествия:f_id:AQADuLwxG--FGEl-:38000.0", text: "Путешествия"},
            {callback_data: "Инвестиции, фз:f_id:AQADuLwxG--FGEl-:38000.0", text: "Инвестиции, фз"}
          ],
          [
            {callback_data: "Авто бмоно:f_id:AQADuLwxG--FGEl-:38000.0", text: "Авто бмоно"},
            {callback_data: "Крупные покупки:f_id:AQADuLwxG--FGEl-:38000.0", text: "Крупные покупки"}
          ],
          [
            {callback_data: "Капитал:f_id:AQADuLwxG--FGEl-:38000.0", text: "Капитал"},
            {callback_data: "Кэш:f_id:AQADuLwxG--FGEl-:38000.0", text: "Кэш"}
          ]
        ]
      end
      let(:result2) do
        {
          "result" => {
            "message_id" => 789123
          }
        }
      end

      before do
        allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({ total_left_usd_money: 10, total_left_uah_money: 10 })
        allow(UpdateCellInGoogleSheet).to receive(:call)
      end

      context 'when sum of all prices less than 200 of total_sum_in_receipt' do
        let(:total_sum_in_receipt) { 52801.0 }

        it 'sends message to bot with prices and categories' do
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке в иностранной валюте: 53000.0")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: $3.49")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>15000.0}, request_params_1).and_return(result1)
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>38000.0}, request_params_2).and_return(result2)

          subject
        end
      end

      context 'when total_sum_in_receipt less than 200 of sum all prices' do
        let(:total_sum_in_receipt) { 53199.0 }

        it 'sends message to bot with prices and categories' do
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке в иностранной валюте: 53000.0")
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: $3.49")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>15000.0}, request_params_1).and_return(result1)
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with({:category_name=>nil, :sub_category_name=>nil, :price=>38000.0}, request_params_2).and_return(result2)

          subject
        end
      end
    end
  end
end
