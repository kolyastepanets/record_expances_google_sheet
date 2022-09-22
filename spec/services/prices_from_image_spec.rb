require 'rails_helper'

RSpec.describe PricesFromImage, vcr: true do
  subject { described_class.call(message_params) }

  let(:message_params) do
  end

  before do
    allow_any_instance_of(described_class).to receive(:get_telegram_image).and_return(get_telegram_image)
  end

  context 'when receipt polish shop 1', freezed_time: '2022-09-21T21:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum
      expect(result).to eq([[2.99, 1.5, 3.0, 1.35, 2.95, 0.55, 3.78, 1.5, 2.29, 4.04], 23.95, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 2', freezed_time: '2022-09-21T22:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out3.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[2.65, 2.85, 1.55, 1.75, 3.35, 1.2, 1.09, 0.6, 1.29, 5.5, 2.03, 2.73, 2.99], 29.58, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 1', freezed_time: '2022-09-21T22:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out2.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[1.99, 1.79, 1.99], 5.77, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 2', freezed_time: '2022-09-21T22:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out4.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[1.85, 1.45, 1.67, 2.99, 1.95, 9.99], 19.9, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt sainsbury 1', freezed_time: '2022-09-22T08:13:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out5.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[2.75, 13.0, 2.05, 2.0, 2.0, 2.5, 1.7, 5.3, 3.0, 1.35, 2.0, 2.5, 1.1, 1.0, 1.7, 1.5, 1.6, 2.35, 1.4, 1.35, 1.5, 1.35, 2.25, 2.75, 2.2, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.75], 74.95, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  xcontext 'when receipt waitrose 1', freezed_time: '2022-09-22T08:24:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out6.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[19.99, 1.1, 2.0, 2.0, 81.5, 1.5, 1.5, 0.9, 2.5, 1.5, 1.25, 1.5, 1.0, 1.0, 1.0, 1.0, 2.5, 927.33, 1.55, 0.5, 2.3, 2.3, 1.55, 1.66, 2.0, 2.2, 2.0, 2.0, 2.4, 1.12, 1.55, 1.0, 3.5, 103.95, 1.7, 92.4, 2.5, 2.2, 2.0, 2.55, 1.95, 952.0, 1.25, 1.5, 1.9], 105.2, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt', freezed_time: '2022-09-22T13:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out8.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq( [[19.99, 1.1, 2.0, 2.0, 1.5, 1.5, 1.5, 0.9, 2.5, 1.5, 1.25, 1.5, 1.0, 1.0, 1.0, 1.0, 2.5, 7.33, 1.55, 0.35, 0.5, 2.3, 2.3, 1.55, 1.66, 2.0, 2.2, 2.0, 2.0, 2.4, 1.12, 1.55, 1.0, 3.5, 2.1, 3.95, 1.7, 2.4, 2.5, 2.2, 2.0, 2.55, 1.95, 0.05, 2.0, 1.25, 1.5], 105.2, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end
end
