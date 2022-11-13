require 'rails_helper'

RSpec.describe HandleInputPhoto do
  subject { described_class.call(message_params) }

  if !ENV['PARSE_PRICE_WITH_CATEGORIES']
    describe 'when only prices' do
      let(:message_params) do
        {
          "message_id"=>26318,
          "from"=>{"id"=>384435131, "is_bot"=>false, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>"nikolay_stepanets", "language_code"=>"en"},
          "chat"=>{"id"=>384435131, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>"nikolay_stepanets", "type"=>"private"},
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
      let(:caption) { "Usd 0.8695" }
      let(:collected_prices) { [1.2, 1.8] }
      let(:total_sum_in_receipt) { 3 }
      let(:file_id) { "AQADuLwxG--FGEl-" }
      let(:result1) do
        {
          "result" => {
            "message_id" => 123456
          }
        }
      end
      let(:request_params_1) do
        [
          [
            {callback_data: "Транспорт: f_id:AQADuLwxG--FGEl-:1.2", text: "Транспорт"},
            {callback_data: "Еда: f_id:AQADuLwxG--FGEl-:1.2", text: "Еда"}
          ],
          [
            {callback_data: "Развлечения: f_id:AQADuLwxG--FGEl-:1.2", text: "Развлечения"},
            {callback_data: "Подарки: f_id:AQADuLwxG--FGEl-:1.2", text: "Подарки"}
          ],
          [
            {callback_data: "Для дома: f_id:AQADuLwxG--FGEl-:1.2", text: "Для дома"},
            {callback_data: "Коля: f_id:AQADuLwxG--FGEl-:1.2", text: "Коля"}
          ],
          [
            {callback_data: "Валди: f_id:AQADuLwxG--FGEl-:1.2", text: "Валди"},
            {callback_data: "Непредвиденное: f_id:AQADuLwxG--FGEl-:1.2", text: "Непредвиденное"}
          ],
          [
            {callback_data: "Марк: f_id:AQADuLwxG--FGEl-:1.2", text: "Марк"},
            {callback_data: "Лиля: f_id:AQADuLwxG--FGEl-:1.2", text: "Лиля"}
          ],
          [
            {callback_data: "Путешествия: f_id:AQADuLwxG--FGEl-:1.2", text: "Путешествия"},
            {callback_data: "Инвестиции, фз: f_id:AQADuLwxG--FGEl-:1.2", text: "Инвестиции, фз"}
          ],
          [
            {callback_data: "Авто бмоно: f_id:AQADuLwxG--FGEl-:1.2", text: "Авто бмоно"},
            {callback_data: "Крупные покупки: f_id:AQADuLwxG--FGEl-:1.2", text: "Крупные покупки"}
          ],
          [
            {callback_data: "Капитал: f_id:AQADuLwxG--FGEl-:1.2", text: "Капитал"},
            {callback_data: "Кэш: f_id:AQADuLwxG--FGEl-:1.2", text: "Кэш"}
          ]
        ]
      end
      let(:result2) do
        {
          "result" => {
            "message_id" => 456789
          }
        }
      end
      let(:request_params_2) do
        [
          [
            {callback_data: "Транспорт: f_id:AQADuLwxG--FGEl-:1.8", text: "Транспорт"},
            {callback_data: "Еда: f_id:AQADuLwxG--FGEl-:1.8", text: "Еда"}
          ],
          [
            {callback_data: "Развлечения: f_id:AQADuLwxG--FGEl-:1.8", text: "Развлечения"},
            {callback_data: "Подарки: f_id:AQADuLwxG--FGEl-:1.8", text: "Подарки"}
          ],
          [
            {callback_data: "Для дома: f_id:AQADuLwxG--FGEl-:1.8", text: "Для дома"},
            {callback_data: "Коля: f_id:AQADuLwxG--FGEl-:1.8", text: "Коля"}
          ],
          [
            {callback_data: "Валди: f_id:AQADuLwxG--FGEl-:1.8", text: "Валди"},
            {callback_data: "Непредвиденное: f_id:AQADuLwxG--FGEl-:1.8", text: "Непредвиденное"}
          ],
          [
            {callback_data: "Марк: f_id:AQADuLwxG--FGEl-:1.8", text: "Марк"},
            {callback_data: "Лиля: f_id:AQADuLwxG--FGEl-:1.8", text: "Лиля"}
          ],
          [
            {callback_data: "Путешествия: f_id:AQADuLwxG--FGEl-:1.8", text: "Путешествия"},
            {callback_data: "Инвестиции, фз: f_id:AQADuLwxG--FGEl-:1.8", text: "Инвестиции, фз"}
          ],
          [
            {callback_data: "Авто бмоно: f_id:AQADuLwxG--FGEl-:1.8", text: "Авто бмоно"},
            {callback_data: "Крупные покупки: f_id:AQADuLwxG--FGEl-:1.8", text: "Крупные покупки"}
          ],
          [
            {callback_data: "Капитал: f_id:AQADuLwxG--FGEl-:1.8", text: "Капитал"},
            {callback_data: "Кэш: f_id:AQADuLwxG--FGEl-:1.8", text: "Кэш"}
          ]
        ]
      end
      let(:result3) do
        {
          "result" => {
            "message_id" => 789012
          }
        }
      end
      let(:result4) do
        {
          "result" => {
            "message_id" => 345678
          }
        }
      end

      before do
        allow(PricesFromImage).to receive(:call).and_return([collected_prices, total_sum_in_receipt, file_id])
      end

      context 'when all prices are parced' do
        it 'sends message to bot with prices and categories' do
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 3.0")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.2, request_params_1).and_return(result2)
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.8, request_params_2).and_return(result4)

          subject
        end

        context 'check params' do
          before do
            allow_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 3.0")
            allow_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.2, request_params_1).and_return(result2)
            allow_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.8, request_params_2).and_return(result4)
          end

          context 'when Usd passed' do
            let(:result) do
              [
                {
                  "currency_to_uah"=>nil,
                  "currency_to_usd"=>0.8695,
                  "message_ids"=>[456789],
                  "price"=>1.2
                },
                {
                  "currency_to_uah"=>nil,
                  "currency_to_usd"=>0.8695,
                  "message_ids"=>[345678],
                  "price"=>1.8
                }
              ]
            end

            it 'saves params to redis' do
              subject

              expect(JSON.parse(Redis.new.get("AQADuLwxG--FGEl-"))).to eq(result)
            end
          end

          context 'when USD passed' do
            let(:caption) { "USD 0.8695" }
            let(:result) do
              [
                {
                  "currency_to_uah"=>nil,
                  "currency_to_usd"=>0.8695,
                  "message_ids"=>[456789],
                  "price"=>1.2
                },
                {
                  "currency_to_uah"=>nil,
                  "currency_to_usd"=>0.8695,
                  "message_ids"=>[345678],
                  "price"=>1.8
                }
              ]
            end

            it 'saves params to redis' do
              subject

              expect(JSON.parse(Redis.new.get("AQADuLwxG--FGEl-"))).to eq(result)
            end
          end

          context 'when usd passed' do
            let(:caption) { "usd 0.8695" }
            let(:result) do
              [
                {
                  "currency_to_uah"=>nil,
                  "currency_to_usd"=>0.8695,
                  "message_ids"=>[456789],
                  "price"=>1.2
                },
                {
                  "currency_to_uah"=>nil,
                  "currency_to_usd"=>0.8695,
                  "message_ids"=>[345678],
                  "price"=>1.8
                }
              ]
            end

            it 'saves params to redis' do
              subject

              expect(JSON.parse(Redis.new.get("AQADuLwxG--FGEl-"))).to eq(result)
            end
          end

          context 'when Uah passed' do
            let(:caption) { "Uah 45.8695" }
            let(:result) do
              [
                {
                  "currency_to_uah"=>45.8695,
                  "currency_to_usd"=>nil,
                  "message_ids"=>[456789],
                  "price"=>1.2
                },
                {
                  "currency_to_uah"=>45.8695,
                  "currency_to_usd"=>nil,
                  "message_ids"=>[345678],
                  "price"=>1.8
                }
              ]
            end

            it 'saves params to redis' do
              subject

              expect(JSON.parse(Redis.new.get("AQADuLwxG--FGEl-"))).to eq(result)
            end
          end

          context 'when UAH passed' do
            let(:caption) { "UAH 45.8695" }
            let(:result) do
              [
                {
                  "currency_to_uah"=>45.8695,
                  "currency_to_usd"=>nil,
                  "message_ids"=>[456789],
                  "price"=>1.2
                },
                {
                  "currency_to_uah"=>45.8695,
                  "currency_to_usd"=>nil,
                  "message_ids"=>[345678],
                  "price"=>1.8
                }
              ]
            end

            it 'saves params to redis' do
              subject

              expect(JSON.parse(Redis.new.get("AQADuLwxG--FGEl-"))).to eq(result)
            end
          end

          context 'when uah passed' do
            let(:caption) { "uah 45.8695" }
            let(:result) do
              [
                {
                  "currency_to_uah"=>45.8695,
                  "currency_to_usd"=>nil,
                  "message_ids"=>[456789],
                  "price"=>1.2
                },
                {
                  "currency_to_uah"=>45.8695,
                  "currency_to_usd"=>nil,
                  "message_ids"=>[345678],
                  "price"=>1.8
                }
              ]
            end

            it 'saves params to redis' do
              subject

              expect(JSON.parse(Redis.new.get("AQADuLwxG--FGEl-"))).to eq(result)
            end
          end
        end
      end

      context 'when difference too big between sum and total_sum_in_receipt' do
        let(:total_sum_in_receipt) { 10 }

        it 'sends to bot error message' do
          expect_any_instance_of(described_class).to receive(:send_message).with('не смог распарсить все цены в чеке :(((')

          subject
        end
      end

      context 'when sum of all prices less than 0.5 of total_sum_in_receipt' do
        let(:total_sum_in_receipt) { 2.5 }

        it 'sends message to bot with prices and categories' do
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 3.0")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.2, request_params_1).and_return(result2)
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.8, request_params_2).and_return(result4)

          subject
        end
      end

      context 'when sum of all prices more than 0.5 of total_sum_in_receipt' do
        let(:total_sum_in_receipt) { 2.4 }

        it 'sends to bot error message' do
          expect_any_instance_of(described_class).to receive(:send_message).with('не смог распарсить все цены в чеке :(((')

          subject
        end
      end

      context 'when total_sum_in_receipt more than 0.5 of sum all prices' do
        let(:total_sum_in_receipt) { 3.6 }

        it 'sends to bot error message' do
          expect_any_instance_of(described_class).to receive(:send_message).with('не смог распарсить все цены в чеке :(((')

          subject
        end
      end

      context 'when total_sum_in_receipt less than 0.5 of sum all prices' do
        let(:total_sum_in_receipt) { 3.4 }

        it 'sends message to bot with prices and categories' do
          expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 3.0")
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.2, request_params_1).and_return(result2)
          expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(1.8, request_params_2).and_return(result4)

          subject
        end
      end

      context 'when no photo in params' do
        let(:message_params) do
          {
            "message_id"=>26318,
            "from"=>{"id"=>384435131, "is_bot"=>false, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>"nikolay_stepanets", "language_code"=>"en"},
            "chat"=>{"id"=>384435131, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>"nikolay_stepanets", "type"=>"private"},
            "date"=>1663427720,
            "caption"=>caption,
         }
        end

        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
    end
  end

  if ENV['PARSE_PRICE_WITH_CATEGORIES']
    describe 'when prices and categories' do
      let(:message_params) do
        {
          "message_id"=>26318,
          "from"=>{"id"=>384435131, "is_bot"=>false, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>"nikolay_stepanets", "language_code"=>"en"},
          "chat"=>{"id"=>384435131, "first_name"=>"Nikolay", "last_name"=>"Stepanets", "username"=>"nikolay_stepanets", "type"=>"private"},
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
      let(:caption) { "Usd 15202" }
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

      before do
        allow(PricesFromImage).to receive(:call).and_return([collected_prices_with_categories, total_sum_in_receipt, file_id])
      end

      context 'when all categories present' do
        context 'when usd' do
          it 'calls PutExpensesToGoogleSheet, UpdateCommonCurrencyExpenses, SendNotificationMessageToBot' do
            allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_usd_money: 3100.0, coordinates_of_total_left_usd_money: "BC81"})

            expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 377000.0")

            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 / 15202,0")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 / 15202,0")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "К пиву", "=282500,0 / 15202,0")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 / 15202,0")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Сладости", "=16500,0 / 15202,0")

            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3099.0132877252995, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3097.5003289040915, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3081.41691882647, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3098.3554795421655, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3098.9146164978292, "BC81")

            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>15000.0,
                :price_in_usd=>0.9867122747006972,
                :price_in_usd_to_save_in_google_sheet=>"=15000,0 / 15202,0",
                :sub_category_name=>"Ванные принадлежности"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>38000.0,
                :price_in_usd=>2.499671095908433,
                :price_in_usd_to_save_in_google_sheet=>"=38000,0 / 15202,0",
                :sub_category_name=>"Новопочта"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>282500.0,
                :price_in_usd=>18.5830811735298,
                :price_in_usd_to_save_in_google_sheet=>"=282500,0 / 15202,0",
                :sub_category_name=>"К пиву"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>25000.0,
                :price_in_usd=>1.6445204578344954,
                :price_in_usd_to_save_in_google_sheet=>"=25000,0 / 15202,0",
                :sub_category_name=>"Ванные принадлежности"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>16500.0,
                :price_in_usd=>1.085383502170767,
                :price_in_usd_to_save_in_google_sheet=>"=16500,0 / 15202,0",
                :sub_category_name=>"Сладости"
              }
            )

            subject
          end
        end

        context 'when uah' do
          let(:caption) { "Uah 0.00242025" }

          it 'calls PutExpensesToGoogleSheet, UpdateCommonCurrencyExpenses, SendNotificationMessageToBot' do
            allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_uah_money: 3100.0, coordinates_of_total_left_uah_money: "BC81"})

            expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 377000.0")

            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 * 0,00242025 / 37,4406")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 * 0,00242025 / 37,4406")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "К пиву", "=282500,0 * 0,00242025 / 37,4406")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 * 0,00242025 / 37,4406")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Сладости", "=16500,0 * 0,00242025 / 37,4406")

            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3063.69625, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3008.0305, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(2416.279375, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3039.49375, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3060.065875, "BC81")

            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>15000.0,
                :price_in_uah=>36.30375,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=15000,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Ванные принадлежности"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>38000.0,
                :price_in_uah=>91.9695,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=38000,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Новопочта"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>282500.0,
                :price_in_uah=>683.720625,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=282500,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"К пиву"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>25000.0,
                :price_in_uah=>60.50625,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=25000,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Ванные принадлежности"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>16500.0,
                :price_in_uah=>39.934125,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=16500,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Сладости"
              }
            )

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
              {callback_data: "Транспорт: f_id:AQADuLwxG--FGEl-:282500.0", text: "Транспорт"},
              {callback_data: "Еда: f_id:AQADuLwxG--FGEl-:282500.0", text: "Еда"}
            ],
            [
              {callback_data: "Развлечения: f_id:AQADuLwxG--FGEl-:282500.0", text: "Развлечения"},
              {callback_data: "Подарки: f_id:AQADuLwxG--FGEl-:282500.0", text: "Подарки"}
            ],
            [
              {callback_data: "Для дома: f_id:AQADuLwxG--FGEl-:282500.0", text: "Для дома"},
              {callback_data: "Коля: f_id:AQADuLwxG--FGEl-:282500.0", text: "Коля"}
            ],
            [
              {callback_data: "Валди: f_id:AQADuLwxG--FGEl-:282500.0", text: "Валди"},
              {callback_data: "Непредвиденное: f_id:AQADuLwxG--FGEl-:282500.0", text: "Непредвиденное"}
            ],
            [
              {callback_data: "Марк: f_id:AQADuLwxG--FGEl-:282500.0", text: "Марк"},
              {callback_data: "Лиля: f_id:AQADuLwxG--FGEl-:282500.0", text: "Лиля"}
            ],
            [
              {callback_data: "Путешествия: f_id:AQADuLwxG--FGEl-:282500.0", text: "Путешествия"},
              {callback_data: "Инвестиции, фз: f_id:AQADuLwxG--FGEl-:282500.0", text: "Инвестиции, фз"}
            ],
            [
              {callback_data: "Авто бмоно: f_id:AQADuLwxG--FGEl-:282500.0", text: "Авто бмоно"},
              {callback_data: "Крупные покупки: f_id:AQADuLwxG--FGEl-:282500.0", text: "Крупные покупки"}
            ],
            [
              {callback_data: "Капитал: f_id:AQADuLwxG--FGEl-:282500.0", text: "Капитал"},
              {callback_data: "Кэш: f_id:AQADuLwxG--FGEl-:282500.0", text: "Кэш"}
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
              {callback_data: "Транспорт: f_id:AQADuLwxG--FGEl-:16500.0", text: "Транспорт"},
              {callback_data: "Еда: f_id:AQADuLwxG--FGEl-:16500.0", text: "Еда"}
            ],
            [
              {callback_data: "Развлечения: f_id:AQADuLwxG--FGEl-:16500.0", text: "Развлечения"},
              {callback_data: "Подарки: f_id:AQADuLwxG--FGEl-:16500.0", text: "Подарки"}
            ],
            [
              {callback_data: "Для дома: f_id:AQADuLwxG--FGEl-:16500.0", text: "Для дома"},
              {callback_data: "Коля: f_id:AQADuLwxG--FGEl-:16500.0", text: "Коля"}
            ],
            [
              {callback_data: "Валди: f_id:AQADuLwxG--FGEl-:16500.0", text: "Валди"},
              {callback_data: "Непредвиденное: f_id:AQADuLwxG--FGEl-:16500.0", text: "Непредвиденное"}
            ],
            [
              {callback_data: "Марк: f_id:AQADuLwxG--FGEl-:16500.0", text: "Марк"},
              {callback_data: "Лиля: f_id:AQADuLwxG--FGEl-:16500.0", text: "Лиля"}
            ],
            [
              {callback_data: "Путешествия: f_id:AQADuLwxG--FGEl-:16500.0", text: "Путешествия"},
              {callback_data: "Инвестиции, фз: f_id:AQADuLwxG--FGEl-:16500.0", text: "Инвестиции, фз"}
            ],
            [
              {callback_data: "Авто бмоно: f_id:AQADuLwxG--FGEl-:16500.0", text: "Авто бмоно"},
              {callback_data: "Крупные покупки: f_id:AQADuLwxG--FGEl-:16500.0", text: "Крупные покупки"}
            ],
            [
              {callback_data: "Капитал: f_id:AQADuLwxG--FGEl-:16500.0", text: "Капитал"},
              {callback_data: "Кэш: f_id:AQADuLwxG--FGEl-:16500.0", text: "Кэш"}
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
          it 'calls PutExpensesToGoogleSheet, UpdateCommonCurrencyExpenses, SendNotificationMessageToBot' do
            allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_usd_money: 3100.0, coordinates_of_total_left_usd_money: "BC81"})

            expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 377000.0")

            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 / 15202,0")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 / 15202,0")
            expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(282500.0, request_params_1).and_return(result1)
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 / 15202,0")
            expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(16500.0, request_params_2).and_return(result2)

            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3099.0132877252995, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3097.5003289040915, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3098.3554795421655, "BC81")

            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>15000.0,
                :price_in_usd=>0.9867122747006972,
                :price_in_usd_to_save_in_google_sheet=>"=15000,0 / 15202,0",
                :sub_category_name=>"Ванные принадлежности"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>38000.0,
                :price_in_usd=>2.499671095908433,
                :price_in_usd_to_save_in_google_sheet=>"=38000,0 / 15202,0",
                :sub_category_name=>"Новопочта"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>25000.0,
                :price_in_usd=>1.6445204578344954,
                :price_in_usd_to_save_in_google_sheet=>"=25000,0 / 15202,0",
                :sub_category_name=>"Ванные принадлежности"
              }
            )

            subject
          end
        end

        context 'when uah' do
          let(:caption) { "Uah 0.00242025" }

          it 'calls PutExpensesToGoogleSheet, UpdateCommonCurrencyExpenses, SendNotificationMessageToBot' do
            allow(CalculateTotalSpentUsdAndUah).to receive(:call).and_return({total_left_uah_money: 3100.0, coordinates_of_total_left_uah_money: "BC81"})

            expect_any_instance_of(described_class).to receive(:send_message).with("Общая цена в чеке: 377000.0")

            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=15000,0 * 0,00242025 / 37,4406")
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Еда", "Новопочта", "=38000,0 * 0,00242025 / 37,4406")
            expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(282500.0, request_params_1).and_return(result1)
            expect(PutExpensesToGoogleSheet).to receive(:call).with("Для дома", "Ванные принадлежности", "=25000,0 * 0,00242025 / 37,4406")
            expect_any_instance_of(described_class).to receive(:send_message_with_categories).with(16500.0, request_params_2).and_return(result2)

            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3063.69625, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3008.0305, "BC81")
            expect(UpdateCommonCurrencyExpenses).to receive(:call).with(3039.49375, "BC81")

            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>15000.0,
                :price_in_uah=>36.30375,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=15000,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Ванные принадлежности"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Еда",
                :operation_amount=>38000.0,
                :price_in_uah=>91.9695,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=38000,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Новопочта"
              }
            )
            expect(SendNotificationMessageToBot).to receive(:call).with(
              {
                :category_name=>"Для дома",
                :operation_amount=>25000.0,
                :price_in_uah=>60.50625,
                :price_in_uah_converted_to_usd_to_save_in_google_sheet=>"=25000,0 * 0,00242025 / 37,4406",
                :sub_category_name=>"Ванные принадлежности"
              }
            )

            subject
          end
        end
      end
    end
  end
end
