require 'rails_helper'

RSpec.describe SaveMessageIdToRedis, freezed_time: '2022-09-01' do
  subject { described_class.call(message_id) }

  let(:message_id) { 12345 }
  let(:key) { "messages_at_2022-09-01" }
  let(:redis) { Redis.new }

  context 'when message already present' do
    before do
      redis.set(key, [12346].to_json, ex: 10.seconds)
    end

    it 'adds one more message' do
      subject

      expect(JSON.parse(redis.get(key))).to match_array([12345, 12346])
    end
  end

  context 'when no messages' do
    before do
      redis.del(key)
    end

    it 'adds message' do
      subject

      expect(JSON.parse(redis.get(key))).to eq([12345])
    end
  end

  context 'when message_id nil' do
    before do
      redis.del(key)
    end

    it 'does not add message' do
      subject

      expect(JSON.parse(redis.get(key))).to eq([12345])
    end
  end
end
