# ALLOW_BOT_REAL_REQUEST=1 use before running test to make real request to bot
#
# !!! WARNING !!!
# prepare data in google sheet, because requests are making to prod !!!!
#
# USE big numbers so that it will be clear in google sheet it was test
#
# clear redis from Monobank currency rates
#
# !!! WARNING !!!

require 'rails_helper'

RSpec.describe TelegramWebhooksController, type: :request, vcr: true do
  include ActiveJob::TestHelper

  before do
    allow(DeleteAllTodaysMessages).to receive(:call)
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

  context 'when metro expenses' do
    context 'when all our metro expenses 2 times', freezed_time: '2022-12-03T13:36:00+00:00', perform_enqueued: true do
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
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "enter_expenses",
                **message_from,
                "id" => "1651136317267389846",
                "message" => {
                    **chat,
                    "date" => 1670051828,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35160,
                    **reply_markup_all_info,
                    "text" => "Выбери действие:"
                }
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
        # main menu
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_main_menu
        # enter expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_expenses
        # mykola paid
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_our_all_expenses
        # common expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_metro_expenses
        # transport category
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when common expenses' do
    context 'when vika payed', freezed_time: '2022-12-03T08:31:00+00:00', perform_enqueued: true do
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
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "enter_expenses",
                **message_from,
                "id" => "1651136317267389846",
                "message" => {
                    **chat,
                    "date" => 1670051828,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35160,
                    **reply_markup_all_info,
                    "text" => "Выбери действие:"
                }
            },
            "update_id" => 20479564
        }
      end
      let(:telegram_bot_params_vika_paid) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "calculate_as_vika_paid_half_expenses",
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
                "text" => "1000000"
            },
            "update_id" => 20479570
        }
      end
      let(:telegram_bot_params_finish_enter_prices) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "finish_remember_total_price_of_products",
                **message_from,
                "id" => "1651136318519661742",
                "message" => {
                    **chat,
                    "date" => 1670052694,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35173,
                    **reply_markup_choosing_category,
                    "text" => "Выбери категорию:"
                }
            },
            "update_id" => 20479571
        }
      end

      it 'saves data to every day expenses page and do not decrease uah value' do
        # main menu
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_main_menu
        # enter expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_expenses
        # vika paid
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_vika_paid
        # common expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_common_expenses
        # transport category
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price
        # finish enter prices
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end

    context 'when vika payed 2 times', freezed_time: '2022-12-03T12:56:00+00:00', perform_enqueued: true do
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
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "enter_expenses",
                **message_from,
                "id" => "1651136317267389846",
                "message" => {
                    **chat,
                    "date" => 1670051828,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35160,
                    **reply_markup_all_info,
                    "text" => "Выбери действие:"
                }
            },
            "update_id" => 20479564
        }
      end
      let(:telegram_bot_params_vika_paid) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "calculate_as_vika_paid_half_expenses",
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

      it 'saves data to every day expenses page 2 times and do not decrease uah value' do
        # main menu
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_main_menu
        # enter expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_expenses
        # vika paid
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_vika_paid
        # common expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_common_expenses
        # transport category
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end

    context 'when mykola payed 2 times', freezed_time: '2022-12-03T13:04:00+00:00', perform_enqueued: true do
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
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "enter_expenses",
                **message_from,
                "id" => "1651136317267389846",
                "message" => {
                    **chat,
                    "date" => 1670051828,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35160,
                    **reply_markup_all_info,
                    "text" => "Выбери действие:"
                }
            },
            "update_id" => 20479564
        }
      end
      let(:telegram_bot_params_mykola_paid) do
        {
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "calculate_as_mykola_paid_half_expenses",
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
        # main menu
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_main_menu
        # enter expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_expenses
        # mykola paid
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_mykola_paid
        # common expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_common_expenses
        # transport category
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end

    context 'when all our expenses 2 times', freezed_time: '2022-12-03T13:07:00+00:00', perform_enqueued: true do
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
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "enter_expenses",
                **message_from,
                "id" => "1651136317267389846",
                "message" => {
                    **chat,
                    "date" => 1670051828,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35160,
                    **reply_markup_all_info,
                    "text" => "Выбери действие:"
                }
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
        # main menu
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_main_menu
        # enter expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_expenses
        # mykola paid
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_our_all_expenses
        # common expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_common_expenses
        # transport category
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when uah in foreign currency expenses' do
    context 'when all our receipt foreigh currency expenses 2 times', freezed_time: '2022-12-04T02:29:00+00:00', perform_enqueued: true do
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
            "callback_query" => {
                "chat_instance" => ENV['CHAT_INSTANCE'],
                "data" => "enter_expenses",
                **message_from,
                "id" => "1651136317267389846",
                "message" => {
                    **chat,
                    "date" => 1670051828,
                    "from" => {
                        "first_name" => ENV['BOT_NAME'],
                        "id" => ENV['BOT_ID'],
                        "is_bot" => true,
                        "username" => ENV['BOT_USER_NAME']
                    },
                    "message_id" => 35160,
                    **reply_markup_all_info,
                    "text" => "Выбери действие:"
                }
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
        # main menu
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_main_menu
        # enter expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_expenses
        # all our expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_our_all_expenses
        # receipt foreigh currency expenses
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_receipt_foreign_currency_expenses
        # enter currency rate
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_enter_uah_foreign_currency_rate
        # transport category
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category
        # taxi subcategory
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory
        # taxi price
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price
        # transport category 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_transport_category_2
        # taxi subcategory 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_subcategory_2
        # taxi price 2
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_taxi_price_2
        # finish enter prices
        post '/telegram/lNt4E9U-9ZtnxGH6dfkGbY0t8pU', params: telegram_bot_params_finish_enter_prices

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when cash foreign currency' do
  end

  context 'when dollar card' do
  end

  context 'when enter common uah expenses through bot' do
  end
end
