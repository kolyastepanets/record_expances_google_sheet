
require 'rails_helper'

RSpec.describe SendMessageToBotToAskToEnterExpencesFromMonzoSchedule do
  subject { described_class.call }

  context 'when message already sent bot' do
    it 'sets already_sent_to_bot true' do
      Redis.new.set("monzo_transaction_id_1", { "account_id": 1 }.to_json, ex: 24.hours)
      allow(SendMessageToBotToAskToEnterExpencesFromMonzo).to receive(:call)

      subject

      expect(JSON.parse(Redis.new.get("monzo_transaction_id_1"))["already_sent_to_bot"]).to eq(true)
    end

    it 'does not send message to bot 2nd time' do
      Redis.new.set("monzo_transaction_id_1", { "account_id": 1, already_sent_to_bot: true }.to_json, ex: 24.hours)
      expect(SendMessageToBotToAskToEnterExpencesFromMonzo).to_not receive(:call)

      subject
    end
  end
end
