require 'rails_helper'

RSpec.describe TextHowMuchMoneyCanSpendThisWeek::ForTravelling do
  subject { described_class.call }

  before do
    Redis.new.set("all_expenses", expences.to_json)
  end

  context 'when previous month 400 was spent', freezed_time: '2023-11-23' do
    let(:expences) do
      [
        ["Путешествия", "Отель", "$400", "23", "10", "2023"],
      ]
    end

    it 'returns money to spend as usual' do
      expect(subject).to eq("Spent on Путешествия: $400.0\nMonth limit: $500\nNow can spend: $600.0\n")
    end
  end

  context 'when previous month 600 was spent', freezed_time: '2023-11-23' do
    let(:expences) do
      [
        ["Путешествия", "Отель", "$600", "23", "10", "2023"],
      ]
    end

    it 'returns money to spend as usual' do
      expect(subject).to eq("Spent on Путешествия: $600.0\nMonth limit: $500\nNow can spend: $400.0\n")
    end
  end

  context 'when previous month was not fit in limit', freezed_time: '2023-11-23' do
    let(:expences) do
      [
        ["Путешествия", "Виза", "$600", "16", "10", "2023"],
        ["Путешествия", "Отель", "$500", "23", "10", "2023"],
        ["Путешествия", "Авиа билеты", "$500", "23", "10", "2023"],
      ]
    end

    it 'returns warning' do
      expect(subject).to eq("Spent on Путешествия: $1600.0\nMonth limit: $500\nNext time can spend: $400.0\n<b>Next time can start spending: 01 Jan 2024 - 07 Jan 2024</b>")
    end
  end
end
