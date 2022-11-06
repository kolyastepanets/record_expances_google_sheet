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

      sum_of_prices = result[0].sum
      expect(result).to eq([[2.99, 1.5, 3.0, 1.35, 2.95, 0.55, 3.78, 1.5, 2.29, 4.04], 23.95, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>2.99 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
      #       {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Бакалея",  :price=>1.35 },
      #       {:category_name=>"Еда", :sub_category_name=>"Бакалея",  :price=>2.95 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.55 },
      #       {:category_name=>nil,   :sub_category_name=>nil,        :price=>3.78 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
      #       {:category_name=>nil,   :sub_category_name=>nil,        :price=>2.29 },
      #       {:category_name=>nil,   :sub_category_name=>nil,        :price=>4.04 }
      #     ],
      #     23.95,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 2', freezed_time: '2022-09-21T22:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out03.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[2.65, 2.85, 1.55, 1.75, 3.35, 1.2, 1.09, 0.6, 1.29, 5.5, 2.03, 2.73, 2.99], 29.58, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости",         :price=>2.65 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости",         :price=>2.85 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости",         :price=>1.55 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",          :price=>1.75 },
      #       {:category_name=>"Еда", :sub_category_name=>"К пиву",           :price=>3.35 },
      #       {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.2  },
      #       {:category_name=>"Еда", :sub_category_name=>"Мясо",             :price=>1.09 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости",         :price=>0.6  },
      #       {:category_name=>"Еда", :sub_category_name=>"Мясо",             :price=>1.29 },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>5.5  },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.03 },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.73 },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>2.99 }
      #     ],
      #     29.58,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 3', freezed_time: '2022-09-24T20:08:00+00:00' do
    # TO IMPORVE RECOGNISE, CAN BE DONE BETTER
    let(:get_telegram_image) { File.read("spec/images/out09.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[1.5, 1.6, 1.5, 1.75, 0.93, 5.29, 3.99], 16.56, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.5  },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.6  },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>1.75 },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>0.93 },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>5.29 },
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>3.99 }
      #     ],
      #     16.56,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 1', freezed_time: '2022-09-21T22:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out02.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[1.99, 1.79, 1.99], 5.77, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.99},
      #       {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.79},
      #       {:category_name=>nil,   :sub_category_name=>nil,                :price=>1.99}
      #     ],
      #     5.77,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 2', freezed_time: '2022-09-21T22:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out04.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[1.85, 1.45, 1.67, 2.99, 1.95, 9.99], 19.9, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда", :sub_category_name=>"К пиву",   :price=>1.85 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.45 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.67 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>2.99 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.95 },
      #       {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>9.99 }
      #     ],
      #     19.9,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 4', freezed_time: '2022-10-04T19:21:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out12.jpeg") }

    it 'return 3 values' do
      result = subject
      # binding.pry
      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[1.6, 1.25, 1.85, 1.85, 3.89, 1.4, 1.99, 2.55], 16.38, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда", :sub_category_name=>"К пиву",   :price=>1.85 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.45 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.67 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>2.99 },
      #       {:category_name=>"Еда", :sub_category_name=>"Молочка",  :price=>1.95 },
      #       {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>9.99 }
      #     ],
      #     19.9,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  # Very bad photo, probably not good example for test
  # photo should be as straight as possible
  xcontext 'when receipt sainsbury 1', freezed_time: '2022-09-22T08:13:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out05.jpeg") }

    it 'return 3 values' do
      result = subject
      # binding.pry
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>2.75 },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>13.0 },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>2.05 },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>2.0  },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>2.0  },
      #       {:category_name=>"Для дома", :sub_category_name=>"Инвентарь",             :price=>2.5  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.7  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Мясо",                  :price=>5.3  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Мясо",                  :price=>3.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.35 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>2.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>2.5  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>1.1  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.7  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.5  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.6  },
      #       {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>2.35 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.4  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.35 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.5  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.35 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Рыба",                  :price=>2.25 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Рыба",                  :price=>2.75 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>2.2  },
      #       {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>2.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>2.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0  },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>1.0  },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>1.0  },
      #       {:category_name=>nil,        :sub_category_name=>nil,                     :price=>2.75 }
      #     ],
      #     74.95,
      #     nil
      #   ]
      # )
      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[2.75, 13.0, 2.05, 2.0, 2.0, 2.5, 1.7, 5.3, 3.0, 1.35, 2.0, 2.5, 1.1, 1.0, 1.7, 1.5, 1.6, 2.35, 1.4, 1.35, 1.5, 1.35, 2.25, 2.75, 2.2, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.75], 74.95, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt', freezed_time: '2022-09-22T13:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out08.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq( [[19.99, 1.1, 2.0, 2.0, 1.5, 1.5, 1.5, 0.9, 2.5, 1.5, 1.25, 1.5, 1.0, 1.0, 1.0, 1.0, 2.5, 7.33, 1.55, 0.35, 0.5, 2.3, 2.3, 1.55, 1.66, 2.0, 2.2, 2.0, 2.0, 2.4, 1.12, 1.55, 1.0, 3.5, 2.1, 3.95, 1.7, 2.4, 2.5, 2.2, 2.0, 2.55, 1.95, 0.05, 2.0, 1.25, 1.5], 105.2, nil])
      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда",      :sub_category_name=>"Алкоголь",              :price=>19.99 },
      #       {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>1.1   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>0.9   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Специи, приправы",      :price=>2.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.25  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Вода",                  :price=>1.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>1.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Кофе, Чай",             :price=>2.5   },
      #       {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>7.33  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.55  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>0.35  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Специи, приправы",      :price=>0.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>2.3   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>2.3   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>1.55  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.66  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>2.2   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.4   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Мясо",                  :price=>1.12  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>1.55  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>1.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Рыба",                  :price=>3.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Сладости",              :price=>2.1   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Колбаса, сосиски",      :price=>3.95  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Хлеб и др",             :price=>1.7   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Специи, приправы",      :price=>2.4   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Кофе, Чай",             :price=>2.5   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.2   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"Фрукты",                :price=>2.55  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.95  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>0.05  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Овощи",                 :price=>2.0   },
      #       {:category_name=>"Еда",      :sub_category_name=>"К пиву",                :price=>1.25  },
      #       {:category_name=>"Еда",      :sub_category_name=>"Молочка",               :price=>1.5   }
      #     ],
      #     105.2,
      #     nil
      #   ]
      # )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt 1', freezed_time: '2022-10-14T16:15:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out15.jpeg") }

    it 'return 3 values' do
      result = subject
      # binding.pry
      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[19.99, 2.0, 2.0, 1.5, 1.0, 1.25, 1.9, 2.2, 3.45, 1.0, 2.4, 1.65, 2.1, 1.39, 2.5, 1.2, 1.4, 1.0, 1.0, 0.7, 3.5, 2.1, 2.15, 1.4, 1.05, 1.5, 2.0, 5.25, 6.53, 1.5, 2.2, 3.3, 2.5, 1.95, 1.95, 3.29, 2.35, 2.35, 3.09, 3.0, 2.0, 2.5, 2.0, 1.95, 5.6, 2.0, 2.95, 1.45, 3.5, 0.8, 0.8, 3.0, 1.35, 1.6, 1.65], 137.65, nil])
      expect(sum_of_prices).to eq(result[1] + 0.09)
    end
  end

  context 'when receipt marks and spencer 1', freezed_time: '2022-09-26T18:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out10.jpeg") }

    it 'return 3 values' do
      result = subject

      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.76 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Мясо",     :price=>1.3  },
      #       {:category_name=>"Еда", :sub_category_name=>"Мясо",     :price=>4.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.75 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.65 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.65 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.25 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.25 }
      #     ],
      #     24.11,
      #     nil
      #   ]
      # )
      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[0.76, 1.5, 1.5, 1.3, 4.0, 2.5, 2.75, 2.0, 2.0, 0.65, 0.65, 2.25, 2.25], 24.11, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 1', freezed_time: '2022-10-10T20:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out13.jpeg") }

    it 'return 3 values' do
      result = subject

      # sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      # expect(result).to eq(
      #   [
      #     [
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.76 },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Мясо",     :price=>1.3  },
      #       {:category_name=>"Еда", :sub_category_name=>"Мясо",     :price=>4.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.5  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.75 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.0  },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.65 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>0.65 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.25 },
      #       {:category_name=>"Еда", :sub_category_name=>"Фрукты",   :price=>2.25 }
      #     ],
      #     24.11,
      #     nil
      #   ]
      # )
      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[2.1, 2.1, 2.1, 4.25, 1.45, 2.3, 2.95, 1.95, 0.3], 19.5, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 1', freezed_time: '2022-11-06T04:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out06.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum.round(2)
      expect(result).to eq([[41700.0, 6900.0, 32900.0, 4500.0, 23000.0, 18500.0, 11500.0, 22500.0, 49522.0, 9699.0, 33509.0, 92500.0, 45348.0, 38570.0, 57000.0, 47400.0, 18400.0, 65000.0], 618448.0, nil])
      expect(sum_of_prices).to eq(result[1])
    end
  end
end
