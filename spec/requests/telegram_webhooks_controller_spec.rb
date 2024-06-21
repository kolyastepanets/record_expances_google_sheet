# !!! WARNING !!!
# prepare data in google sheet, because requests are making to prod !!!!
#
# USE big numbers so that it will be clear in google sheet it was test
#
# !!! WARNING !!!

require 'rails_helper'

RSpec.describe TelegramWebhooksController, type: :request, vcr: true, perform_enqueued: true do
  include ActiveJob::TestHelper

  before do
    allow(Telegram.bot).to receive(:delete_message)
  end

  let(:reply_markup_all_info) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "get_current_mono_balance_from_google_sheet",
              "text" => "UAH на gsheets"
            }
          ],
          [
            {
              "callback_data" => "get_current_mono_balance_from_monobank",
              "text" => "UAH на monobank"
            }
          ],
          [
            {
              "callback_data" => "get_usd_fop_from_google_sheet",
              "text" => "USD FOP на gsheets"
            }
          ],
          [
            {
              "callback_data" => "get_usd_fop_from_monobank",
              "text" => "USD FOP на monobank"
            }
          ],
          [
            {
              "callback_data" => "amount_already_spent",
              "text" => "Уже потрачено"
            }
          ],
          [
            {
              "callback_data" => "total_saved_money_from_google_sheet",
              "text" => "Total saved money on gsheets"
            }
          ],
          [
            {
              "callback_data" => "get_last_3_expenses_in_google_sheet",
              "text" => "Последние 3 траты в gsheets"
            }
          ],
          [
            {
              "callback_data" => "get_last_10_transactions_from_mono",
              "text" => "Последние 10 транзакций в моно"
            }
          ],
          [
            {
              "callback_data" => "delete_all_todays_messages",
              "text" => "Удалить все текущие сообщения"
            }
          ],
          [
            {
              "callback_data" => "expenses_to_return_from_vika",
              "text" => "Кто кому сколько должен"
            }
          ],
          [
            {
              "callback_data" => "enter_expenses",
              "text" => "Внести расходы"
            }
          ],
          [
            {
              "callback_data" => "start_again",
              "text" => "Главное меню"
            }
          ]
        ]
      },
    }
  end
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
  let(:reply_markup_choosing_type_of_expenses) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "metro_expenses",
              "text" => "Покупки с метро"
            }
          ],
          [
            {
              "callback_data" => "common_expenses",
              "text" => "Обычные покупки"
            }
          ],
          [
            {
              "callback_data" => "receipt_foreign_currency",
              "text" => "Чек иностранная валюта"
            }
          ],
          [
            {
              "callback_data" => "cash_foreign_currency",
              "text" => "Наличка иностранная валюта"
            }
          ],
          [
            {
              "callback_data" => "dollar_card",
              "text" => "Долларовая карта"
            }
          ],
          [
            {
              "callback_data" => "start_again",
              "text" => "Главное меню"
            }
          ]
        ]
      },
    }
  end
  let(:reply_markup_choosing_category) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "Транспорт: only_category",
              "text" => "Транспорт"
            },
            {
              "callback_data" => "Еда: only_category",
              "text" => "Еда"
            }
          ],
          [
            {
              "callback_data" => "Развлечения: only_category",
              "text" => "Развлечения"
            },
            {
              "callback_data" => "Подарки: only_category",
              "text" => "Подарки"
            }
          ],
          [
            {
              "callback_data" => "Для дома: only_category",
              "text" => "Для дома"
            },
            {
              "callback_data" => "Коля: only_category",
              "text" => "Коля"
            }
          ],
          [
            {
              "callback_data" => "Валди: only_category",
              "text" => "Валди"
            },
            {
              "callback_data" => "Непредвиденное: only_category",
              "text" => "Непредвиденное"
            }
          ],
          [
            {
              "callback_data" => "Марк: only_category",
              "text" => "Марк"
            },
            {
              "callback_data" => "Лиля: only_category",
              "text" => "Лиля"
            }
          ],
          [
            {
              "callback_data" => "Путешествия: only_category",
              "text" => "Путешествия"
            },
            {
              "callback_data" => "Инвестиции, фз: only_category",
              "text" => "Инвестиции, фз"
            }
          ],
          [
            {
              "callback_data" => "Авто бмоно: only_category",
              "text" => "Авто бмоно"
            },
            {
              "callback_data" => "Крупные покупки: only_category",
              "text" => "Крупные покупки"
            }
          ],
          [
            {
              "callback_data" => "Капитал: only_category",
              "text" => "Капитал"
            },
            {
              "callback_data" => "Кэш: only_category",
              "text" => "Кэш"
            }
          ],
          [
            {
              "callback_data" => "finish_remember_total_price_of_products",
              "text" => "Зак..ть внесение продуктов. Н.ть заново"
            }
          ],
          [
            {
              "callback_data" => "start_again",
              "text" => "Главное меню"
            }
          ]
        ]
      },
    }
  end
  let(:reply_markup_choosing_subcategory) do
    {
      "reply_markup" => {
        "inline_keyboard" => [
          [
            {
              "callback_data" => "Такси",
              "text" => "Такси"
            },
            {
              "callback_data" => "Автобус",
              "text" => "Автобус"
            }
          ],
          [
            {
              "callback_data" => "Метро",
              "text" => "Метро"
            },
            {
              "callback_data" => "Другой",
              "text" => "Другой"
            }
          ],
          [
            {
              "callback_data" => "Поезд",
              "text" => "Поезд"
            },
            {
              "callback_data" => "Бензин",
              "text" => "Бензин"
            }
          ],
          [
            {
              "callback_data" => "Проездной",
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

  context 'when metro expenses', freezed_time: '2023-01-22T07:37:00+00:00' do
    context 'when all our metro expenses 2 times' do
      let(:telegram_bot_params_enter_expenses) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "Внести расходы"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_metro_expenses) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "metro_expenses",
                **message_from,
                "id" => "1651136317356629958",
                "message" => {
                    **chat,
                    "date" => 1670052288,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35163,
                    **reply_markup_choosing_type_of_expenses,
                    "text" => "как заполнять?"
                }
            },
            "update_id" => 20479567
        }
      end
      let(:telegram_bot_params_transport_category) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
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
                "data" => "Такси",
                **message_from,
                "id" => "1651136315537290214",
                "message" => {
                    **chat,
                    "date" => 1670052463,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35166,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479569
        }
      end
      let(:telegram_bot_params_taxi_price) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "10000"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_transport_category_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
                **message_from,
                "id" => "1651136318620605451",
                "message" => {
                    **chat,
                    "date" => 1670071810,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35887,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479614
        }
      end
      let(:telegram_bot_params_taxi_subcategory_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Такси",
                **message_from,
                "id" => "1651136315526205282",
                "message" => {
                    **chat,
                    "date" => 1670071818,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35888,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479615
        }
      end
      let(:telegram_bot_params_taxi_price_2) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670072000,
                **message_from,
                "message_id" => 35891,
                "text" => "10000"
            },
            "update_id" => 20479616
        }
      end
      let(:telegram_bot_params_finish_enter_prices) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "finish_remember_total_price_of_products",
                **message_from,
                "id" => "1651136318658776636",
                "message" => {
                    **chat,
                    "date" => 1670072001,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35895,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479617
        }
      end

      it 'saves data to every day expenses page 2 times and decreases uah value' do
        # enter expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_expenses
        # common expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_metro_expenses
        # transport category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when common expenses' do
    context 'when all our expenses 2 times', freezed_time: '2023-01-22T07:46:00+00:00' do
      let(:telegram_bot_params_enter_expenses) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "Внести расходы"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_common_expenses) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "common_expenses",
                **message_from,
                "id" => "1651136317356629958",
                "message" => {
                    **chat,
                    "date" => 1670052288,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35163,
                    **reply_markup_choosing_type_of_expenses,
                    "text" => "как заполнять?"
                }
            },
            "update_id" => 20479567
        }
      end
      let(:telegram_bot_params_transport_category) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
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
                "data" => "Такси",
                **message_from,
                "id" => "1651136315537290214",
                "message" => {
                    **chat,
                    "date" => 1670052463,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35166,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479569
        }
      end
      let(:telegram_bot_params_taxi_price) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "10000"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_transport_category_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
                **message_from,
                "id" => "1651136318620605451",
                "message" => {
                    **chat,
                    "date" => 1670071810,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35887,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479614
        }
      end
      let(:telegram_bot_params_taxi_subcategory_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Такси",
                **message_from,
                "id" => "1651136315526205282",
                "message" => {
                    **chat,
                    "date" => 1670071818,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35888,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479615
        }
      end
      let(:telegram_bot_params_taxi_price_2) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670072000,
                **message_from,
                "message_id" => 35891,
                "text" => "10000"
            },
            "update_id" => 20479616
        }
      end
      let(:telegram_bot_params_finish_enter_prices) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "finish_remember_total_price_of_products",
                **message_from,
                "id" => "1651136318658776636",
                "message" => {
                    **chat,
                    "date" => 1670072001,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35895,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479617
        }
      end

      it 'saves data to every day expenses page 2 times and decreases uah value' do
        # enter expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_expenses
        # common expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_common_expenses
        # transport category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when uah in foreign currency expenses' do
    context 'when all our receipt foreigh currency expenses 2 times', freezed_time: '2024-05-13T18:55:00+00:00' do
      let(:telegram_bot_params_enter_expenses) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "Внести расходы"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_receipt_foreign_currency_expenses) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "receipt_foreign_currency",
                **message_from,
                "id" => "1651136317356629958",
                "message" => {
                    **chat,
                    "date" => 1670052288,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35163,
                    **reply_markup_choosing_type_of_expenses,
                    "text" => "как заполнять?"
                }
            },
            "update_id" => 20479567
        }
      end
      let(:telegram_bot_params_enter_uah_foreign_currency_rate) do
        {
          "message" => {
            "chat" => {
                "first_name" => "Nikolay",
                "id" => ENV['MY_TELEGRAM_ID'],
                "last_name" => "Stepanets",
                "type" => "private",
                "username" => ENV['MY_USER_NAME']
            },
            "date" => 1670120327,
            **message_from,
            "message_id" => 36679,
            "text" => "0.0024"
          },
          "update_id" => 20479668
        }
      end
      let(:telegram_bot_params_transport_category) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
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
                "data" => "Такси",
                **message_from,
                "id" => "1651136315537290214",
                "message" => {
                    **chat,
                    "date" => 1670052463,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35166,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479569
        }
      end
      let(:telegram_bot_params_taxi_price) do
        {
          "message" => {
            "chat" => {
                "first_name" => "Nikolay",
                "id" => ENV['MY_TELEGRAM_ID'],
                "last_name" => "Stepanets",
                "type" => "private",
                "username" => ENV['MY_USER_NAME']
            },
            "date" => 1670052690,
            **message_from,
            "message_id" => 35169,
            "text" => "100000"
          },
          "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_transport_category_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
                **message_from,
                "id" => "1651136318620605451",
                "message" => {
                    **chat,
                    "date" => 1670071810,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35887,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479614
        }
      end
      let(:telegram_bot_params_taxi_subcategory_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Такси",
                **message_from,
                "id" => "1651136315526205282",
                "message" => {
                    **chat,
                    "date" => 1670071818,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35888,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479615
        }
      end
      let(:telegram_bot_params_taxi_price_2) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670072000,
                **message_from,
                "message_id" => 35891,
                "text" => "100000"
            },
            "update_id" => 20479616
        }
      end
      let(:telegram_bot_params_finish_enter_prices) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "finish_remember_total_price_of_products",
                **message_from,
                "id" => "1651136318658776636",
                "message" => {
                    **chat,
                    "date" => 1670072001,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35895,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479617
        }
      end

      it 'saves data to every day expenses page 2 times and decreases uah value' do
        # enter expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_expenses
        # receipt foreigh currency expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_receipt_foreign_currency_expenses
        # enter currency rate
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_uah_foreign_currency_rate
        # transport category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when dollar card' do
    context 'when all our expenses 2 times', freezed_time: '2024-06-22T15:09:00+00:00' do
      let(:telegram_bot_params_enter_expenses) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "Внести расходы"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_dollar_card) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "dollar_card",
                **message_from,
                "id" => "1651136317356629958",
                "message" => {
                    **chat,
                    "date" => 1670052288,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35163,
                    **reply_markup_choosing_type_of_expenses,
                    "text" => "как заполнять?"
                }
            },
            "update_id" => 20479567
        }
      end
      let(:telegram_bot_params_dollar_currency_rate) do
        {
          "message" => {
            "chat" => {
                "first_name" => "Nikolay",
                "id" => ENV['MY_TELEGRAM_ID'],
                "last_name" => "Stepanets",
                "type" => "private",
                "username" => ENV['MY_USER_NAME']
            },
            "date" => 1670120327,
            **message_from,
            "message_id" => 36679,
            "text" => "15640.25"
          },
          "update_id" => 20479668
        }
      end
      let(:telegram_bot_params_transport_category) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
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
                "data" => "Такси",
                **message_from,
                "id" => "1651136315537290214",
                "message" => {
                    **chat,
                    "date" => 1670052463,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35166,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479569
        }
      end
      let(:telegram_bot_params_taxi_price) do
        {
          "message" => {
            "chat" => {
                "first_name" => "Nikolay",
                "id" => ENV['MY_TELEGRAM_ID'],
                "last_name" => "Stepanets",
                "type" => "private",
                "username" => ENV['MY_USER_NAME']
            },
            "date" => 1670052690,
            **message_from,
            "message_id" => 35169,
            "text" => "1000000"
          },
          "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_transport_category_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
                **message_from,
                "id" => "1651136318620605451",
                "message" => {
                    **chat,
                    "date" => 1670071810,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35887,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479614
        }
      end
      let(:telegram_bot_params_taxi_subcategory_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Такси",
                **message_from,
                "id" => "1651136315526205282",
                "message" => {
                    **chat,
                    "date" => 1670071818,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35888,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479615
        }
      end
      let(:telegram_bot_params_taxi_price_2) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670072000,
                **message_from,
                "message_id" => 35891,
                "text" => "1000000"
            },
            "update_id" => 20479616
        }
      end
      let(:telegram_bot_params_finish_enter_prices) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "finish_remember_total_price_of_products",
                **message_from,
                "id" => "1651136318658776636",
                "message" => {
                    **chat,
                    "date" => 1670072001,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35895,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479617
        }
      end

      it 'saves data to every day expenses page 2 times and decreases dollar value' do
        # enter expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_expenses
        # dollar card
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_dollar_card
        # dollar currency rate
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_dollar_currency_rate
        # transport category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when wise expenses' do
    context 'when all our expenses 2 times', freezed_time: '2023-03-07T09:09:00+00:00' do
      let(:telegram_bot_params_enter_expenses) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "Внести расходы"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_wise_expenses) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "wise",
                **message_from,
                "id" => "1651136317356629958",
                "message" => {
                    **chat,
                    "date" => 1670052288,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35163,
                    **reply_markup_choosing_type_of_expenses,
                    "text" => "как заполнять?"
                }
            },
            "update_id" => 20479567
        }
      end
      let(:telegram_bot_params_transport_category) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
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
                "data" => "Такси",
                **message_from,
                "id" => "1651136315537290214",
                "message" => {
                    **chat,
                    "date" => 1670052463,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35166,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479569
        }
      end
      let(:telegram_bot_params_taxi_price) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670052690,
                **message_from,
                "message_id" => 35169,
                "text" => "1000000"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_transport_category_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Транспорт: only_category",
                **message_from,
                "id" => "1651136318620605451",
                "message" => {
                    **chat,
                    "date" => 1670071810,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35887,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479614
        }
      end
      let(:telegram_bot_params_taxi_subcategory_2) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "Такси",
                **message_from,
                "id" => "1651136315526205282",
                "message" => {
                    **chat,
                    "date" => 1670071818,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35888,
                    **reply_markup_choosing_subcategory,
                    "text" => "Выбери подкатегорию:"
                }
            },
            "update_id" => 20479615
        }
      end
      let(:telegram_bot_params_taxi_price_2) do
        {
            "message" => {
                "chat" => {
                    "first_name" => "Nikolay",
                    "id" => ENV['MY_TELEGRAM_ID'],
                    "last_name" => "Stepanets",
                    "type" => "private",
                    "username" => ENV['MY_USER_NAME']
                },
                "date" => 1670072000,
                **message_from,
                "message_id" => 35891,
                "text" => "1000000"
            },
            "update_id" => 20479616
        }
      end
      let(:telegram_bot_params_finish_enter_prices) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "finish_remember_total_price_of_products",
                **message_from,
                "id" => "1651136318658776636",
                "message" => {
                    **chat,
                    "date" => 1670072001,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35895,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479617
        }
      end

      it 'saves data to every day expenses page 2 times and decreases uah value' do
        # enter expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_expenses
        # common expenses
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_wise_expenses
        # transport category
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when wise salary', freezed_time: '2023-02-26T12:57:00+00:00', perform_enqueued: true do
    let(:telegram_bot_params_main_menu) do
      {
          "callback_query" => {
              "chat_instance" => ENV['CHAT_INSTANCE'],
              "data" => "start_again",
              **message_from,
              "id" => "1651136317895074902",
              "message" => {
                  **chat,
                  "date" => 1670051818,
                  "from" => {
                      "first_name" => ENV['BOT_NAME'],
                      "id" => ENV['BOT_ID'],
                      "is_bot" => true,
                      "username" => ENV['BOT_USER_NAME']
                  },
                  "message_id" => 35159,
                  **reply_markup_all_info,
                  "text" => "Выбери действие:"
              }
          },
          "update_id" => 20479563
      }
    end
    let(:telegram_bot_params_enter_wise_salary) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670051828,
              **message_from,
              "message_id" => 35160,
              "text" => "Enter wise salary"
          },
          "update_id" => 20479564
      }
    end
    let(:telegram_bot_params_wise_salary) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670052690,
              **message_from,
              "message_id" => 35169,
              "text" => "1000000"
          },
          "update_id" => 20479570
      }
    end

    it 'saves wise salary to page total savings' do
      # main menu
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_main_menu
      # choose wise salary
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_wise_salary
      # enter salary
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_wise_salary

      expect(response.status).to eq(200)
    end
  end

  context 'when enter cash', freezed_time: '2024-06-20T20:50:00+00:00', perform_enqueued: true do
    let(:telegram_bot_params_main_menu) do
      {
          "callback_query" => {
              "chat_instance" => ENV['CHAT_INSTANCE'],
              "data" => "start_again",
              **message_from,
              "id" => "1651136317895074902",
              "message" => {
                  **chat,
                  "date" => 1670051818,
                  "from" => {
                      "first_name" => ENV['BOT_NAME'],
                      "id" => ENV['BOT_ID'],
                      "is_bot" => true,
                      "username" => ENV['BOT_USER_NAME']
                  },
                  "message_id" => 35159,
                  **reply_markup_all_info,
                  "text" => "Выбери действие:"
              }
          },
          "update_id" => 20479563
      }
    end
    let(:telegram_bot_params_choose_to_enter_cash) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670051828,
              **message_from,
              "message_id" => 35160,
              "text" => "Enter cash"
          },
          "update_id" => 20479564
      }
    end
    let(:telegram_bot_params_enter_uah_and_cash) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670052690,
              **message_from,
              "message_id" => 35169,
              "text" => "2635.45 1000000"
          },
          "update_id" => 20479570
      }
    end

    it 'saves cash, decrease uah' do
      # main menu
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_main_menu
      # choose wise salary
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_to_enter_cash
      # enter salary
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_uah_and_cash

      expect(response.status).to eq(200)
    end
  end

  context 'when wise lend money', freezed_time: '2023-01-28T08:40:00+00:00', perform_enqueued: true do
    let(:telegram_bot_params_main_menu) do
      {
          "callback_query" => {
              "chat_instance" => ENV['CHAT_INSTANCE'],
              "data" => "start_again",
              **message_from,
              "id" => "1651136317895074902",
              "message" => {
                  **chat,
                  "date" => 1670051818,
                  "from" => {
                      "first_name" => ENV['BOT_NAME'],
                      "id" => ENV['BOT_ID'],
                      "is_bot" => true,
                      "username" => ENV['BOT_USER_NAME']
                  },
                  "message_id" => 35159,
                  **reply_markup_all_info,
                  "text" => "Выбери действие:"
              }
          },
          "update_id" => 20479563
      }
    end
    let(:telegram_bot_params_enter_expenses) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670051828,
              **message_from,
              "message_id" => 35160,
              "text" => "Внести расходы"
          },
          "update_id" => 20479564
      }
    end
    let(:telegram_bot_params_our_all_expenses) do
      {
          "callback_query" => {
              "chat_instance" => ENV['CHAT_INSTANCE'],
              "data" => "calculate_as_our_full_expenses",
              **message_from,
              "id" => "1651136318113433528",
              "message" => {
                  **chat,
                  "date" => 1670052068,
                  "from" => {
                      "first_name" => ENV['BOT_NAME'],
                      "id" => ENV['BOT_ID'],
                      "is_bot" => true,
                      "username" => ENV['BOT_USER_NAME']
                  },
                  "message_id" => 35161,
                  "reply_markup" => {
                      "inline_keyboard" => [
                          [
                              {
                                  "callback_data" => "calculate_as_our_full_expenses",
                                  "text" => "Все расходы наши"
                              }
                          ],
                          [
                              {
                                  "callback_data" => "calculate_as_mykola_paid_half_expenses",
                                  "text" => "Микола заплатил (половина)"
                              }
                          ],
                          [
                              {
                                  "callback_data" => "calculate_as_vika_paid_half_expenses",
                                  "text" => "Вика заплатила (половина)"
                              }
                          ]
                      ]
                  },
                  "text" => "как считать расходы?"
              }
          },
          "update_id" => 20479566
      }
    end
    let(:telegram_bot_params_wise_lend_money) do
      {
          "callback_query" => {
              "chat_instance" => ENV['CHAT_INSTANCE'],
              "data" => "wise_lend_money",
              **message_from,
              "id" => "1651136317356629958",
              "message" => {
                  **chat,
                  "date" => 1670052288,
                  "from" => {
                      "first_name" => ENV['BOT_NAME'],
                      "id" => ENV['BOT_ID'],
                      "is_bot" => true,
                      "username" => ENV['BOT_USER_NAME']
                  },
                  "message_id" => 35163,
                  **reply_markup_choosing_type_of_expenses,
                  "text" => "как заполнять?"
              }
          },
          "update_id" => 20479567
      }
    end
    let(:telegram_bot_params_wise_lend_amount) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670052690,
              **message_from,
              "message_id" => 35169,
              "text" => "1000000"
          },
          "update_id" => 20479570
      }
    end

    it 'withdraws money from wise amount' do
      # main menu
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_main_menu
      # enter expenses
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_enter_expenses
      # all our expenses
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_our_all_expenses
      # choose to lend money
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_wise_lend_money
      # enter amount to lend
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_wise_lend_amount

      expect(response.status).to eq(200)
    end
  end

  context 'when parse photo', vcr: { match_requests_on: [:method, :body, :telegram_get_file_custom_matcher] } do
    # 1 product is not parsed in photo: spec/images/not_parsed_one_fake_product_1
    # to test - upload file, check logs, copy file_id, paste it to telegram_bot_params_upload_photo
    let(:caption) { "uah 0.0024" }
    let(:telegram_bot_params_upload_photo) do
      {
        "message" => {
            "caption" => caption,
            "chat" => {
              "first_name" => "Nikolay",
              "id" => ENV['MY_TELEGRAM_ID'],
              "last_name" => "Stepanets",
              "type" => "private",
              "username" => ENV['MY_USER_NAME']
            },
            "date" => 1672649172,
            **message_from,
            "message_id" => 51490,
            "photo" => [
              {
                "file_id": "AgACAgIAAxkBAAKKDmWGt-G2y7VxbmnrjZ9_TzLpsHG_AAIT2TEbCI8wSMrX5i6m4BqJAQADAgADcwADMwQ",
                "file_unique_id": "AQADE9kxGwiPMEh4",
                "file_size": 1258,
                "width": 67,
                "height": 90
              },
              {
                "file_id": "AgACAgIAAxkBAAKKDmWGt-G2y7VxbmnrjZ9_TzLpsHG_AAIT2TEbCI8wSMrX5i6m4BqJAQADAgADbQADMwQ",
                "file_unique_id": "AQADE9kxGwiPMEhy",
                "file_size": 18960,
                "width": 240,
                "height": 320
              },
              {
                "file_id": "AgACAgIAAxkBAAKKDmWGt-G2y7VxbmnrjZ9_TzLpsHG_AAIT2TEbCI8wSMrX5i6m4BqJAQADAgADeAADMwQ",
                "file_unique_id": "AQADE9kxGwiPMEh9",
                "file_size": 91755,
                "width": 600,
                "height": 800
              },
              {
                "file_id": "AgACAgIAAxkBAAKKDmWGt-G2y7VxbmnrjZ9_TzLpsHG_AAIT2TEbCI8wSMrX5i6m4BqJAQADAgADeQADMwQ",
                "file_unique_id": "AQADE9kxGwiPMEh-",
                "file_size": 138829,
                "width": 960,
                "height": 1280
              }
            ]
        },
        "update_id" => 20680800
      }
    end
    let(:telegram_bot_params_choose_category) do
      {
        "callback_query" => {
            "chat_instance" => ENV['CHAT_INSTANCE'],
            "data" => "Еда: f_id:AQADE9kxGwiPMEh-:28500.0",
            **message_from,
            "id" => "1651136316635507601",
            "message" => {
                **chat,
                "date" => 1672650172,
                "from" => {
                    "first_name" => ENV['BOT_NAME'],
                    "id" => ENV['BOT_ID'],
                    "is_bot" => true,
                    "username" => ENV['BOT_USER_NAME']
                },
                "message_id" => 51491,
                "reply_markup" => {
                    "inline_keyboard" => [
                        [
                            {
                                "callback_data" => "Транспорт: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Транспорт"
                            },
                            {
                                "callback_data" => "Еда: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Еда"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Развлечения: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Развлечения"
                            },
                            {
                                "callback_data" => "Подарки: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Подарки"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Для дома: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Для дома"
                            },
                            {
                                "callback_data" => "Коля: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Коля"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Валди: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Валди"
                            },
                            {
                                "callback_data" => "Непредвиденное: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Непредвиденное"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Марк: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Марк"
                            },
                            {
                                "callback_data" => "Лиля: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Лиля"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Путешествия: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Путешествия"
                            },
                            {
                                "callback_data" => "Инвестиции, фз: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Инвестиции, фз"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Авто бмоно: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Авто бмоно"
                            },
                            {
                                "callback_data" => "Крупные покупки: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Крупные покупки"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Капитал: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Капитал"
                            },
                            {
                                "callback_data" => "Кэш: f_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Кэш"
                            }
                        ]
                    ]
                },
                "text" => "Выбери категорию чтобы сохранить для 28500.0:"
            }
        },
        "update_id" => 20680900
      }
    end
    let(:telegram_bot_params_choose_sub_category) do
      {
        "callback_query" => {
            "chat_instance" => ENV['CHAT_INSTANCE'],
            "data" => "Молочка: f1_id:AQADE9kxGwiPMEh-:28500.0",
            **message_from,
            "id" => "1651136315469696445",
            "message" => {
                **chat,
                "date" => 1672651172,
                "from" => {
                    "first_name" => ENV['BOT_NAME'],
                    "id" => ENV['BOT_ID'],
                    "is_bot" => true,
                    "username" => ENV['BOT_USER_NAME']
                },
                "message_id" => 51499,
                "reply_markup" => {
                    "inline_keyboard" => [
                        [
                            {
                                "callback_data" => "Молочка: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Молочка"
                            },
                            {
                                "callback_data" => "Готовая: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Готовая"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Полуфабрикаты/м_: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Полуфабрикаты/м_"
                            },
                            {
                                "callback_data" => "Фрукты: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Фрукты"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Овощи: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Овощи"
                            },
                            {
                                "callback_data" => "Сладости: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Сладости"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Бакалея: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Бакалея"
                            },
                            {
                                "callback_data" => "Специи, приправ_: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Специи, приправ_"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Колбаса, сосиск_: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Колбаса, сосиск_"
                            },
                            {
                                "callback_data" => "Кофе, Чай: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Кофе, Чай"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Новопочта: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Новопочта"
                            },
                            {
                                "callback_data" => "Рыба: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Рыба"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Яйца: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Яйца"
                            },
                            {
                                "callback_data" => "Вода: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Вода"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Хлеб и др: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Хлеб и др"
                            },
                            {
                                "callback_data" => "Алкоголь: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Алкоголь"
                            }
                        ],
                        [
                            {
                                "callback_data" => "К пиву: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "К пиву"
                            },
                            {
                                "callback_data" => "Мясо: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Мясо"
                            }
                        ],
                        [
                            {
                                "callback_data" => "Детское питание: f1_id:AQADE9kxGwiPMEh-:28500.0",
                                "text" => "Детское питание"
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
                "text" => "Выбери подкатегорию:"
            }
        },
        "update_id" => 20680950
      }
    end
    # 2 products were not parsed in photo: spec/images/not_parsed_two_fake_products_1.jpeg
    let(:telegram_bot_params_upload_photo_two_products_were_not_parsed) do
      {
      "message" => {
          "caption" => caption,
          "chat" => {
              "first_name" => "Nikolay",
              "id" => ENV['MY_TELEGRAM_ID'],
              "last_name" => "Stepanets",
              "type" => "private",
              "username" => ENV['MY_USER_NAME']
          },
          "date" => 1672649172,
          **message_from,
          "message_id" => 51490,
          "photo" => [
              {
                  "file_id": "AgACAgIAAxkBAAKKEGWGuUiPS0t4260F7XPXoD94o5XVAAIk2TEbCI8wSFy_cIfZZyhaAQADAgADcwADMwQ",
                  "file_unique_id": "AQADJNkxGwiPMEh4",
                  "file_size": 1259,
                  "width": 67,
                  "height": 90
              },
              {
                  "file_id": "AgACAgIAAxkBAAKKEGWGuUiPS0t4260F7XPXoD94o5XVAAIk2TEbCI8wSFy_cIfZZyhaAQADAgADbQADMwQ",
                  "file_unique_id": "AQADJNkxGwiPMEhy",
                  "file_size": 18940,
                  "width": 240,
                  "height": 320
              },
              {
                  "file_id": "AgACAgIAAxkBAAKKEGWGuUiPS0t4260F7XPXoD94o5XVAAIk2TEbCI8wSFy_cIfZZyhaAQADAgADeAADMwQ",
                  "file_unique_id": "AQADJNkxGwiPMEh9",
                  "file_size": 91757,
                  "width": 600,
                  "height": 800
              },
              {
                  "file_id": "AgACAgIAAxkBAAKKEGWGuUiPS0t4260F7XPXoD94o5XVAAIk2TEbCI8wSFy_cIfZZyhaAQADAgADeQADMwQ",
                  "file_unique_id": "AQADJNkxGwiPMEh-",
                  "file_size": 138745,
                  "width": 960,
                  "height": 1280
              }
          ]
      },
      "update_id" => 20680800
      }
    end
    let(:telegram_bot_params_choose_category_1_two_products_were_not_parsed) do
      {
      "callback_query" => {
          "chat_instance" => ENV['CHAT_INSTANCE'],
          "data" => "Еда: f_id:AQADJNkxGwiPMEh-:28500.0",
          **message_from,
          "id" => "1651136316635507601",
          "message" => {
              **chat,
              "date" => 1672650172,
              "from" => {
                  "first_name" => ENV['BOT_NAME'],
                  "id" => ENV['BOT_ID'],
                  "is_bot" => true,
                  "username" => ENV['BOT_USER_NAME']
              },
              "message_id" => 51491,
              "reply_markup" => {
                  "inline_keyboard" => [
                      [
                          {
                              "callback_data" => "Транспорт: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Транспорт"
                          },
                          {
                              "callback_data" => "Еда: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Еда"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Развлечения: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Развлечения"
                          },
                          {
                              "callback_data" => "Подарки: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Подарки"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Для дома: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Для дома"
                          },
                          {
                              "callback_data" => "Коля: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Коля"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Валди: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Валди"
                          },
                          {
                              "callback_data" => "Непредвиденное: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Непредвиденное"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Марк: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Марк"
                          },
                          {
                              "callback_data" => "Лиля: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Лиля"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Путешествия: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Путешествия"
                          },
                          {
                              "callback_data" => "Инвестиции, фз: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Инвестиции, фз"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Авто бмоно: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Авто бмоно"
                          },
                          {
                              "callback_data" => "Крупные покупки: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Крупные покупки"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Капитал: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Капитал"
                          },
                          {
                              "callback_data" => "Кэш: f_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Кэш"
                          }
                      ]
                  ]
              },
              "text" => "Выбери категорию чтобы сохранить для 28500.0:"
          }
      },
      "update_id" => 20680900
      }
    end
    let(:telegram_bot_params_choose_sub_category_1_two_products_were_not_parsed) do
      {
      "callback_query" => {
          "chat_instance" => ENV['CHAT_INSTANCE'],
          "data" => "Молочка: f1_id:AQADJNkxGwiPMEh-:28500.0",
          **message_from,
          "id" => "1651136315469696445",
          "message" => {
              **chat,
              "date" => 1672651172,
              "from" => {
                  "first_name" => ENV['BOT_NAME'],
                  "id" => ENV['BOT_ID'],
                  "is_bot" => true,
                  "username" => ENV['BOT_USER_NAME']
              },
              "message_id" => 51499,
              "reply_markup" => {
                  "inline_keyboard" => [
                      [
                          {
                              "callback_data" => "Молочка: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Молочка"
                          },
                          {
                              "callback_data" => "Готовая: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Готовая"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Полуфабрикаты/м_: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Полуфабрикаты/м_"
                          },
                          {
                              "callback_data" => "Фрукты: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Фрукты"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Овощи: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Овощи"
                          },
                          {
                              "callback_data" => "Сладости: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Сладости"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Бакалея: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Бакалея"
                          },
                          {
                              "callback_data" => "Специи, приправ_: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Специи, приправ_"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Колбаса, сосиск_: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Колбаса, сосиск_"
                          },
                          {
                              "callback_data" => "Кофе, Чай: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Кофе, Чай"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Новопочта: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Новопочта"
                          },
                          {
                              "callback_data" => "Рыба: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Рыба"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Яйца: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Яйца"
                          },
                          {
                              "callback_data" => "Вода: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Вода"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Хлеб и др: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Хлеб и др"
                          },
                          {
                              "callback_data" => "Алкоголь: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Алкоголь"
                          }
                      ],
                      [
                          {
                              "callback_data" => "К пиву: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "К пиву"
                          },
                          {
                              "callback_data" => "Мясо: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Мясо"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Детское питание: f1_id:AQADJNkxGwiPMEh-:28500.0",
                              "text" => "Детское питание"
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
              "text" => "Выбери подкатегорию:"
          }
      },
      "update_id" => 20680950
      }
    end
    let(:telegram_bot_params_choose_category_2_two_products_were_not_parsed) do
      {
      "callback_query" => {
          "chat_instance" => ENV['CHAT_INSTANCE'],
          "data" => "Еда: f_id:AQADJNkxGwiPMEh-:236726.0",
          **message_from,
          "id" => "1651136316635507601",
          "message" => {
              **chat,
              "date" => 1672650172,
              "from" => {
                  "first_name" => ENV['BOT_NAME'],
                  "id" => ENV['BOT_ID'],
                  "is_bot" => true,
                  "username" => ENV['BOT_USER_NAME']
              },
              "message_id" => 51500,
              "reply_markup" => {
                  "inline_keyboard" => [
                      [
                          {
                              "callback_data" => "Транспорт: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Транспорт"
                          },
                          {
                              "callback_data" => "Еда: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Еда"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Развлечения: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Развлечения"
                          },
                          {
                              "callback_data" => "Подарки: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Подарки"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Для дома: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Для дома"
                          },
                          {
                              "callback_data" => "Коля: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Коля"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Валди: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Валди"
                          },
                          {
                              "callback_data" => "Непредвиденное: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Непредвиденное"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Марк: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Марк"
                          },
                          {
                              "callback_data" => "Лиля: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Лиля"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Путешествия: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Путешествия"
                          },
                          {
                              "callback_data" => "Инвестиции, фз: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Инвестиции, фз"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Авто бмоно: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Авто бмоно"
                          },
                          {
                              "callback_data" => "Крупные покупки: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Крупные покупки"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Капитал: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Капитал"
                          },
                          {
                              "callback_data" => "Кэш: f_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Кэш"
                          }
                      ]
                  ]
              },
              "text" => "Выбери категорию чтобы сохранить для 236726.0:"
          }
      },
      "update_id" => 20680900
      }
    end
    let(:telegram_bot_params_choose_sub_category_2_two_products_were_not_parsed) do
      {
      "callback_query" => {
          "chat_instance" => ENV['CHAT_INSTANCE'],
          "data" => "Молочка: f1_id:AQADJNkxGwiPMEh-:236726.0",
          **message_from,
          "id" => "1651136315469696445",
          "message" => {
              **chat,
              "date" => 1672651172,
              "from" => {
                  "first_name" => ENV['BOT_NAME'],
                  "id" => ENV['BOT_ID'],
                  "is_bot" => true,
                  "username" => ENV['BOT_USER_NAME']
              },
              "message_id" => 51501,
              "reply_markup" => {
                  "inline_keyboard" => [
                      [
                          {
                              "callback_data" => "Молочка: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Молочка"
                          },
                          {
                              "callback_data" => "Готовая: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Готовая"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Полуфабрикаты/м_: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Полуфабрикаты/м_"
                          },
                          {
                              "callback_data" => "Фрукты: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Фрукты"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Овощи: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Овощи"
                          },
                          {
                              "callback_data" => "Сладости: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Сладости"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Бакалея: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Бакалея"
                          },
                          {
                              "callback_data" => "Специи, приправ_: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Специи, приправ_"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Колбаса, сосиск_: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Колбаса, сосиск_"
                          },
                          {
                              "callback_data" => "Кофе, Чай: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Кофе, Чай"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Новопочта: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Новопочта"
                          },
                          {
                              "callback_data" => "Рыба: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Рыба"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Яйца: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Яйца"
                          },
                          {
                              "callback_data" => "Вода: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Вода"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Хлеб и др: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Хлеб и др"
                          },
                          {
                              "callback_data" => "Алкоголь: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Алкоголь"
                          }
                      ],
                      [
                          {
                              "callback_data" => "К пиву: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "К пиву"
                          },
                          {
                              "callback_data" => "Мясо: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Мясо"
                          }
                      ],
                      [
                          {
                              "callback_data" => "Детское питание: f1_id:AQADJNkxGwiPMEh-:236726.0",
                              "text" => "Детское питание"
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
              "text" => "Выбери подкатегорию:"
          }
      },
      "update_id" => 20680950
      }
    end

    context 'when uah expenses' do
      context 'when all our expenses', freezed_time: '2024-06-20T20:47:00+00:00' do
        context 'when 1 category was not parsed', freezed_time: '2024-06-22T15:03:00+00:00' do
          it 'saves half price from not parsed category and mark m' do
            # upload photo
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_upload_photo
            # choose category
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category
            # choose sub category
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category

            expect(response.status).to eq(200)
          end
        end

        context 'when 2 products were not parsed' do
          # 2 products were not parsed in photo: spec/images/not_parsed_two_fake_products_1.jpeg

          it 'saves price from not parsed category' do
            # upload photo
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_upload_photo_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category_1_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category_1_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category_2_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category_2_two_products_were_not_parsed

            expect(response.status).to eq(200)
          end
        end
      end
    end

    context 'when usd expenses', freezed_time: '2024-06-22T15:05:00+00:00' do
      context 'when all our expenses' do
        let(:caption) { "usd 15593.0528" }

        context 'when 1 category was not parsed' do
          it 'saves half price from not parsed category and mark m' do
            # upload photo
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_upload_photo
            # choose category
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category
            # choose sub category
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category

            expect(response.status).to eq(200)
          end
        end

        context 'when 2 products were not parsed', freezed_time: '2024-06-22T15:07:00+00:00' do
          # 2 products were not parsed in photo: spec/images/not_parsed_two_fake_products.jpeg

          it 'saves price from not parsed category' do
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_upload_photo_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category_1_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category_1_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category_2_two_products_were_not_parsed
            post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category_2_two_products_were_not_parsed

            expect(response.status).to eq(200)
          end
        end
      end
    end

    context 'when monzo expenses', freezed_time: '2024-06-21T20:36:00+00:00' do
      let(:caption) { "monzo" }

      context 'when 1 category was not parsed' do
        it 'saves prices' do
          # upload photo
          post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_upload_photo
          # choose category
          post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_category
          # choose sub category
          post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_choose_sub_category

          expect(response.status).to eq(200)
        end
      end
    end
  end

  context 'when return some money after withdraw cash', freezed_time: '2024-06-20T20:51:00+00:00' do
    let(:telegram_bot_params_return_some_money) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670051828,
              **message_from,
              "message_id" => 35160,
              "text" => "Вернуть часть денег после снятия кэша"
          },
          "update_id" => 20479564
      }
    end
    let(:telegram_bot_params_grivnas_and_foreign_money) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670052690,
              **message_from,
              "message_id" => 35169,
              "text" => "1468 600000"
          },
          "update_id" => 20479570
      }
    end

    it 'withdraws money from wise amount' do
      # choose return some money
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_return_some_money
      # enter grivnas and foreign money
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_grivnas_and_foreign_money

      expect(response.status).to eq(200)
    end
  end

  context 'when round in google sheet like in monobank', freezed_time: '2024-01-01T02:57:00+00:00' do
    let(:telegram_bot_params_return_round_money) do
      {
          "message" => {
              "chat" => {
                  "first_name" => "Nikolay",
                  "id" => ENV['MY_TELEGRAM_ID'],
                  "last_name" => "Stepanets",
                  "type" => "private",
                  "username" => ENV['MY_USER_NAME']
              },
              "date" => 1670051828,
              **message_from,
              "message_id" => 35160,
              "text" => "Выровнять в гугл таблице как в монобанке"
          },
          "update_id" => 20479564
      }
    end

    it 'makes money the same as in monobank' do
      post '/telegram/R3FQNsguWJKThALhQPP_E8yrs-s', params: telegram_bot_params_return_round_money

      expect(response.status).to eq(200)
    end
  end
end
