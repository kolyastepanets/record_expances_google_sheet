require 'rails_helper'

RSpec.describe PricesFromImage, vcr: true do
  subject { described_class.call(message_params) }

  let(:message_params) do
  end

  before do
    allow_any_instance_of(described_class).to receive(:get_telegram_image).and_return(get_telegram_image)
  end

  context 'when full_parsed_line', freezed_time: '2023-12-24T05:06:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out02.jpg") }

    it 'returns it as string' do
      result = subject

      expect(result).to eq(
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.79, :full_parsed_line=>"AMOY, LIGHT, SOY, SAUCE, 1.79"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"}],
        5.77,
        nil]
      )
    end
  end

  context 'when receipt polish shop 1', freezed_time: '2022-09-21T21:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out01.jpg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.0},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.35},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>2.95},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.55},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.78},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.29},
          {:category_name=>nil, :sub_category_name=>nil, :price=>4.04},
         23.95,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 2', freezed_time: '2022-09-21T22:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out03.jpg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.65},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.85},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.55},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.75},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.35},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.2},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.09},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.6},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.29},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.03},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.73},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.99},
         29.58,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 3', freezed_time: '2022-09-24T20:08:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out09.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.6},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.75},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.93},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.29},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.99},
          16.56,
          nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 1', freezed_time: '2022-09-21T22:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out02.jpg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>nil, :sub_category_name=>nil, :price=>1.99},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.79},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.99},
         5.77,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 2', freezed_time: '2022-09-21T22:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out04.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.85},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.45},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.67},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95},
          {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>9.99},
         19.9,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 4', freezed_time: '2022-10-04T19:21:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out12.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.6},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.25},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.85},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.85},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.89},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.4},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.99},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.55},
          16.38,
          nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt', freezed_time: '2022-09-22T13:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out08.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.1},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.9},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.5},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.25},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.5},
          {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>7.33},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.55},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.35},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.5},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.3},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.3},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.55},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.66},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.2},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.4},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.12},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.55},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.0},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.1},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.95},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.7},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.4},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.5},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.55},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.05},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.25},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5},
         105.2,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt 1', freezed_time: '2022-10-14T16:15:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out15.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.25},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.9},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.2},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.45},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.4},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.65},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.1},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.39},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.2},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.4},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.7},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.1},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.15},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.4},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.05},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.25},
          {:category_name=>nil, :sub_category_name=>nil, :price=>6.53},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.2},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.3},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.5},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.29},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.35},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.35},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.09},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.5},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.95},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.6},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.95},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.45},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.5},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.8},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.8},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.0},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.35},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.65},
         137.65,
         nil]
      )
      expect(sum_of_prices).to eq(result[1] + 0.09)
    end
  end

  context 'when receipt marks and spencer 1', freezed_time: '2022-09-26T18:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out10.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.76},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.3},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.75},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.65},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.65},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25},
         24.11,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt marks and spencer 2', freezed_time: '2024-05-17T20:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/m_and_s/out01.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Готовая", :price=>3.75},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.15},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.15},
        11.05,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt marks and spencer 3', freezed_time: '2024-05-25T18:47:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/m_and_s/out02.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25},
          {:category_name=>"Еда", :sub_category_name=>"Готовая", :price=>2.5},
          4.75,
          nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 1', freezed_time: '2022-10-10T20:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out13.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.1},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.1},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.1},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.25},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.3},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.95},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.95},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.3},
        19.5,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 2', freezed_time: '2024-05-21T20:41:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out01.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.38},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.3},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.59},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.3},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.3},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.95},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.85},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>2.66},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>2.5},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.4},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.5},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>7.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.05},
        {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>0.42},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.79},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>0.85},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.4},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.1},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.95},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>6.5},
        90.16,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
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

  context 'when receipt sainsbury 1', freezed_time: '2024-05-08T17:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/sainsbury/out01.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>10.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.4},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.3},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>10.0},
        {:category_name=>"Для дома", :sub_category_name=>"Аптека", :price=>3.9},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>15.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.55},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.55},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.8},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>1.1},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.25},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.15},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.25},
        78.7,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 1', freezed_time: '2024-05-17T20:50:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out01.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.9},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.65},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.45},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.55},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.69},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.15},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.29},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.19},
        10.62,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 2', freezed_time: '2024-05-17T21:08:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out02.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>3.15},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.15},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.89},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>6.79},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.09},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.48},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.77},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.39},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.99},
        28.64,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 3', freezed_time: '2024-05-17T21:28:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out03.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.2},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.99},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.89},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.09},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.29},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>2.35},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.49},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>8.49},
        29.16,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 4', freezed_time: '2024-05-20T21:14:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out04.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>4.59},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>3.09},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.09},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.49},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.95},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.09},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.99},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>2.59},
        18.88,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 5', freezed_time: '2024-05-22T17:07:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out05.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>6.49},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.99},
        8.48,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 6', freezed_time: '2024-05-22T19:42:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out06.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.8099999999999999},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.78},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.55},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.95},
        8.88,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 7', freezed_time: '2024-05-23T21:04:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out07.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.44},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.49},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.99},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>3.49},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.79},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.89},
        18.08,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 8', freezed_time: '2024-05-25T20:13:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out08.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.79},
        {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>4.95},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.89},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.78},
        20.36,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 9', freezed_time: '2024-05-29T07:26:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out09.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.15},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.61},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.89},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.79},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.48},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.52},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.79},
        19.5,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 10', freezed_time: '2024-05-29T16:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out10.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>14.99},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>6.99},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.65},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.15},
        32.91,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 11', freezed_time: '2024-05-30T20:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out11.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.06},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.45},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>5.75},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.19},
        10.44,
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
