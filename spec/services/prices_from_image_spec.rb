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

  context 'when receipt tesco 3', freezed_time: '2024-05-30T21:01:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out02.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.8900000000000001},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.15},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>5.0},
        19.64,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 4', freezed_time: '2024-06-02T16:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out03.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.8},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.8},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.15},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.7},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.7},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>5.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.1},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.1},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.19},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.15},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.39},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.8},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.2},
        {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.85},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.29},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.95},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.4},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>2.95},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>5.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>15.0},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>6.8},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.7},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.35},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.94},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.4},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>4.5},
        118.92,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 5', freezed_time: '2024-06-13T16:53:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out04.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.38},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>6.75},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.46},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.15},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.38},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.3},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.85},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.6},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.7},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.15},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.3},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.3},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>6.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.59},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>9.45},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>2.66},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.8},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.4},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.52},
        {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.65},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.5},
        100.29,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 6', freezed_time: '2024-06-21T19:23:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out05.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.3},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>7.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.3},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.8},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.65},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.25},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.6},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.1},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.85},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.9},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>6.6},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>7.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.49},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.95},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>2.66},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.25},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.4},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.09},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.6},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>2.25},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.95},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.4},
        99.63,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 7', freezed_time: '2024-07-03T21:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out06.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.3},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.3},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.05},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.15},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.6},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.52},
        27.17,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 8', freezed_time: '2024-07-09T19:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out07.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.55},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.49},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.7},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>5.3},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>7.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>5.2},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.39},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.69},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.8},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.2},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.99},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.3},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>2.66},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.4},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>6.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.65},
        {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>14.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.24},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>6.2},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.8},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>0.55},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.4},
        {:category_name=>"Еда", :sub_category_name=>"Готовая", :price=>2.4},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.8},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.3},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.52},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>0.7},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.79},
        144.88,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 9', freezed_time: '2024-07-17T18:04:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out08.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.05},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>5.5},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>6.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.6},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.98},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.18},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.4},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.64},
        {:category_name=>"Еда", :sub_category_name=>"Готовая", :price=>3.25},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>5.5},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.19},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.8},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.6},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.4},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>5.75},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.33},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>2.65},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.19},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.3},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.4},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.9},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.79},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>5.45},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.15},
        {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>14.5},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.52},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.6},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.79},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.9},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.31},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.7},
        154.01,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 10', freezed_time: '2024-08-07T13:09:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out09.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.2},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.8},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>5.5},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.55},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.0},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.85},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.7},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.39},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.9},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.4},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.9},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.2},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>8.2},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.6},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>5.0},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>2.3},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>0.62},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.47},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.7},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>5.3},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.35},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.65},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.25},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.95},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.2},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Готовая", :price=>1.7},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>2.95},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.05},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.15},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.52},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.6},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>16.75},
        154.01,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 11', freezed_time: '2024-08-18T21:34:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/tesco/out10.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.55},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.38},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.57},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.2},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.54},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>5.55},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>5.5},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.5},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>4.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>5.95},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>6.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.75},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.7},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.65},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>3.0},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>5.5},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.95},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.45},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.79},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3.9},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.0},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>4.9},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.0},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.5},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.6},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.5},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.8},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.38},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.41},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>3.98},
        127.95,
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
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.39},
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
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.8099999999999999},
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

  context 'when receipt lidl 12', freezed_time: '2024-06-01T20:51:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out12.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.38},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.39},
        3.56,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 13', freezed_time: '2024-06-01T20:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out13.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.78},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.99},
        6.56,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 14', freezed_time: '2024-06-03T20:29:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out14.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.52},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.39},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.38},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.48},
        16.78,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 15', freezed_time: '2024-06-04T19:51:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out15.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.04},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.82},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.09},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.09},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.99},
        17.85,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 16', freezed_time: '2024-06-05T16:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out16.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.09},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.15},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.59},
        7.72,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 17', freezed_time: '2024-06-06T19:18:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out17.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.31},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.49},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.05},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.39},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.29},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.38},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.79},
        13.59,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 18', freezed_time: '2024-06-07T21:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out18.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.69},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.09},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.18},
        19.07,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 19', freezed_time: '2024-06-10T20:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out19.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.09},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.19},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.78},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.49},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.19},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>2.99},
        21.78,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 20', freezed_time: '2024-06-11T17:37:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out20.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.93},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.29},
        3.71,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 21', freezed_time: '2024-06-14T17:47:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out21.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.95},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.39},
        {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>3.59},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.69},
        8.22,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 22', freezed_time: '2024-06-14T17:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out22.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.19},
        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>0.6},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>4.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.85},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.39},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.45},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.89},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.78},
        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.15},
        29.1,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 23', freezed_time: '2024-06-18T18:58:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out23.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>0.59},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>4.99},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>1.19},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.85},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.7},
        15.3,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 24', freezed_time: '2024-06-18T19:02:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out24.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.85},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.19},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.35},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.38},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.79},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.61},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.78},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.48},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.85},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.79},
        26.3,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 25', freezed_time: '2024-06-20T21:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out25.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.85},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.45},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.29},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.29},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.09},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.05},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.49},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.69},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.89},
        26.07,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 26', freezed_time: '2024-06-30T17:02:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out26.png") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>7.52},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>6.92},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>6.26},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>5.84},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>4.49},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.58},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.14},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.6},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.6},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.42},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>2.51},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.2},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.1399999999999997},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.02},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.88},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.78},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.79},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>1.7},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.61},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.52},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.52},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.52},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.52},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.4300000000000002},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.3},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.34},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.25},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>1.1600000000000001},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.9800000000000001},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.9800000000000001},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.85},
        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>0.81},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>0.76},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.5800000000000001},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.35000000000000003},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.31},
        83.86,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 27', freezed_time: '2024-07-12T19:32:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out27.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.99},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>0.65},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>2.39},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>4.99},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.09},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.05},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.29},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.39},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.39},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.99},
        30.48,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 28', freezed_time: '2024-07-17T18:40:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out28.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.1},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.79},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>3.98},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.39},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>4.78},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>5.99},
        21.02,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 29', freezed_time: '2024-07-23T18:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out29.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.75},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.19},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.45},
        11.35,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 30', freezed_time: '2024-08-10T11:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out30.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.2400000000000002},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.9899999999999999},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.01},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>4.99},
        {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>6.99},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>4.99},
        22.19,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 31', freezed_time: '2024-08-11T15:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out31.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>0.6300000000000001},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.89},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.59},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.89},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.39},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.78},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.49},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>0.39},
        10.44,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt lidl 32', freezed_time: '2024-08-11T15:47:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/lidl/out32.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result, sum_of_prices = new_result_and_sum_of_prices(result)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>3.38},
        {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>3.75},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.65},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>2.49},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.19},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.45},
        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>10.49},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>3.39},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.08},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.99},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.89},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.98},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.69},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>2.69},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.97},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.99},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.69},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.09},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>1.99},
        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>0.75},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.98},
        59.32,
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
