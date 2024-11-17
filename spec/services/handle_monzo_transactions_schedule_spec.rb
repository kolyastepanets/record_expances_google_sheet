
require 'rails_helper'

RSpec.describe HandleMonzoTransactionsSchedule do
  subject { described_class.call }

  context 'when message already sent bot' do
    it 'sets already_sent_to_bot true' do
      Redis.new.set("monzo_transaction_id_1", { "data": { "account_id": 1, "amount": 1 } }.to_json, ex: 24.hours)
      allow(SendMessageToBotToAskToEnterExpencesFromMonzo).to receive(:call)

      subject

      expect(JSON.parse(Redis.new.get("monzo_transaction_id_1"))["already_sent_to_bot"]).to eq(true)
    end

    it 'does not send message to bot 2nd time' do
      Redis.new.set("monzo_transaction_id_1", { "data": { "account_id": 1, "amount": 1 }, "already_sent_to_bot": true }.to_json, ex: 24.hours)
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when salary', vcr: true, freezed_time: '2024-06-30T13:16:00+00:00' do
    let(:params) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt",
          "description": "P1VEAGEODRH9, HAWK APPLIC, ATIONS CORP",
          "amount": 5766,
          "currency": "GBP",
          "local_amount": 7363,
          "local_currency": "USD",
          "account_id": ENV['MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt", params.to_json)
    end

    it 'adds to personal' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when youtube premium', vcr: true, freezed_time: '2024-07-06T20:46:00+00:00' do
    let(:params) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt",
          "description": "GOOGLE *YouTubePremium 650-253-0000  GBR",
          "amount": -288,
          "currency": "GBP",
          "local_amount": -14900,
          "local_currency": "UAH",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt", params.to_json)
    end

    it 'saves to google sheet' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when google storage', vcr: true, freezed_time: '2024-07-06T20:51:00+00:00' do
    let(:params) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt",
          "description": "GOOGLE *Google Storage 650-253-0000  GBR",
          "amount": -87,
          "currency": "GBP",
          "local_amount": -4500,
          "local_currency": "UAH",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt", params.to_json)
    end

    it 'saves to google sheet' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when digital ocean', vcr: true, freezed_time: '2024-07-06T20:55:00+00:00' do
    let(:params) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt",
          "description": "DigitalOcean.com",
          "amount": -87,
          "currency": "GBP",
          "local_amount": -4500,
          "local_currency": "UAH",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt", params.to_json)
    end

    it 'saves to google sheet' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when lebara', vcr: true, freezed_time: '2024-07-06T21:41:00+00:00' do
    let(:params) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt",
          "description": "Lebara Mobile Limited  London        GBR",
          "amount": -500,
          "currency": "GBP",
          "local_amount": -500,
          "local_currency": "GBP",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end
    let(:params_2) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt1",
          "description": "Lebara Mobile Limited  London        GBR",
          "amount": -500,
          "currency": "GBP",
          "local_amount": -500,
          "local_currency": "GBP",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt", params.to_json)
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt1", params_2.to_json)
    end

    it 'saves to google sheet' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when rebel energy', vcr: true, freezed_time: '2024-07-06T21:45:00+00:00' do
    let(:params) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjNe20ai0jRxWZFUpt",
          "description": "Rebel Energy Limited",
          "amount": -10000,
          "currency": "GBP",
          "local_amount": -10000,
          "local_currency": "GBP",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjNe20ai0jRxWZFUpt", params.to_json)
    end

    it 'saves to google sheet' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end
end
