require 'rails_helper'

RSpec.describe TextHowMuchMoneyCanSpendThisWeek::ForFood do
  subject { described_class.call }

  before do
    Redis.new.set("all_expenses", expences.to_json)
  end

  context 'when previous week was fit in limit', freezed_time: '2023-09-23' do
    let(:expences) do
      [
        ["Еда", "Сладости", "$169", "16", "9", "2023"],
        ["Еда", "Сладости", "$69", "23", "9", "2023"],
      ]
    end

    it 'returns money to spend as usual' do
      expect(subject).to eq("Spent on Еда 18 Sep 2023 - 24 Sep 2023 in current week: $69.0\nWeek limit: $170\nLeft to spend: $101.0\n")
    end
  end

  context 'when previous week was not fit in limit', freezed_time: '2023-09-23' do
    let(:expences) do
      [
        ["Еда", "Сладости", "$171", "16", "9", "2023"],
        ["Еда", "Сладости", "$69", "23", "9", "2023"],
      ]
    end

    it 'returns less money to spend in current week' do
      expect(subject).to eq("Spent on Еда 18 Sep 2023 - 24 Sep 2023 in current week: $69.0\nWeek limit: $169.0\nLeft to spend: $100.0\n")
    end
  end

  context 'when current week was not fit in limit', freezed_time: '2023-09-23' do
    let(:expences) do
      [
        ["Еда", "Сладости", "$171", "23", "9", "2023"],
      ]
    end

    it 'returns warning' do
      expect(subject).to eq("Spent on Еда 18 Sep 2023 - 24 Sep 2023 in current week: $171.0\nWeek limit: $170\n<b>WARNING! STOP spending! Overspending: $1.0</b>\n<b>Next time can start spending: 25 Sep 2023 - 01 Oct 2023</b>")
    end
  end
end
