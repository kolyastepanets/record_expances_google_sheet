require 'rails_helper'

RSpec.describe PricesFromImage, vcr: true do
  subject { described_class.call(message_params) }

  let(:message_params) do
  end

  before do
    allow_any_instance_of(described_class).to receive(:get_telegram_image).and_return(get_telegram_image)
  end

  context 'when receipt sok turkey 1', freezed_time: '2024-04-19T19:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/sok_turkey/out01.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>65.0},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>10.5},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>47.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>21.75},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>25.0},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>79.0},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>48.5},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>99.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>5.5},
          426.75,
          nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt sok turkey 2', freezed_time: '2024-04-22T18:07:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/sok_turkey/out02.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38.5},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>9.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59.8},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>39.95},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26.76},
        174.01,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt sok turkey 3', freezed_time: '2024-04-25T07:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/sok_turkey/out03.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>22.5},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>27.9},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>22.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>48.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>122.0},
        242.9,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt sok turkey 4', freezed_time: '2024-04-27T09:42:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/sok_turkey/out04.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>39.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>124.95},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34.5},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>22.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>24.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>17.5},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>22.0},
        328.45,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt bim turkey 1', freezed_time: '2024-04-20T18:38:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/bim_turkey/out01.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>11.0},
          {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>78.5},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>44.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>6.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>19.25},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>28.5},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>19.5},
          {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>109.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>65.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.0},
          384.25,
          nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt bim turkey 2', freezed_time: '2024-04-27T14:09:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/bim_turkey/out02.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>19.75},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9.75},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>69.5},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22.0},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>67.0},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>178.5},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>165.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>44.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>44.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>22.75},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>48.5},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32.5},
        786.25,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  def new_result_and_sum_of_prices(result)
    sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
    new_result = result[0].map do |hsh|
      {
        category_name: hsh[:category_name],
        sub_category_name: hsh[:sub_category_name],
        price: hsh[:price]
      }
    end
    new_result << result[1]
    new_result << result[2]

    [new_result, sum_of_prices]
  end
end
