# !!! WARNING !!!
# prepare data in google sheet, because requests are making to prod !!!!
#
# USE big numbers so that it will be clear in google sheet it was test
#
# !!! WARNING !!!

require 'rails_helper'

RSpec.describe MonzoWebhooksController, type: :request, vcr: true, perform_enqueued: true do
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
              "callback_data" => "Транспорт: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Транспорт"
            },
            {
              "callback_data" => "Еда: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Еда"
            }
          ],
          [
            {
              "callback_data" => "Развлечения: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Развлечения"
            },
            {
              "callback_data" => "Подарки: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Подарки"
            }
          ],
          [
            {
              "callback_data" => "Для дома: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Для дома"
            },
            {
              "callback_data" => "Коля: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Коля"
            }
          ],
          [
            {
              "callback_data" => "Валди: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Валди"
            },
            {
              "callback_data" => "Непредвиденное: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Непредвиденное"
            }
          ],
          [
            {
              "callback_data" => "Марк: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Марк"
            },
            {
              "callback_data" => "Лиля: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Лиля"
            }
          ],
          [
            {
              "callback_data" => "Путешествия: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Путешествия"
            },
            {
              "callback_data" => "Инвестиции, фз: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Инвестиции, фз"
            }
          ],
          [
            {
              "callback_data" => "Авто бмоно: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Авто бмоно"
            },
            {
              "callback_data" => "Крупные покупки: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Крупные покупки"
            }
          ],
          [
            {
              "callback_data" => "Капитал: m_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Капитал"
            },
            {
              "callback_data" => "Кэш: m_id:tk6Ulh_sMFs9e_Zt",
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
              "callback_data" => "Такси: m1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Такси"
            },
            {
              "callback_data" => "Автобус: m1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Автобус"
            }
          ],
          [
            {
              "callback_data" => "Метро: m1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Метро"
            },
            {
              "callback_data" => "Другой: m1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Другой"
            }
          ],
          [
            {
              "callback_data" => "Поезд: m1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Поезд"
            },
            {
              "callback_data" => "Бензин: m1_id:tk6Ulh_sMFs9e_Zt",
              "text" => "Бензин"
            }
          ],
          [
            {
              "callback_data" => "Проездной: m1_id:tk6Ulh_sMFs9e_Zt",
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
        "data" => "Транспорт:m_id:#{tranfer_id}",
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
        "data" => "Такси: m1_id:#{tranfer_id}",
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
  let(:monzo_webhook_params) do
    {
      "monzo_webhook": {
        "type": "transaction.created",
        "data": {
          "id": "tx_0000Aj4wfo7ftSnTPwjWqI",
          "created": "2024-06-19T07:43:37.147Z",
          "description": "pot",
          "amount": -1480,
          "fees": {},
          "currency": "GBP",
          "merchant": nil,
          "notes": "",
          "labels": nil,
          "attachments": nil,
          "international": nil,
          "category": "savings",
          "is_load": false,
          "settled": "2024-06-19T07:43:37.147Z",
          "local_amount": -1480,
          "local_currency": "GBP",
          "account_id": ENV['MONZO_ACCOUNT_ID'],
          "updated": "2024-06-19T07:43:37.501Z",
          "user_id": "",
          "counterparty": {},
          "scheme": "uk_retail_pot",
          "originator": true,
          "include_in_spending": false,
          "can_be_excluded_from_breakdown": false,
          "can_be_made_subscription": false,
          "can_split_the_bill": false,
          "can_add_to_tab": false,
          "can_match_transactions_in_categorization": false,
          "amount_is_pending": false,
          "atm_fees_detailed": nil,
          "parent_account_id": ""
        }
      }
    }
  end

  before do
    allow(DeleteMessagesJob).to receive(:perform_later)
  end

  context 'when unknown category', freezed_time: '2024-06-29T20:03:00+00:00' do
    let(:tranfer_id) { "a43d1" }

    it 'asks bot and saves to google sheet' do
      post '/monzo_webhooks', params: monzo_webhook_params
      post '/monzo_webhooks', params: monzo_webhook_params

      # simulate call from schedule
      HandleMonzoTransactionsSchedule.call

      # choose category
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
      # choose sub category
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory

      expect(response.status).to eq(200)
    end

    context 'when joint account', freezed_time: '2024-06-29T20:11:00+00:00' do
      let(:tranfer_id) { "a43d1" }
      let(:monzo_webhook_params) do
        {
          "monzo_webhook": {
            "type": "transaction.created",
            "data": {
              "id": "tx_0000Aj4wfo7ftSnTPwjWqI",
              "created": "2024-06-19T07:43:37.147Z",
              "description": "pot",
              "amount": -1480,
              "fees": {},
              "currency": "GBP",
              "merchant": nil,
              "notes": "",
              "labels": nil,
              "attachments": nil,
              "international": nil,
              "category": "savings",
              "is_load": false,
              "settled": "2024-06-19T07:43:37.147Z",
              "local_amount": -1480,
              "local_currency": "GBP",
              "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
              "updated": "2024-06-19T07:43:37.501Z",
              "user_id": "",
              "counterparty": {},
              "scheme": "uk_retail_pot",
              "originator": true,
              "include_in_spending": false,
              "can_be_excluded_from_breakdown": false,
              "can_be_made_subscription": false,
              "can_split_the_bill": false,
              "can_add_to_tab": false,
              "can_match_transactions_in_categorization": false,
              "amount_is_pending": false,
              "atm_fees_detailed": nil,
              "parent_account_id": ""
            }
          }
        }
      end
      let(:reply_markup_choosing_category) do
        {
          "reply_markup" => {
            "inline_keyboard" => [
              [
                {
                  "callback_data" => "Транспорт: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Транспорт"
                },
                {
                  "callback_data" => "Еда: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Еда"
                }
              ],
              [
                {
                  "callback_data" => "Развлечения: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Развлечения"
                },
                {
                  "callback_data" => "Подарки: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Подарки"
                }
              ],
              [
                {
                  "callback_data" => "Для дома: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Для дома"
                },
                {
                  "callback_data" => "Коля: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Коля"
                }
              ],
              [
                {
                  "callback_data" => "Валди: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Валди"
                },
                {
                  "callback_data" => "Непредвиденное: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Непредвиденное"
                }
              ],
              [
                {
                  "callback_data" => "Марк: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Марк"
                },
                {
                  "callback_data" => "Лиля: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Лиля"
                }
              ],
              [
                {
                  "callback_data" => "Путешествия: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Путешествия"
                },
                {
                  "callback_data" => "Инвестиции, фз: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Инвестиции, фз"
                }
              ],
              [
                {
                  "callback_data" => "Авто бмоно: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Авто бмоно"
                },
                {
                  "callback_data" => "Крупные покупки: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Крупные покупки"
                }
              ],
              [
                {
                  "callback_data" => "Капитал: mj_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Капитал"
                },
                {
                  "callback_data" => "Кэш: mj_id:tk6Ulh_sMFs9e_Zt",
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
                  "callback_data" => "Такси: mj1_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Такси"
                },
                {
                  "callback_data" => "Автобус: mj1_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Автобус"
                }
              ],
              [
                {
                  "callback_data" => "Метро: mj1_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Метро"
                },
                {
                  "callback_data" => "Другой: mj1_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Другой"
                }
              ],
              [
                {
                  "callback_data" => "Поезд: mj1_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Поезд"
                },
                {
                  "callback_data" => "Бензин: mj1_id:tk6Ulh_sMFs9e_Zt",
                  "text" => "Бензин"
                }
              ],
              [
                {
                  "callback_data" => "Проездной: mj1_id:tk6Ulh_sMFs9e_Zt",
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
            "data" => "Транспорт:mj_id:#{tranfer_id}",
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
            "data" => "Такси: mj1_id:#{tranfer_id}",
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

      it 'asks bot and saves to google sheet' do
        post '/monzo_webhooks', params: monzo_webhook_params
        post '/monzo_webhooks', params: monzo_webhook_params

        # simulate call from schedule
        HandleMonzoTransactionsSchedule.call

        # choose category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # choose sub category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory

        expect(response.status).to eq(200)
      end
    end
  end
end
