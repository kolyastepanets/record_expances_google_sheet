require 'rails_helper'

RSpec.describe PricesFromImage, vcr: true do
  subject { described_class.call(message_params) }

  let(:message_params) do
  end

  before do
    allow_any_instance_of(described_class).to receive(:get_telegram_image).and_return(get_telegram_image)
  end

  context 'when receipt polish shop 1', freezed_time: '2022-09-21T21:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out01.jpg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>2.99 },
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.0  },
              {:category_name=>"Еда", :sub_category_name=>"Бакалея",  :price=>1.35 },
              {:category_name=>"Еда", :sub_category_name=>"Бакалея",  :price=>2.95 },
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.55 },
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.78 },
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.29 },
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>4.04 }
            ],
            23.95,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum
        expect(result).to eq([[2.99, 1.5, 3.0, 1.35, 2.95, 0.55, 3.78, 1.5, 2.29, 4.04], 23.95, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 2', freezed_time: '2022-09-21T22:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out03.jpg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.65 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.85 },
              {:category_name=>"Еда", :sub_category_name=>"Сладости",         :price=>1.55 },
              {:category_name=>"Еда", :sub_category_name=>"Молочка",          :price=>1.75 },
              {:category_name=>"Еда", :sub_category_name=>"К пиву",           :price=>3.35 },
              {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.2  },
              {:category_name=>"Еда", :sub_category_name=>"Мясо",             :price=>1.09 },
              {:category_name=>"Еда", :sub_category_name=>"Сладости",         :price=>0.6  },
              {:category_name=>"Еда", :sub_category_name=>"Мясо",             :price=>1.29 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>5.5  },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.03 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.73 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.99 }
            ],
            29.58,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[2.65, 2.85, 1.55, 1.75, 3.35, 1.2, 1.09, 0.6, 1.29, 5.5, 2.03, 2.73, 2.99], 29.58, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 3', freezed_time: '2022-09-24T20:08:00+00:00' do
    # TO IMPORVE RECOGNISE, CAN BE DONE BETTER
    let(:get_telegram_image) { File.read("spec/images/out09.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.5  },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.6  },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.5  },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.75 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>0.93 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>5.29 },
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>3.99 }
            ],
            16.56,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[1.5, 1.6, 1.5, 1.75, 0.93, 5.29, 3.99], 16.56, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 1', freezed_time: '2022-09-21T22:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out02.jpg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.99},
              {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.79},
              {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.99}
            ],
            5.77,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[1.99, 1.79, 1.99], 5.77, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 2', freezed_time: '2022-09-21T22:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out04.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"К пиву",   :price=>1.85 },
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.45 },
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.67 },
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>2.99 },
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.95 },
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>9.99 }
            ],
            19.9,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[1.85, 1.45, 1.67, 2.99, 1.95, 9.99], 19.9, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 4', freezed_time: '2022-10-04T19:21:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out12.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>nil, :sub_category_name=>nil,  :price=>1.6  },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>1.25 },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>1.85 },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>1.85 },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>3.89 },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>1.4  },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>1.99 },
              {:category_name=>nil, :sub_category_name=>nil,  :price=>2.55 },
            ],
            16.38,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[1.6, 1.25, 1.85, 1.85, 3.89, 1.4, 1.99, 2.55], 16.38, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt', freezed_time: '2022-09-22T13:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out08.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда",      :sub_category_name=>"Алкоголь",              :price=>19.99 },
              {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>1.1   },
              {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>0.9   },
              {:category_name=>"Еда",      :sub_category_name=>"Специи, приправы",      :price=>2.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.25  },
              {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Кофе, Чай",             :price=>2.5   },
              {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>7.33  },
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.55  },
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>0.35  },
              {:category_name=>"Еда",      :sub_category_name=>"Специи, приправы",      :price=>0.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>2.3   },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>2.3   },
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.55  },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.66  },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>2.2   },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.4   },
              {:category_name=>"Еда",      :sub_category_name=>"Мясо",                  :price=>1.12  },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>1.55  },
              {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>1.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Рыба",                  :price=>3.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>2.1   },
              {:category_name=>"Еда",      :sub_category_name=>"Колбаса, сосиски",      :price=>3.95  },
              {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>1.7   },
              {:category_name=>"Еда",      :sub_category_name=>"Специи, приправы",      :price=>2.4   },
              {:category_name=>"Еда",      :sub_category_name=>"Кофе, Чай",             :price=>2.5   },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.2   },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>2.55  },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.95  },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>0.05  },
              {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
              {:category_name=>"Еда",      :sub_category_name=>"К пиву",                :price=>1.25  },
              {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.5   }
            ],
            105.2,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq( [[19.99, 1.1, 2.0, 2.0, 1.5, 1.5, 1.5, 0.9, 2.5, 1.5, 1.25, 1.5, 1.0, 1.0, 1.0, 1.0, 2.5, 7.33, 1.55, 0.35, 0.5, 2.3, 2.3, 1.55, 1.66, 2.0, 2.2, 2.0, 2.0, 2.4, 1.12, 1.55, 1.0, 3.5, 2.1, 3.95, 1.7, 2.4, 2.5, 2.2, 2.0, 2.55, 1.95, 0.05, 2.0, 1.25, 1.5], 105.2, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt 1', freezed_time: '2022-10-14T16:15:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out15.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.5},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.25},
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.9},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.2},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.45},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>1.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.4},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.65},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.1},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.39},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.5},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.2},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.4},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи",    :price=>0.7},
              {:category_name=>"Еда", :sub_category_name=>"Овощи",    :price=>3.5},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.1},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.15},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.4},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.05},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.5},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>5.25},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>6.53},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.5},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.2},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.3},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.5},
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.95},
              {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.95},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.29},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.35},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.35},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.09},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи",    :price=>2.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.5},
              {:category_name=>"Еда", :sub_category_name=>"Овощи",    :price=>2.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.95},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>5.6},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.95},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.45},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.5},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>0.8},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>0.8},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.0},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.35},
              {:category_name=>"Еда", :sub_category_name=>"Овощи",    :price=>1.6},
              {:category_name=>nil,   :sub_category_name=>nil,        :price=>1.65}
            ],
            137.65,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[19.99, 2.0, 2.0, 1.5, 1.0, 1.25, 1.9, 2.2, 3.45, 1.0, 2.4, 1.65, 2.1, 1.39, 2.5, 1.2, 1.4, 1.0, 1.0, 0.7, 3.5, 2.1, 2.15, 1.4, 1.05, 1.5, 2.0, 5.25, 6.53, 1.5, 2.2, 3.3, 2.5, 1.95, 1.95, 3.29, 2.35, 2.35, 3.09, 3.0, 2.0, 2.5, 2.0, 1.95, 5.6, 2.0, 2.95, 1.45, 3.5, 0.8, 0.8, 3.0, 1.35, 1.6, 1.65], 137.65, nil])
      end
      expect(sum_of_prices).to eq(result[1] + 0.09)
    end
  end

  context 'when receipt marks and spencer 1', freezed_time: '2022-09-26T18:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out10.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.76 },
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
              {:category_name=>"Еда", :sub_category_name=>"Мясо",     :price=>1.3  },
              {:category_name=>"Еда", :sub_category_name=>"Мясо",     :price=>4.0  },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.5  },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.75 },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.0  },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.0  },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.65 },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.65 },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.25 },
              {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.25 }
            ],
            24.11,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[0.76, 1.5, 1.5, 1.3, 4.0, 2.5, 2.75, 2.0, 2.0, 0.65, 0.65, 2.25, 2.25], 24.11, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 1', freezed_time: '2022-10-10T20:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out13.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>nil, :sub_category_name=>nil,   :price=>2.1 },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>2.1  },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>2.1  },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>4.25  },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>1.45  },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>2.3  },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>2.95 },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>1.95  },
              {:category_name=>nil, :sub_category_name=>nil,   :price=>0.3  },
            ],
            19.5,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[2.1, 2.1, 2.1, 4.25, 1.45, 2.3, 2.95, 1.95, 0.3], 19.5, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 1', freezed_time: '2022-11-06T04:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out06.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
              {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6900.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32900.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4500.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>23000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>18500.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>11500.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22500.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>49522.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>9699.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33509.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>92500.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>45348.0},
              {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>38570.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
              {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47400.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18400.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>65000.0}
            ],
            618448.0,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[41700.0, 6900.0, 32900.0, 4500.0, 23000.0, 18500.0, 11500.0, 22500.0, 49522.0, 9699.0, 33509.0, 92500.0, 45348.0, 38570.0, 57000.0, 47400.0, 18400.0, 65000.0], 618448.0, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 2', freezed_time: '2022-11-18T08:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out07.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>61424.0},
              {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56500.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>33000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9900.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9300.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>21200.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9900.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>100500.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9300.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>12500.0},
              {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>37000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>12500.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>11000.0},
              {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>40000.0},
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>84500.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>33495.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>137500.0},
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>15300.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31812.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15360.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>85000.0},
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>28500.0},
              {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>42000.0},
              {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>42400.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>12500.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>28000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>78210.0},
              {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>6800.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18500.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>79500.0}
            ],
            1312901.0,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[61424.0, 12000.0, 56500.0, 33000.0, 9900.0, 9300.0, 21200.0, 9900.0, 100500.0, 9300.0, 41700.0, 12500.0, 37000.0, 12500.0, 11000.0, 40000.0, 84500.0, 33495.0, 137500.0, 15300.0, 31812.0, 15360.0, 85000.0, 28500.0, 24000.0, 42000.0, 42400.0, 12500.0, 28000.0, 78210.0, 6800.0, 18500.0, 71800.0, 79500.0], 1312901.0, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 3', freezed_time: '2022-11-17T01:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out16.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10650.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>114000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36736.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24500.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>90500.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>10600.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24800.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19176.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60000.0},
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>116730.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>44000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>11000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>192900.0},
              {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>20500.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>52500.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>78500.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>79500.0},
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>15300.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54900.0},
              {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>45900.0},
              {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>22900.0},
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>8000.0}
            ],
            1553892.0,
            nil
          ]
        )
      else
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 4', freezed_time: '2022-11-18T01:37:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out17.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
              {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>22000.0},
              {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>156300.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>91000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
              {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>64000.0}
            ],
            809200.0,
            nil
          ]
        )
      else
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 5', freezed_time: '2022-11-18T08:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out18.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>15904.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>115000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64000.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>36330.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54900.0},
              {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>40900.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>45000.0},
              {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>50300.0},
              {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>54900.0},
              {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>22770.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55383.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10560.0}
            ],
            600947.0,
            nil
          ]
        )
      else
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 6', freezed_time: '2022-11-22T01:34:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out20.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>116730.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41514.0},
              {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12012.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>198000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54900.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>34675.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40565.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>27132.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17325.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>6000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>80200.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>18500.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>23000.0},
              {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>78000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>29000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8500.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>62500.0}
            ],
            948553.0,
            nil
          ]
        )
      else
      end
      expect(sum_of_prices).to eq(result[1] - 100) # 100 is acceptable difference
    end
  end

  context 'when receipt frestive 1', freezed_time: '2022-11-12T09:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out11.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>15000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Новопочта", :price=>38000.0},
              {:category_name=>"Еда",      :sub_category_name=>"К пиву",    :price=>282500.0},
              {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>25000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>16500.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>48000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>15000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>16000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>15000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>100000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>54000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>10000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты", :price=>78213.0},
              {:category_name=>"Еда",      :sub_category_name=>"Овощи", :price=>10220.0},
              {:category_name=>"Еда",      :sub_category_name=>"Овощи", :price=>8308.0},
              {:category_name=>"Еда",      :sub_category_name=>"Овощи", :price=>12050.0},
              {:category_name=>"Еда",      :sub_category_name=>"Овощи", :price=>18000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Молочка", :price=>40000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др", :price=>20000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Кофе, Чай", :price=>145500.0},
              {:category_name=>"Еда",      :sub_category_name=>"Алкоголь", :price=>115000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Молочка", :price=>50000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Вода", :price=>16000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Молочка", :price=>50000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Молочка", :price=>49000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты", :price=>8927.0},
              {:category_name=>"Еда",      :sub_category_name=>"Овощи", :price=>14560.0},
              {:category_name=>"Еда",      :sub_category_name=>"Мясо", :price=>60500.0},
              {:category_name=>"Еда",      :sub_category_name=>"Молочка", :price=>132000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Сладости", :price=>213000.0},
              {:category_name=>"Еда",      :sub_category_name=>"Мясо", :price=>45900.0},
              {:category_name=>"Еда",      :sub_category_name=>"Рыба", :price=>101536.0},
              {:category_name=>"Еда",      :sub_category_name=>"Мясо", :price=>23762.0},
              {:category_name=>"Еда",      :sub_category_name=>"Молочка", :price=>86458.0},
              {:category_name=>"Еда",      :sub_category_name=>"Фрукты", :price=>15953.0},
              {:category_name=>"Еда",      :sub_category_name=>"Яйца", :price=>32500.0}
            ],
            1982387.0,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[15000.0, 38000.0, 282500.0, 25000.0, 16500.0, 48000.0, 15000.0, 16000.0, 15000.0, 100000.0, 54000.0, 10000.0, 78213.0, 10220.0, 8308.0, 12050.0, 18000.0, 40000.0, 20000.0, 145500.0, 115000.0, 50000.0, 16000.0, 50000.0, 49000.0, 8927.0, 14560.0, 60500.0, 132000.0, 213000.0, 45900.0, 101536.0, 23762.0, 86458.0, 15953.0, 32500.0], 1982387.0, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 2', freezed_time: '2022-11-20T03:04:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out19.jpeg") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>34500.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
              {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>115000.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>60500.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20090.0},
              {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0},
              {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>15500.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29880.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>50952.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27500.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60500.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>54016.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33856.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18116.0},
              {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>50000.0},
              {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>45765.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>134000.0},
              {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>128000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9042.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>76000.0},
              {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>66000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20500.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>20000.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>44000.0}
            ],
            1615017.0,
            nil
          ]
        )
      else
        sum_of_prices = result[0].sum.round(2)
        expect(result).to eq([[15000.0, 38000.0, 282500.0, 25000.0, 16500.0, 48000.0, 15000.0, 16000.0, 15000.0, 100000.0, 54000.0, 10000.0, 78213.0, 10220.0, 8308.0, 12050.0, 18000.0, 40000.0, 20000.0, 145500.0, 115000.0, 50000.0, 16000.0, 50000.0, 49000.0, 8927.0, 14560.0, 60500.0, 132000.0, 213000.0, 45900.0, 101536.0, 23762.0, 86458.0, 15953.0, 32500.0], 1982387.0, nil])
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt bali direct store 1', freezed_time: '2022-11-15T10:06:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out14.png") }

    it 'return 3 values' do
      result = subject

      if ENV['PARSE_PRICE_WITH_CATEGORIES']
        sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
        expect(result).to eq(
          [
            [
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>184500.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132500.0},
              {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>145000.0},
              {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>48000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>46000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>57500.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>122000.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20000.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12500.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
              {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13500.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33000.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>91500.0},
              {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14000.0},
              {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>33500.0},
              {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>40000.0},
              {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>130000.0},
              {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>75000.0},
              {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>64500.0}
            ],
            1381000.0,
            nil
          ]
        )
      else
        sum_of_prices = 0
      end
      expect(sum_of_prices).to eq(result[1])
    end
  end
end
