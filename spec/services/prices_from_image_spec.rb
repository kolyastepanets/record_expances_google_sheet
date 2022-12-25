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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 2', freezed_time: '2022-09-21T22:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out03.jpg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt polish shop 3', freezed_time: '2022-09-24T20:08:00+00:00' do
    # TO IMPORVE RECOGNISE, CAN BE DONE BETTER
    let(:get_telegram_image) { File.read("spec/images/out09.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 1', freezed_time: '2022-09-21T22:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out02.jpg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 2', freezed_time: '2022-09-21T22:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out04.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt comberton shop 4', freezed_time: '2022-10-04T19:21:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out12.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt', freezed_time: '2022-09-22T13:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out08.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt waitrose modified receipt 1', freezed_time: '2022-10-14T16:15:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out15.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1] + 0.09)
    end
  end

  context 'when receipt marks and spencer 1', freezed_time: '2022-09-26T18:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out10.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt tesco 1', freezed_time: '2022-10-10T20:35:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out13.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 1', freezed_time: '2022-11-06T04:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out06.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 2', freezed_time: '2022-11-18T08:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out07.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 3', freezed_time: '2022-11-17T01:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out16.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 4', freezed_time: '2022-11-18T01:37:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out17.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 5', freezed_time: '2022-11-18T08:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out18.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 6', freezed_time: '2022-11-22T01:34:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out20.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1] - 100) # 100 is acceptable difference
    end
  end

  context 'when receipt pepito 7', freezed_time: '2022-11-23T03:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out21.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>50000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>40150.0},
            {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>156300.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>13410.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>13410.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19328.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9000.0}
          ],
          625698.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 8', freezed_time: '2022-11-24T02:17:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out22.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>52371.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>51388.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22140.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21560.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>25740.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27224.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>34500.0},
            {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>95019.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13120.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>26630.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>54900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>114000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29715.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36895.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>47000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25830.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>50300.0},
            {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>40500.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>62600.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>330000.0},
            {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>112500.0}
          ],
          1457432.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 9', freezed_time: '2022-11-26T07:53:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out23.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>330000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>64000.0},
            {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>60000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>75600.0}
          ],
          529600.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 10', freezed_time: '2022-11-28T05:14:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out26.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>19289.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5700.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>89974.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12515.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7994.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>53816.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54900.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>47700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>95100.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7700.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>62600.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0}
          ],
          783188.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 11', freezed_time: '2022-12-01T08:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out29.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>128000.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>169000.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>40000.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>12900.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
            {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>7900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>50700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15400.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>13500.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>14700.0},
            {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>7900.0},
            {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>7900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9500.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>22600.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5454.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>138000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>41500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>29800.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>40000.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>110300.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>27075.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>44809.0}
          ],
          1496838.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 12', freezed_time: '2022-12-05T07:54:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out32.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>621500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18260.0}
          ],
          717760.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 13', freezed_time: '2022-12-08T03:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out35.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0},
            {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>48000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>69000.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>60500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3800.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>64000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>70000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>70000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>198000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15400.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>57318.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>94387.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>29133.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>55500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>74000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0}
          ],
          1033038.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 14', freezed_time: '2022-12-11T09:14:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out36.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>7500.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>129700.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29299.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10800.0},
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0}
          ],
          737999.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 15', freezed_time: '2022-12-13T08:50:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out37.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>60500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>483000.0}
          ],
          642900.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 16', freezed_time: '2022-12-15T01:48:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out38.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>15300.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>66900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>45236.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>60003.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>45180.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>56900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11365.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>128000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>83500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>48100.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
            {:category_name=>"Марк", :sub_category_name=>"Игрушки", :price=>34900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32076.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36526.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>9900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4102.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>47200.0},
            {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>16200.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16434.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12420.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>44005.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20146.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>45000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17226.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0}
          ],
          1426820.0,
          nil
        ]
      )
      expect(sum_of_prices + 1).to eq(result[1])
    end
  end

  context 'when receipt pepito 17', freezed_time: '2022-12-18T10:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out39.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12200.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>4800.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38700.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>53900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0}
          ],
          289100.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 18', freezed_time: '2022-12-20T05:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out40.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>80700.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1900.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>16500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>44234.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>69000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>95400.0},
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>2900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>38208.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>39600.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>27000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>65000.0}
          ],
          1466342.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 19', freezed_time: '2022-12-25T03:16:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out41.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>24000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60900.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>95800.0},
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>116730.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>28380.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>57663.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>57960.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9835.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>15819.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
            {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>24500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>138000.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>49000.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>89400.0},
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>77500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>69000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6300.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>34500.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>55300.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>30900.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15000.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>27000.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>56900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7000.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>59000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>50700.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>20000.0},
            {:category_name=>"Лиля", :sub_category_name=>"Ванные принадлежности", :price=>16900.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>4000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>23000.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>4900.0},
            {:category_name=>"Для дома", :sub_category_name=>"Инвентарь", :price=>4900.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>53900.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>33500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52900.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>90000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>69900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21897.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>38349.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23600.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>49000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>29800.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15790.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9630.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10954.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>6975.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21780.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7808.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>65500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60000.0}
          ],
          2635070.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 1', freezed_time: '2022-11-12T09:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out11.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 2', freezed_time: '2022-11-20T03:04:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out19.jpeg") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 3', freezed_time: '2022-11-26T07:58:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out24.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>352500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39624.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31635.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>36000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>119000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>52580.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>57684.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35150.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>10000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60368.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32000.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21930.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17673.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13462.0}
          ],
          1272406.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 4', freezed_time: '2022-11-27T07:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out25.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31857.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>37560.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>38080.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>24583.0},
            {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>29500.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>124533.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25382.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11410.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>61000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13674.0}
          ],
          488079.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 5', freezed_time: '2022-11-29T09:07:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out27.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0},
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>67913.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15390.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>73500.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>63000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16264.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>19000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0},
            {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>131596.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>39406.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>50840.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>134000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>66500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>202500.0}
          ],
          1082409.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 6', freezed_time: '2022-12-01T03:14:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out28.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>320775.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>66500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>134000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>56196.0},
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40680.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40061.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>13510.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>30115.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42021.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39192.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16985.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15000.0}
          ],
          1221535.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 7', freezed_time: '2022-12-02T08:49:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out30.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0},
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21930.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>110500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0}
          ],
          292930.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 8', freezed_time: '2022-12-04T08:45:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out31.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>286500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>49016.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39836.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35406.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0},
            {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>128500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21156.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>145500.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>33000.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>59150.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>114500.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>35000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56672.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>76405.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>40500.0},
            {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>79288.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>134000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>35500.0}
          ],
          1741929.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 9', freezed_time: '2022-12-06T05:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out33.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>39879.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39900.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40455.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>58500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18320.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0},
            {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>133934.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22145.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14500.0}
          ],
          793133.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 10', freezed_time: '2022-12-08T01:40:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out34.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>43425.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39284.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>54000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16082.0},
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>37000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9310.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>108955.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3773.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>66500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>12642.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>134000.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0}
          ],
          957971.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 11', freezed_time: '2022-12-11T09:52:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out36.jpg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>21500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>59400.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11760.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>23923.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>6500.0},
            {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>146292.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0}
          ],
          474375.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 12', freezed_time: '2022-12-13T06:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out37.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>13000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0},
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>147500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13500.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>15308.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>33500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14320.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22790.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46710.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>22000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0}
          ],
          734628.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 13', freezed_time: '2022-12-14T09:52:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out38.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>110500.0},
            {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45570.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41535.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20640.0},
            {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>173020.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45475.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>64812.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>35000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0}
          ],
          665552.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 14', freezed_time: '2022-12-18T10:08:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out39.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [
          [
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29862.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18146.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>95500.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>95500.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>40500.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>23000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4500.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3000.0},
            {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3500.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40388.0},
            {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>74640.0},
            {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5934.0},
            {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18980.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29892.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33630.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>43977.0},
            {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>66822.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9082.0},
            {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>104000.0},
            {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0},
            {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>44500.0},
            {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>19500.0},
            {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>67000.0}
          ],
          1418353.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt bali direct store 1', freezed_time: '2022-11-15T10:06:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/out14.png") }

    it 'return 3 values' do
      result = subject

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
      expect(sum_of_prices).to eq(result[1])
    end
  end
end
