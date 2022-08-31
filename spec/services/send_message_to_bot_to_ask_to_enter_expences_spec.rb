require 'rails_helper'

RSpec.describe SendMessageToBotToAskToEnterExpences do
  subject { described_class.call(transaction_data) }

  let(:id) { "6mIsfyeVdVbitoSl" }
  let(:redis) { Redis.new }
  let(:transaction_data) do
    {
      amount: -53362,
      balance: 3332238,
      cashbackAmount: 0,
      commissionRate: 0,
      currencyCode: 826,
      description: "Amazon.co.uk",
      hold: true,
      id: id,
      mcc: 5969,
      operationAmount: -1195,
      originalMcc: 5969,
      receiptId: "X5H9-3T1K-4HB8-CMC5",
      time: 1661777571
    }
  end

  context 'when telegram bot sends message' do
    let(:response_message_with_params) do
      {
        "result" => {
          "message_id" => 123
        }
      }
    end
    let(:response_message_with_categories) do
      {
        "result" => {
          "message_id" => 456
        }
      }
    end

    before do
      allow_any_instance_of(described_class).to receive(:send_message_with_params).and_return(response_message_with_params)
      allow_any_instance_of(described_class).to receive(:send_message_with_categories).and_return(response_message_with_categories)
    end

    it "saves message ids to redis" do
      subject

      expect(JSON.parse(redis.get(id)).deep_symbolize_keys).to eq({
        description: "Amazon.co.uk",
        message_ids: [123, 456],
        price_in_uah: 533.62,
      })
    end
  end

  context 'expenses to skip' do
    let(:transaction_data) do
      {
        amount: -53362,
        balance: 3332238,
        cashbackAmount: 0,
        commissionRate: 0,
        currencyCode: 826,
        description: "На награду в моно",
        hold: true,
        id: id,
        mcc: 5969,
        operationAmount: -1195,
        originalMcc: 5969,
        receiptId: "X5H9-3T1K-4HB8-CMC5",
        time: 1661777571
      }
    end

    it 'does not call telegram bot' do
      expect_any_instance_of(described_class).to_not receive(:send_message_with_params)
      expect_any_instance_of(described_class).to_not receive(:send_message_with_categories)

      subject
    end

    it 'returns nil' do
      expect(subject).to eq(nil)
    end
  end
end
