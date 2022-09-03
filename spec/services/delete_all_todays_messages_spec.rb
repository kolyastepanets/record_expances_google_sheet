require 'rails_helper'

RSpec.describe DeleteAllTodaysMessages, freezed_time: '2022-09-01' do
  subject { described_class.call }

  let(:key) { "messages_at_2022-09-01" }
  let(:redis) { Redis.new }

  context 'when key exists' do
    before do
      redis.set(key, [12345, 12346].to_json, ex: 10.seconds)
    end

    it 'calls DeleteMessagesJob' do
      expect(DeleteMessagesJob).to receive(:perform_later).with([12345, 12346])

      subject
    end
  end

  context 'when key blank' do
    before do
      redis.del(key)
    end

    it 'does not call DeleteMessagesJob' do
      expect(DeleteMessagesJob).to_not receive(:perform_later)

      subject
    end
  end
end
