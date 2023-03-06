# !!! WARNING !!!
# prepare data in google sheet, because requests are making to prod !!!!
#
# USE big numbers so that it will be clear in google sheet it was test
#
# !!! WARNING !!!

require 'rails_helper'

RSpec.describe MonobankWebhooksController, type: :request, vcr: true, perform_enqueued: true do
  include ActiveJob::TestHelper

  let(:message_from) do
    {
      "from" => {
        "first_name" => "Nikolay",
        "id" => ENV['MY_TELEGRAM_ID'],
        "is_bot" => false,
        "language_code" => "en",
        "last_name" => "Stepanets",
        "username" => ENV['MY_USER_NAME']
      },
    }
  end
  let(:chat) do
    {
      "chat" => {
        "first_name" => "Nikolay",
        "id" => ENV['MY_TELEGRAM_ID'],
        "last_name" => "Stepanets",
        "type" => "private",
        "username" => ENV['MY_USER_NAME']
      },
    }
  end
  let(:reply_markup_choosing_category) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "Транспорт: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Транспорт"
            },
            {
              "callback_data" => "Еда: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Еда"
            }
          ],
          [
            {
              "callback_data" => "Развлечения: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Развлечения"
            },
            {
              "callback_data" => "Подарки: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Подарки"
            }
          ],
          [
            {
              "callback_data" => "Для дома: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Для дома"
            },
            {
              "callback_data" => "Коля: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Коля"
            }
          ],
          [
            {
              "callback_data" => "Валди: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Валди"
            },
            {
              "callback_data" => "Непредвиденное: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Непредвиденное"
            }
          ],
          [
            {
              "callback_data" => "Марк: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Марк"
            },
            {
              "callback_data" => "Лиля: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Лиля"
            }
          ],
          [
            {
              "callback_data" => "Путешествия: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Путешествия"
            },
            {
              "callback_data" => "Инвестиции, фз: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Инвестиции, фз"
            }
          ],
          [
            {
              "callback_data" => "Авто бмоно: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Авто бмоно"
            },
            {
              "callback_data" => "Крупные покупки: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Крупные покупки"
            }
          ],
          [
            {
              "callback_data" => "Капитал: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Капитал"
            },
            {
              "callback_data" => "Кэш: c_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Кэш"
            }
          ],
          [
            {
              "callback_data" => "remove_messages: tk6Ulh_sMFs9e_Zt",
              "text" => "Удалить сообщения этой транзакции"
            }
          ]
        ]
      }
    }
  end
  let(:reply_markup_choosing_category_half_expenses) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "Транспорт: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Транспорт"
            },
            {
              "callback_data" => "Еда: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Еда"
            }
          ],
          [
            {
              "callback_data" => "Развлечения: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Развлечения"
            },
            {
              "callback_data" => "Подарки: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Подарки"
            }
          ],
          [
            {
              "callback_data" => "Для дома: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Для дома"
            },
            {
              "callback_data" => "Коля: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Коля"
            }
          ],
          [
            {
              "callback_data" => "Валди: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Валди"
            },
            {
              "callback_data" => "Непредвиденное: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Непредвиденное"
            }
          ],
          [
            {
              "callback_data" => "Марк: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Марк"
            },
            {
              "callback_data" => "Лиля: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Лиля"
            }
          ],
          [
            {
              "callback_data" => "Путешествия: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Путешествия"
            },
            {
              "callback_data" => "Инвестиции, фз: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Инвестиции, фз"
            }
          ],
          [
            {
              "callback_data" => "Авто бмоно: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Авто бмоно"
            },
            {
              "callback_data" => "Крупные покупки: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Крупные покупки"
            }
          ],
          [
            {
              "callback_data" => "Капитал: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Капитал"
            },
            {
              "callback_data" => "Кэш: h_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Кэш"
            }
          ],
          [
            {
              "callback_data" => "remove_messages: tk6Ulh_sMFs9e_Zt",
              "text" => "Удалить сообщения этой транзакции"
            }
          ]
        ]
      }
    }
  end
  let(:reply_markup_choosing_subcategory) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "Такси: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Такси"
            },
            {
              "callback_data" => "Автобус: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Автобус"
            }
          ],
          [
            {
              "callback_data" => "Метро: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Метро"
            },
            {
              "callback_data" => "Другой: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Другой"
            }
          ],
          [
            {
              "callback_data" => "Поезд: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Поезд"
            },
            {
              "callback_data" => "Бензин: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Бензин"
            }
          ],
          [
            {
              "callback_data" => "Проездной: c1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Проездной"
            }
          ],
          [
            {
              "callback_data" => "categor_without_subcategor",
              "text" => "Без подкатегории"
            }
          ]
        ]
      },
    }
  end
  let(:telegram_bot_params_transport_category) do
    {
      "callback_query" => {
        "chat_instance" => ENV['CHAT_INSTANCE'],
        "data" => "Транспорт: c_id:tk6Ulh_sMFs9e_Zt",
        **message_from,
        "id" => "1651136315859693905",
        "message" => {
          **chat,
          "date" => 1670052388,
          "from" => {
            "first_name" => ENV['BOT_NAME'],
            "id" => ENV['BOT_ID'],
            "is_bot" => true,
            "username" => ENV['BOT_USER_NAME']
          },
          "message_id" => 35165,
          **reply_markup_choosing_category,
          "text" => "Выбери категорию:"
        }
      },
      "update_id" => 20479568
    }
  end
  let(:telegram_bot_params_taxi_subcategory) do
    {
      "callback_query" => {
        "chat_instance" => ENV['CHAT_INSTANCE'],
        "data" => "Такси: c1_id:tk6Ulh_sMFs9e_Zt",
        **message_from,
        "id" => "1651136316175924712",
        "message" => {
          **chat,
          "date" => 1670159797,
          "from" => {
            "first_name" => ENV['BOT_NAME'],
            "id" => ENV['BOT_ID'],
            "is_bot" => true,
            "username" => ENV['BOT_USER_NAME']
          },
          "message_id" => 37955,
          **reply_markup_choosing_subcategory,
          "text" => "Выбери подкатегорию:"
        }
      },
      "update_id" => 20479686
    }
  end

  context 'when uah expenses' do
    context 'when category present', freezed_time: '2023-01-22T06:03:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "C0Hfjf2vrc00CZ_1ZCjSLg",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "DigitalOcean",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 1000000,
                "operationAmount" => 1000000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'saves to google sheet' do
        # monobank webhook
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    context 'when category cash', freezed_time: '2023-02-01T03:00:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "C0Hfjf2vrc00CZ_1ZCjSLg",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "Банкомат BANK NEGARA IND",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => -244832,
                "operationAmount" => -100000000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'saves to google sheet, increase cash value' do
        # monobank webhook
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    context 'when category blank' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "C0Hfjf2vrc00CZ_1ZCjSLg",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "some unknown category",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 1000000,
                "operationAmount" => 1000000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      before do
        allow(DeleteMessagesJob).to receive(:perform_later)
      end

      it 'asks bot and saves to google sheet', freezed_time: '2023-03-07T01:07:00+00:00' do
        # monobank webhook
        post '/monobank_webhooks', params: monobank_webhook_params
        # choose category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # choose sub category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory

        expect(response.status).to eq(200)
      end
    end

    context 'when category withdraw cashback', freezed_time: '2023-02-26T12:56:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "C0Hfjf2vrc00CZ_1ZCjSLg",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "Виведення кешбеку 123",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => -244832,
                "operationAmount" => -100000000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'adds income to income page' do
        # monobank webhook
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end
  end

  context 'when usd expenses' do
    context 'when category present', freezed_time: '2023-03-07T01:04:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "DigitalOcean",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 100000,
                "operationAmount" => 100000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'saves to google sheet' do
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    # VPN is needed to make request to NBU
    context 'when swift salary', freezed_time: '2023-02-26T12:56:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "Some a lot DATA where SWIFT is main word",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 100000,
                "operationAmount" => 100000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'saves nbu currency rate, salary to month, increase usd' do
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    # VPN is needed to make request to NBU
    # No idea for now how to rerecord VCR correctly, because freeze time needs to be 20 of December
    # but google sheet api token should be valid now
    # Hope code works :)
    xcontext 'when swift salary goes to the next year', freezed_time: '2022-12-16T04:32:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "Some a lot DATA where SWIFT is main word",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 100000,
                "operationAmount" => 100000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'saves nbu currency rate, salary to month, increase usd' do
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    context 'when sold dollars to grivnas for taxes', freezed_time: '2023-01-22T07:10:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "На гривневий рахунок ФОП",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 100000,
                "operationAmount" => 100000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'decreases usd' do
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    context 'when sold dollars to grivnas', freezed_time: '2023-01-22T07:14:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "На гривневий рахунок ФОП для переказу на картку",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => -40928,
                "operationAmount" => -1500000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      it 'increases uah and decreases usd' do
        post '/monobank_webhooks', params: monobank_webhook_params
        expect(response.status).to eq(200)
      end
    end

    context 'when category blank', freezed_time: '2023-03-06T15:02:00+00:00' do
      let(:monobank_webhook_params) do
        {
          "monobank_webhook" => {
            "type" => "StatementItem",
            "data" => {
              "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
              "statementItem" => {
                "id" => "tk6Ulh_sMFs9e_Zt",
                "time" => 1661599923,
                "description" => "some unknown category",
                "mcc" => 4829,
                "originalMcc" => 4829,
                "amount" => 100000,
                "operationAmount" => 100000,
                "currencyCode" => 980,
                "commissionRate" => 0,
                "cashbackAmount" => 0,
                "balance" => 10000,
                "hold" => true,
                "receiptId" => "123-123-123-123"
              }
            }
          }
        }
      end

      before do
        allow(DeleteMessagesJob).to receive(:perform_later)
      end

      it 'asks bot and saves to google sheet' do
        # monobank webhook
        post '/monobank_webhooks', params: monobank_webhook_params
        # choose category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # choose sub category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory

        expect(response.status).to eq(200)
      end
    end
  end
end
