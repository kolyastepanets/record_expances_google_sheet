require 'rails_helper'
require 'telegram/bot/rspec/integration/rails'

RSpec.describe TelegramWebhooksController, telegram_bot: :rails do
  # include_context 'telegram/bot/updates_controller'

  let(:from) { { username: 'nikolay_stepanets' } }

  describe '#start!' do
    let(:result) do
      {
        text: "Выбери действие:",
        reply_markup: {
          inline_keyboard: [
            [{text: "Получить баланс текущего месяца gsheets", callback_data: "get_current_month_balance"}],
            [{text: "UAH на gsheets", callback_data: "get_current_mono_balance_from_google_sheet"}],
            [{text: "UAH на monobank", callback_data: "get_current_mono_balance_from_monobank"}],
            [{text: "USD FOP на gsheets", callback_data: "get_usd_fop_from_google_sheet"}],
            [{text: "USD FOP на monobank", callback_data: "get_usd_fop_from_monobank"}],
            [{ text: 'Total saved money on gsheets', callback_data: 'total_saved_money_from_google_sheet' }],
            [{text: "Последние 3 траты в gsheets", callback_data: "get_last_3_expenses_in_google_sheet"}],
            [{text: "Последние 10 транзакций в моно", callback_data: "get_last_10_transactions_from_mono"}],
            [{text: "Продал валюту c ФОПа", callback_data: "sold_dollars_from_fop"}],
            [{text: "Внести расходы", callback_data: "enter_expenses"}],
            [{text: "Главное меню", callback_data: "start_again"}]
          ]
        },
        chat_id: 456
      }
    end

    context 'when user is nikolay_stepanets' do
      let(:from) { { username: 'nikolay_stepanets' } }

      it 'should return base menu' do
        expect { dispatch_command(:start) }.to make_telegram_request(bot, :sendMessage).with(hash_including(result))
      end
    end

    context 'when user is liliya_stepanets' do
      let(:from) { { username: 'liliya_stepanets' } }

      it 'should return base menu' do
        expect { dispatch_command(:start) }.to make_telegram_request(bot, :sendMessage).with(hash_including(result))
      end
    end

    context 'when some other user' do
      let(:from) { { username: 'other_name' } }

      it 'should return base menu' do
        expect { dispatch_command(:start) }.to make_telegram_request(bot, :sendMessage).with(hash_including(text: 'You are not authorized'))
      end
    end
  end

  describe '#get_current_month_balance', vcr: true, freezed_time: '2022-08-20T19:49:00+00:00' do
    let(:data) { "get_current_month_balance" }

    it { should respond_with_message("67 777 грн") }
  end

  describe '#get_current_mono_balance_from_google_sheet', vcr: true, freezed_time: '2022-08-20T19:54:00+00:00' do
    let(:data) { "get_current_mono_balance_from_google_sheet" }

    it { should respond_with_message("uah in google sheet: 4 860 грн") }
  end

  describe '#get_current_mono_balance_from_monobank', vcr: true, freezed_time: '2022-08-20T19:55:00+00:00' do
    let(:data) { "get_current_mono_balance_from_monobank" }

    it { should respond_with_message("uah in mono: 4871 грн") }
  end

  describe '#get_usd_fop_from_google_sheet', vcr: true, freezed_time: '2022-08-20T20:00:00+00:00' do
    let(:data) { "get_usd_fop_from_google_sheet" }

    it { should respond_with_message("usd fop in google sheet: $16 845") }
  end

  describe '#get_usd_fop_from_monobank', vcr: true, freezed_time: '2022-08-20T20:02:00+00:00' do
    let(:data) { "get_usd_fop_from_monobank" }

    it { should respond_with_message("usd fop in mono: $16848") }
  end

  describe '#get_last_3_expenses_in_google_sheet', vcr: true, freezed_time: '2022-08-20T20:03:00+00:00' do
    let(:data) { "get_last_3_expenses_in_google_sheet" }

    it { should respond_with_message("Последние 3 траты в google sheet:
Еда Мясо 180,9795484 грн, 20-8-2022
Транспорт Автобус 250 грн, 20-8-2022
Еда Готовая 1050 грн, 20-8-2022") }
  end

  describe '#get_last_10_transactions_from_mono', vcr: true, freezed_time: '2022-08-20T20:08:00+00:00' do
    let(:data) { "get_last_10_transactions_from_mono" }

    it { should respond_with_message("Последние 10 транзакций в моно:
APPLE STORE R270 - 403 грн, 20-8-2022
На награду в моно - 0 грн, 20-8-2022
ZIZZI - 1877 грн, 20-8-2022
На награду в моно - 0 грн, 20-8-2022
Miniso - 89 грн, 20-8-2022
На награду в моно - 0 грн, 20-8-2022
STGCOACH/CTYLINK - 250 грн, 20-8-2022
На награду в моно - 0 грн, 20-8-2022
DELIVEROO - 1049 грн, 20-8-2022
На награду в моно - 0 грн, 20-8-2022") }
  end

  describe '#enter_expenses' do
    let(:data) { "enter_expenses" }

    it { should respond_with_message("как заполнять?") }
  end
end
