require 'rails_helper'

RSpec.describe SumEnteredAmount do
  subject{ described_class.call(entered_amount) }

  context 'when entered_amount with +' do
    let(:entered_amount) { "100+20+1" }

    it 'returns sum' do
      expect(subject).to eq(121.0)
    end
  end

  context 'when entered_amount without +' do
    let(:entered_amount) { "100" }

    it 'returns prices' do
      expect(subject).to eq(100.0)
    end
  end
end
