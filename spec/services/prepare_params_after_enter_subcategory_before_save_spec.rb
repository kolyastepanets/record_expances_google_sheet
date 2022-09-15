require 'rails_helper'

RSpec.describe PrepareParamsAfterEnterSubcategoryBeforeSave do
  subject { described_class.call(telegram_message) }

  let(:telegram_message) do
    "Бакалея: f1_id:123456789012345-:2.99"
  end
  let(:redis) { Redis.new }

  context 'when uah' do
    it 'returns 3 values' do
    end
  end

  context 'when usd' do
    it 'returns 3 values' do
    end
  end
end
