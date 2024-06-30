
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

  context 'when from joint to personal', vcr: true, freezed_time: '2024-06-30T12:53:00+00:00' do
    let(:params_from_joint) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjRqTFBhpBikvFk2L3",
          "description": ENV['MY_MONZO_NAME'],
          "amount": -1000,
          "currency": "GBP",
          "local_amount": -1000,
          "local_currency": "GBP",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end
    let(:params_to_personal) do
      {
        "type": "transaction.created",
        "data": {
          "id": "tx_0000AjRqTFC3nrLetgh745",
          "description": ENV['JOINT_MONZO_NAME'],
          "amount": 1000,
          "currency": "GBP",
          "local_amount": 1000,
          "local_currency": "GBP",
          "account_id": ENV['MONZO_ACCOUNT_ID']
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjRpsEwpkmizTcLIUU", params_from_joint.to_json)
      redis.set("monzo_transaction_id_tx_0000AjRpsExBjT0ZUiVa2j", params_to_personal.to_json)
    end

    it 'withdraws from joint and adds personal' do
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end

  context 'when from personal to joint', vcr: true, freezed_time: '2024-06-30T12:47:00+00:00' do
    let(:params_to_joint) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjRpsEwpkmizTcLIUU",
          "description": ENV['MY_MONZO_NAME'],
          "amount": 1000,
          "currency": "GBP",
          "is_load": false,
          "local_amount": 1000,
          "local_currency": "GBP",
          "account_id": ENV['JOINT_MONZO_ACCOUNT_ID'],
        }
      }
    end
    let(:params_from_personal) do
      {
        "type": "transaction.updated",
        "data": {
          "id": "tx_0000AjRpsExBjT0ZUiVa2j",
          "description": ENV['JOINT_MONZO_NAME'],
          "amount": -1000,
          "currency": "GBP",
          "local_amount": -1000,
          "local_currency": "GBP",
          "account_id": ENV['MONZO_ACCOUNT_ID'],
        }
      }
    end

    before do
      redis = Redis.new
      redis.set("monzo_transaction_id_tx_0000AjRpsEwpkmizTcLIUU", params_to_joint.to_json)
      redis.set("monzo_transaction_id_tx_0000AjRpsExBjT0ZUiVa2j", params_from_personal.to_json)
    end

    it 'withdraws from personal and adds joint' do
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
end
