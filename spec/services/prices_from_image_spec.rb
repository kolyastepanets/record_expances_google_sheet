require 'rails_helper'

RSpec.describe PricesFromImage, vcr: true do
  subject { described_class.call(message_params) }

  let(:message_params) do
  end

  before do
    allow_any_instance_of(described_class).to receive(:get_telegram_image).and_return(get_telegram_image)
  end

  # context 'when receipt polish shop 1', freezed_time: '2022-09-21T21:31:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out01.jpg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99, :full_parsed_line=>"MASLO, POLSKIE, 200G, M, £, 2.99"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"CZEKOLADA, ORZECHOWA, £, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.0, :full_parsed_line=>"2, @, 1.50, £, 3.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.35, :full_parsed_line=>"KASZA, JECZMIENNA, SRE, £, 1.35"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>2.95, :full_parsed_line=>"KASZA, GRYCZANA, 400G, £, 2.95"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.55, :full_parsed_line=>"KINDER, MLECZNA, KANAP, £, 0.55"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.78, :full_parsed_line=>"Grocery, £, 3.78"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"Kinder, joy, 20g, £, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.29, :full_parsed_line=>"Grocery, £, 2.29"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>4.04, :full_parsed_line=>"Grocery, £, 4.04"}],
  #        23.95,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt polish shop 2', freezed_time: '2022-09-21T22:25:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out03.jpg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>2.65, :full_parsed_line=>"1, £, 2.65"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.85, :full_parsed_line=>"£, 2.85"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.55, :full_parsed_line=>"Schogetten, czekolada, 1.55"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.75, :full_parsed_line=>"SEREK, MILANDIA, SMIET, £, 1.75"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.35, :full_parsed_line=>"MINI, GOLKA, 160G, £, 3.35"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.2, :full_parsed_line=>"BURACZKI, PAP, CEB, 460, £, 1.20"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.09, :full_parsed_line=>"Butchery, £, 1.09"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.6, :full_parsed_line=>"OREO, 30g, £, 0.60"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.29, :full_parsed_line=>"Butchery, £, 1.29"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>5.5, :full_parsed_line=>"Fruit, &, Veg, £, 5.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.03, :full_parsed_line=>"Fruit, &, Veg, £, 2.03"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.73, :full_parsed_line=>"Fruit, &, Veg, £, 2.73"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.99, :full_parsed_line=>"Grocery, £, 2.99"}],
  #        29.58,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt polish shop 3', freezed_time: '2022-09-24T20:08:00+00:00' do
  #   # TO IMPORVE RECOGNISE, CAN BE DONE BETTER
  #   let(:get_telegram_image) { File.read("spec/images/out09.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"£, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.6, :full_parsed_line=>"£, 1.60"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"£, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.75, :full_parsed_line=>"£, 1.75"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>0.93, :full_parsed_line=>"£, 0.93"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>5.29, :full_parsed_line=>"£, 5.29"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.99, :full_parsed_line=>"Grocery, £, 3.99"}],
  #        16.56,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt comberton shop 1', freezed_time: '2022-09-21T22:27:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out02.jpg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.79, :full_parsed_line=>"AMOY, LIGHT, SOY, SAUCE, 1.79"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"}],
  #        5.77,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt comberton shop 2', freezed_time: '2022-09-21T22:35:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out04.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.85, :full_parsed_line=>"WALKERS, CRISPS, CHEESE, &, 1.85"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.45, :full_parsed_line=>"COOP, MOZZARELLA, 1.45"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.67, :full_parsed_line=>"ELMLEA, DOUBLE, 1.67"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99, :full_parsed_line=>"LURPAK, BUTTER, SLIGHTLY, S, 2.99"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"COOP, 4PT, WHOLE, FRESH, MIL, -1.95"},
  #         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>9.99, :full_parsed_line=>"BEEFSTK, &, LIBERTY, MALBEC, 9.99"}],
  #        19.9,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt comberton shop 4', freezed_time: '2022-10-04T19:21:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out12.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.6, :full_parsed_line=>"COOP, 2PT, WHOLE, FRESH, MIL, 1.60"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.25, :full_parsed_line=>"GROCERY, NON, VAT, 1.25"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.85, :full_parsed_line=>"WALKERS, CRISPS, CHEESE, &, 1.85"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.85, :full_parsed_line=>"LIL, -, LETS, NON, APP, REG, *, 1, 1.85"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.89, :full_parsed_line=>"ORAL, B, PRO, EXPERT, PROTEC, 3.89"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.4, :full_parsed_line=>"MCDOUGAL, PLAIN, FLOUR, 1.40"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.55, :full_parsed_line=>"6, Fresh, Free, Range, Eggs, 2.55"}],
  #        16.38,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt waitrose modified receipt', freezed_time: '2022-09-22T13:44:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out08.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99, :full_parsed_line=>"V, BEEFSTEAK, CLUB, MALBE, 19.99"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.1, :full_parsed_line=>"C, &, M, MINI, PIADINA, 1.10"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0, :full_parsed_line=>"V, FRUIT, SHOOT, BLKCRRNT, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0, :full_parsed_line=>"V, FRT, SHTS, LS, S, /, FRTS, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, LEMON, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, PEACH, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5, :full_parsed_line=>"WR, ESS, WHOLE, MILK, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.9, :full_parsed_line=>"WR, ESS, WHOLE, MILK, 0.90"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.5, :full_parsed_line=>"HELLMANNS, MAYONNAISE, 2.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, PEACH, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.25, :full_parsed_line=>"F, /, TRADE, BANANAS, 1.25"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, LEMON, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.5, :full_parsed_line=>"STARBCKS, HOUSE, BLEND, 2.50"},
  #         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>7.33, :full_parsed_line=>"V, VENUS, OLAY, RAZOR, 7.33"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.55, :full_parsed_line=>"WR, ESS, SWEETCORN, 1.55"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.35, :full_parsed_line=>"WR, ESS, LEMON, 0.35"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.5, :full_parsed_line=>"SILVER, SPOON, SGR, 0.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.3, :full_parsed_line=>"LEERDAMMER, ORIGINAL, 2.30"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.3, :full_parsed_line=>"LEERDAMMER, ORIGINAL, 2.30"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.55, :full_parsed_line=>"WR, ESS, SWEETCORN, 1.55"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.66, :full_parsed_line=>"BIO, -, TIFUL, KEFIR, 1.66"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WR, DORG, RADISH, BUNCH, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.2, :full_parsed_line=>"WR, 2, HALF, CIABATTAS, 2.20"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WR, DORG, RADISH, BUNCH, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WR, PR, AVOCADOS, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.4, :full_parsed_line=>"WR, CLASSIC, VINE, TOMS, 2.40"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.12, :full_parsed_line=>"WR, ESS, CHKN, LEGS, 1.12"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.55, :full_parsed_line=>"MIXED, PEPPERS, P, /, P, 1.55"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.0, :full_parsed_line=>"WR, WHITE, FARMHOUSE, 1.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.5, :full_parsed_line=>"WR, ESS, K, /, PRAWNS, ASC, 3.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.1, :full_parsed_line=>"V, LINDT, CHILLI, CHOC, 2.10"},
  #         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.95, :full_parsed_line=>"U, /, E, TORCHON, HAM, 3.95"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.7, :full_parsed_line=>"JONGENS, TST, WAFFLES, 1.70"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.4, :full_parsed_line=>"ROWSE, RUNNY, HONEY, 2.40"},
  #         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.5, :full_parsed_line=>"STARBCKS, HOUSE, BLEND, 2.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2, :full_parsed_line=>"WR, POME, DEI, MORO, TMS, 2.20"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WILD, ROCKET2, 801, B, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.55, :full_parsed_line=>"WR, WATERMELON, 2.55"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"GALBANI, MOZZARELLA, 1.95"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.05, :full_parsed_line=>"GALBANI, MOZZARELLA, 0.05"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"ASPARAGUS, TIPS, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.25, :full_parsed_line=>"V, POM, -, BEAR, ORIGINAL, 1.25"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5, :full_parsed_line=>"YEO, VALL, DOUB, CREAM, 1.50"}],
  #        105.2,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt waitrose modified receipt 1', freezed_time: '2022-10-14T16:15:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out15.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99, :full_parsed_line=>"V, BEEFSTEAK, CLUB, MALBE, 19.99"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"CRAVENDALE, MILK, 2.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"CRAVENDALE, MILK, 2.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"V, WR, ESS, STILL, WATER, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.0, :full_parsed_line=>"V, WR, ESS, CHAM, HAND, WSH, 1.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.25, :full_parsed_line=>"MUTTI, F, /, CHOPPED, TOMS, 1.25"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.9, :full_parsed_line=>"YEO, VALL, DOUB, CREAM, 1.90"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.2, :full_parsed_line=>"WR, ESS, SALTED, BUTTER, 2.20"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.45, :full_parsed_line=>"V, JOHNSON, BATH, WASH, 3.45"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.0, :full_parsed_line=>"WR, ESS, FT, BANANAS, 1.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.4, :full_parsed_line=>"LARGE, ORANGES, 2.40"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.65, :full_parsed_line=>"WR, SWEET, PEPPERS, 1.65"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"WR, GRANNY, SMITHS, 2.10"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.39, :full_parsed_line=>"WR, BEST, BRIT, APPLES, 1.39"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.5, :full_parsed_line=>"YEO, VALLEY, NAT, YOG, 2.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.2, :full_parsed_line=>"DORG, CARROTS, 1.20"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.4, :full_parsed_line=>"WR, ESS, CHAR, POTS, 1KG, 1.40"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.0, :full_parsed_line=>"WR, ESS, CONFRNS, PEARS, 1.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.0, :full_parsed_line=>"WR, ESS, CONFRNS, PEARS, 1.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.7, :full_parsed_line=>"WR, ESS, RADISH, 0.70"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.5, :full_parsed_line=>"WR1, PR, XL, AVOCADOS, 3.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"WR, GOLDEN, DELICIOUS, R, 2.10"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.15, :full_parsed_line=>"BABYBEL, MINI, ORIGINL, 2.15"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.4, :full_parsed_line=>"2, @, £, 0.70, 1.40"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.05, :full_parsed_line=>"3, @, £, 0.35, TL, 1.05"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"WR, DORG, PONTD, CABBGE, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"WR, CRANBERRIES, 2.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>5.25, :full_parsed_line=>"WR, SALMON, FILLETS, 5.25"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>6.53, :full_parsed_line=>"WR, NO1, MSC, COD, LOIN, 6.53"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"WR, ESS, CHICKN, LIVERS, 1.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.2, :full_parsed_line=>"WR, ESS, STRAWBERRIES, 2.20"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.3, :full_parsed_line=>"NO.1, CHICKEN, DRUM, 3.30"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.5, :full_parsed_line=>"CHERRY, VINE, TOMS, P, /, P, 2.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"GALBANI, MOZZARELLA, 1.95"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"GALBANI, MOZZARELLA, 1.95"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.29, :full_parsed_line=>"WR, DRY, CURED, B, /, BACON, 3.29"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.35, :full_parsed_line=>"WR, SMOKED, SALAMI, 2.35"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.35, :full_parsed_line=>"WR, SMOKED, SALAMI, 2.35"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.09, :full_parsed_line=>"WR, HONEY, ROAST, HAM, 3.09"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.0, :full_parsed_line=>"WR, HONEY, ROAST, HAM, 3.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"ASPARAGUS, TIPS, 2.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.5, :full_parsed_line=>"CHERRY, VINE, TOMS, P, /, P, 2.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"ASPARAGUS, TIPS, 2.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.95, :full_parsed_line=>"V, WKRS, LESS, SLT, C, &, 0, 1.95"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>5.6, :full_parsed_line=>"4, @, £, 1.40, 5.60"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"V, NESTLE, SMARTIES, PENG, 2.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.95, :full_parsed_line=>"WR, FR, MIXED, EGGS, 2.95"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.45, :full_parsed_line=>"JACKSON, WHIE, BLOOMER, 1.45"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.5, :full_parsed_line=>"V, RITTER, SPORT, MINI, 3.50"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>0.8, :full_parsed_line=>"V, VICKS, TA, LOZENGE, 0.80"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>0.8, :full_parsed_line=>"V, HALLS, ORIGINAL, 0.80"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>3.0, :full_parsed_line=>"V, BATHTIME, CRAYONS, 3.00"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.35, :full_parsed_line=>"V, CREEPY, PUMPKNS, CHOCS, 1.35"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6, :full_parsed_line=>"WR, WILD, ROCKET, 1.60"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.65, :full_parsed_line=>"WR, CAVOLO, NERO, 200G, 1.65"}],
  #        137.65,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1] + 0.09)
  #   end
  # end

  # context 'when receipt marks and spencer 1', freezed_time: '2022-09-26T18:55:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out10.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.76, :full_parsed_line=>"00069366, Loose, Bananas, £, 0.76"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"29197538, HAPPY, LOLLIES, £, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"29197538, HAPPY, LOLLIES, £, 1.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.3, :full_parsed_line=>"29304813, OG, WINGS, 750G, £, 1.30"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.0, :full_parsed_line=>"00083249, TRKY, S, /, LESS, FIL, £, 4.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5, :full_parsed_line=>"00082723, NECTARINES, £, 2.50"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.75, :full_parsed_line=>"0015981, CHERRY, REC, SML, £, 2.75"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0, :full_parsed_line=>"00805100, EASYPEEL, FAMILY, £, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0, :full_parsed_line=>"29095759, PR, MANGO, Y2, £, 2.00"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.65, :full_parsed_line=>"0080586, !, ORANGE, LOOSE, £, 0.65"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.65, :full_parsed_line=>"0080586, !, ORANGE, LOOSE, £, 0.65"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25, :full_parsed_line=>"00983006, POMEGRANATE, £, 2.25"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25, :full_parsed_line=>"00983006, POMEGRANATE, £, 2.25"}],
  #        24.11,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt tesco 1', freezed_time: '2022-10-10T20:35:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out13.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"BREAD, £, 2.10"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"ENGLISH, BUTTER, £, 2.10"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"ENGLISH, BUTTER, £, 2.10"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>4.25, :full_parsed_line=>"SMOKED, SALMO, £, 4.25"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.45, :full_parsed_line=>"THICK, DBL, CRM, £, 1.45"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.3, :full_parsed_line=>"CHICKEN, FILLET, £, 2.30"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>2.95, :full_parsed_line=>"PLATTER, £, 2.95"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>1.95, :full_parsed_line=>"WALKERS, CRISPS, *, £, 1.95"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>0.3, :full_parsed_line=>"BAG, FOR, LIFE, *, £, 0.30"}],
  #        19.5,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  context 'when receipt pepito 1', freezed_time: '2022-11-06T04:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out06.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>23000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>18500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>11500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>49522.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>9699.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33509.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>92500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>45348.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>38570.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47400.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18400.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>65000.0},
        618448.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  xcontext 'when receipt pepito 2', freezed_time: '2022-11-18T08:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out07.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>61424.0},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9300.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>21200.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>100500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9300.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0, },
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
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15360.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>85000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>28500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>42000.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>42400.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>12500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>28000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>78210.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>6800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>79500.0},
        1312901.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 3', freezed_time: '2022-11-17T01:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out16.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10650.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>114000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36736.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>90500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>10600.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24800.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19176.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60000.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>116730.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>11000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>192900.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>20500.0, },
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
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>8000.0},
        1553892.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 4', freezed_time: '2022-11-18T01:37:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out17.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>156300.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>91000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>64000.0},
        809200.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  xcontext 'when receipt pepito 5', freezed_time: '2022-11-18T08:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out18.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>15904.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>115000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>36330.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54900.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>40900.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>45000.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>50300.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>54900.0},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>22770.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55383.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10560.0},
        600947.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 6', freezed_time: '2022-11-22T01:34:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out20.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>116730.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41514.0, },
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12012.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>198000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54900.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>34675.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40565.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>27132.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17325.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>6000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>80200.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>18500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>23000.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>78000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8500.0, },
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>62500.0},
        948553.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1] - 100) # 100 is acceptable difference
    end
  end

  context 'when receipt pepito 7', freezed_time: '2023-12-17T10:59:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out21.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>16500.0},
          {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>16000.0},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45965.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>17000.0},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45360.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18500.0},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>179500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>34500.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>65900.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>65900.0},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>89900.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>43000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>86000.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23220.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>49500.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26163.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>28350.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>103477.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>25000.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>49500.0},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>27000.0},
          1120736.0,
          nil]
      )
      expect(sum_of_prices).to eq(result[1] - 1)
    end
  end

  context 'when receipt pepito 8', freezed_time: '2022-11-24T02:17:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out22.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>52371.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>51388.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22140.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21560.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>25740.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27224.0, },
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>34500.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>95019.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13120.0, },
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>26630.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>54900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>114000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29715.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36895.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>47000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25830.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>50300.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>40500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>62600.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>330000.0},
         {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>112500.0},
        1457432.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 9', freezed_time: '2023-12-17T09:43:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out23.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>330000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>64000.0},
         {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :price=>60000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>75600.0},
        529600.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 10', freezed_time: '2022-11-28T05:14:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out26.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>19289.0},
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
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
        783188.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 11', freezed_time: '2022-12-01T08:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out29.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0},
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
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5454.0, },
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>138000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>41500.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>29800.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>110300.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>27075.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>44809.0},
        1496838.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 12', freezed_time: '2023-12-17T09:37:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out32.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>621500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18260.0},
        717760.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 13', freezed_time: '2022-12-08T03:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out35.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0},
         {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>69000.0},
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
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>29133.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>55500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>74000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0},
        1033038.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 14', freezed_time: '2022-12-11T09:14:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out36.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>7500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>129700.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29299.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10800.0},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0},
        737999.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 15', freezed_time: '2022-12-13T08:50:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out37.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>483000.0},
        642900.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 16', freezed_time: '2022-12-15T01:48:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out38.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>15300.0},
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
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>48100.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
         {:category_name=>"Марк", :sub_category_name=>"Игрушки", :price=>34900.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32076.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36526.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>9900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4102.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>47200.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>16200.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16434.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12420.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>44005.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20146.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>45000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17226.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>69700.0},
        1426820.0,
        nil]
      )
      expect(sum_of_prices + 1).to eq(result[1])
    end
  end

  context 'when receipt pepito 17', freezed_time: '2022-12-18T10:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out39.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12200.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>4800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38700.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>53900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0},
        289100.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 18', freezed_time: '2022-12-20T05:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out40.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
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
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>65000.0},
        1466342.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 19', freezed_time: '2022-12-25T03:16:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out41.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>24000.0},
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
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>24500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>138000.0},
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
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>4900.0},
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
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15790.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9630.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10954.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>6975.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21780.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7808.0, },
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>65500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60000.0},
        2635070.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 20', freezed_time: '2022-12-31T08:23:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out42.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>141500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>106272.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>40000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>50405.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>12200.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>34800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38700.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>80000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>33500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>53500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>53500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>61800.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23900.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>10500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>17500.0},
        1065577.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 21', freezed_time: '2023-01-09T03:23:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out43.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>76400.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>11000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>57105.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17050.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15400.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>110600.0},
        530855.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 22', freezed_time: '2023-12-17T07:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out44.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>84500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>41200.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>69000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>42900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>52640.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>49613.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77767.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17800.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
        789420.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 23', freezed_time: '2023-01-14T12:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out45.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>34320.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>24500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>38500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15660.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17200.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>43500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>43500.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>24500.0},
        463180.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 24', freezed_time: '2023-01-21T08:40:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out46.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>39500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>52800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>72500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14800.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7700.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>104130.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17108.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>72500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32344.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>27885.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>57000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
        1006767.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 25', freezed_time: '2023-01-27T08:34:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out47.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>70000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
        128000.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 26', freezed_time: '2023-01-27T08:42:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out48.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>148000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>39500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>43500.0},
        565900.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 27', freezed_time: '2023-01-27T08:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out49.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>111500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11583.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>51190.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99400.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>82894.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26037.0},
        609504.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 28', freezed_time: '2023-01-28T03:10:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out50.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>85900.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>67000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>137500.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>39500.0},
        481700.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 29', freezed_time: '2023-02-03T10:47:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out51.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>42322.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>45900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>34632.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16038.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>31700.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16200.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>79500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>102000.0},
        644292.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 30', freezed_time: '2023-02-03T12:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out52.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>27115.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>95040.0},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>3900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59900.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>88900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>57600.0},
        332455.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 31', freezed_time: '2023-02-04T02:32:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out53.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>78030.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15400.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31950.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>124225.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56800.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
        629705.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 32', freezed_time: '2023-02-04T02:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out54.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>139500.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>37873.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27254.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22394.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42048.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8891.0, },
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Лиля", :sub_category_name=>"Одежда", :price=>29900.0},
        592160.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 33', freezed_time: '2023-02-12T04:54:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out55.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>107500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>49500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>47000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>103500.0},
        422500.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 34', freezed_time: '2023-02-12T05:06:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out56.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32558.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47509.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45791.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>179500.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>45900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17597.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14751.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>6300.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>84000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>54900.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>14800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>74900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>132000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>10500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4864.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41900.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>35000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>107500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37920.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>65500.0},
        1348490.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 35', freezed_time: '2023-12-17T06:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out57.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59460.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8835.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>179500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>179500.0},
        447295.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 36', freezed_time: '2023-02-17T13:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out58.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5947.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>58000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>111500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16650.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>85756.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>28500.0},
         {:category_name=>"Коля", :sub_category_name=>"Ванные принадлежности", :price=>45500.0},
        611853.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 37', freezed_time: '2023-02-17T14:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out59.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>84500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11730.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>41500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>14900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16300.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>46107.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>80200.0},
        437437.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 38', freezed_time: '2023-02-17T14:13:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out60.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28400.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>49500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>47000.0},
        138700.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 39', freezed_time: '2023-02-18T12:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out61.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>65000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17200.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59300.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>45360.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>84960.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>46080.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32600.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>22950.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>21780.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28400.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>56300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11000.0},
        832330.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 40', freezed_time: '2023-02-21T08:16:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out62.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>149100.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>12000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>102000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16300.0},
        335300.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 41', freezed_time: '2023-02-25T10:52:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out63.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>121500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10044.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>18100.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>254000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>38919.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39292.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>60000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>179500.0},
        777355.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 42', freezed_time: '2023-02-25T10:57:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out64.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>121500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>24640.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>23000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0},
        286940.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 43', freezed_time: '2023-02-25T11:02:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out65.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>17500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>36300.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7000.0},
        60800.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 44', freezed_time: '2023-02-26T02:37:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out66.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>88000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39516.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39591.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41900.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>100166.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>119920.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>9900.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>7254.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19440.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>92606.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>89208.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10375.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>8986.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>44944.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>39734.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>43500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
        1076740.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 45', freezed_time: '2023-02-27T09:18:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out67.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28400.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>59300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>111500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16720.0},
        389720.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 46', freezed_time: '2023-03-08T04:55:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out68.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>42500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49200.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49700.0},
        280700.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 47', freezed_time: '2023-03-08T05:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out69.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>59300.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>70434.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45477.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>53500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>27285.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>28224.0},
        409720.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 48', freezed_time: '2023-03-12T04:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out70.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>53700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>49500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>45000.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>31000.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>46000.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>55300.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45235.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>33480.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7200.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12558.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41900.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>163770.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14268.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15080.0},
        726691.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 49', freezed_time: '2023-03-16T07:04:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out71.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>127000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>28500.0},
         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>41000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>25502.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>20492.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>6000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38688.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>23690.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>25380.0},
        664952.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 50', freezed_time: '2023-03-20T07:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out72.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>31000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45800.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18229.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>42579.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39425.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>38559.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27953.0, },
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>84000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>88000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12065.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52900.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>19800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>8500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>8500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0},
        772510.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 51', freezed_time: '2023-12-16T14:28:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out73.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>31000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>34000.0},
        121800.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 52', freezed_time: '2023-03-30T03:10:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out74.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>55000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39093.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47476.0},
         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>80000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33807.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14080.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>32760.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>31000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>18000.0},
        459216.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 53', freezed_time: '2023-04-02T08:24:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out75.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19888.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>41002.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>203688.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16643.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>6400.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>79500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>37807.0},
        584428.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 54', freezed_time: '2023-04-04T12:50:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out76.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12090.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>41000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>61800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>249000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>109500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>131000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>106000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18500.0},
        960690.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 55', freezed_time: '2023-04-10T09:24:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out77.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45152.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>43741.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>45500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>32000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16606.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>76953.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>45274.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23303.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27399.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29536.0},
         {:category_name=>"Лиля", :sub_category_name=>"Ванные принадлежности", :price=>6500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>107000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19118.0},
        952183.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1] - 1)
    end
  end

  context 'when receipt pepito 56', freezed_time: '2023-04-13T02:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out78.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>249000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>80000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>6500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>30900.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>27000.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>84500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>24000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14256.0},
        1030156.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 57', freezed_time: '2023-12-16T14:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out79.jpg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>182600.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0, },
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>41000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>41000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>61000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>49500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>23500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>30000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>13800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0, },
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>17000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
        751900.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 58', freezed_time: '2023-04-21T02:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out80.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>38500.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>38993.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>41969.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>295901.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>76248.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>54900.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42867.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>115551.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>18000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>144000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>86240.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>36261.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16650.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11952.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24775.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41051.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>24000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>9191.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8070.0},
        1626119.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 59', freezed_time: '2023-05-02T03:17:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out81.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>122000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>65843.0},
         {:category_name=>nil, :sub_category_name=>nil, :price=>67500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>28350.0},
        283693.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 60', freezed_time: '2023-05-05T08:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out82.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>136000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60000.0},
        272000.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 61', freezed_time: '2023-05-08T06:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out83.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>200000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>44445.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40846.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>41897.0, },
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>9500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>32500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>91000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>84000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>49032.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>179500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20147.0},
        822367.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 62', freezed_time: '2023-05-09T12:45:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out84.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>25500.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>47000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0},
        119000.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 63', freezed_time: '2023-05-15T01:41:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out85.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4955.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>26000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, },
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0, },
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>13500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>33000.0},
        453555.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 64', freezed_time: '2023-05-15T14:28:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out86.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>74347.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27398.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>27500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>28508.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25875.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>69616.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>86040.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>35000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49700.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>33488.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25600.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46816.0},
        915288.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 65', freezed_time: '2023-05-17T06:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out87.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>4900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7700.0},
        111100.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 66', freezed_time: '2023-05-19T02:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out88.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>179000.0},
         {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>121500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>275643.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>49290.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>55094.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18500.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>29500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14850.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>72176.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>60452.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>66500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41700.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>27800.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>28938.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>17000.0},
        1268643.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 67', freezed_time: '2023-05-21T08:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out89.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>53000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>51528.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>119800.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16360.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31600.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>171700.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4928.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18542.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0},
        1028458.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 68', freezed_time: '2023-05-23T13:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out90.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>22500.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>62000.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>15666.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>20853.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8560.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13230.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>163000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>64900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>7900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>7900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>7900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>30500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>54040.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>6734.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16600.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23920.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>40500.0},
        830603.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 69', freezed_time: '2023-05-26T02:10:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out91.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>10000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9500.0},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>60500.0},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>89000.0},
          {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>54900.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>44500.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>44500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>29900.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
          {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>18500.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>127000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>42000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>14900.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>136000.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>9500.0},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>76400.0},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>34875.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59900.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>59850.0},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>20000.0},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>31000.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>28350.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>14900.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12969.0},
          1345244.0,
          nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 70', freezed_time: '2023-06-08T01:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out92.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>73500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12700.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66400.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33156.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>9876.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>163000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>84000.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>45089.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21093.0},
        759914.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 71', freezed_time: '2023-06-11T11:08:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out93.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>71000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>88500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>13000.0},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>10000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>85050.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>59880.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>26500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>13000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>73500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>45000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59300.0},
        779930.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 72', freezed_time: '2023-06-11T11:18:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out94.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36696.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>13000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20240.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>19500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>27800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>27800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>267500.0},
        964836.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 73', freezed_time: '2023-06-15T11:56:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out95.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32900.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>319000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>30100.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>27800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>27800.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>61000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>12000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2500.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>33000.0},
        750700.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 74', freezed_time: '2023-06-20T04:52:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out96.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>88500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>31280.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>34500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>85500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>168000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>73500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>23004.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9473.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16538.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20487.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132800.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>292000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7700.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13300.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18601.0},
        1378683.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 75', freezed_time: '2023-06-29T05:38:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out97.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>122000.0,},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>16400.0,},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3500.0,},
        141900.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 76', freezed_time: '2023-07-01T14:17:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out98.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>71700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>19500.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>52400.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>51500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>107000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>267500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>121000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>19000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49700.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32900.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>49125.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>185000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>19000.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>26500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19936.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>83168.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27336.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>95400.0},
        1650265.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 77', freezed_time: '2023-07-12T13:28:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out99.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>65800.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>94050.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>47700.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>87900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>73500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>93000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>75000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8184.0},
        609634.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 78', freezed_time: '2023-07-12T14:04:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out100.jpeg") }

    it 'return 3 values' do
      result = subject

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

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12978.0},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>15624.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>72000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>14700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>52000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8383.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>30015.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>32683.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>26500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>79100.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
        614585.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1] - 2)
    end
  end

  context 'when receipt pepito 79', freezed_time: '2023-07-18T01:41:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out101.jpeg") }

    it 'return 3 values' do
      result = subject

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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>35000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>44300.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>84000.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>44700.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>102500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>93000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>55575.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19000.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>49500.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>30000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>19800.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>49000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>65075.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40060.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16720.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31407.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>37335.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72500.0},
        1001372.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 80', freezed_time: '2023-07-18T01:48:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out102.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>83000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20691.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33782.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>185000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>136000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>64000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>40000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31950.0},
        905323.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 81', freezed_time: '2023-07-22T08:57:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out103.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>27500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>63500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20884.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15900.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>67500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>29000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>76482.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>32500.0},
        525266.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 82', freezed_time: '2023-07-22T09:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out104.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>73500.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>72000.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>14500.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>18500.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>58000.0},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18500.0},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>9500.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>75268.0},
          361768.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 83', freezed_time: '2023-08-01T09:45:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out105.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>156000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31900.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>40500.0},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>56300.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>75700.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>137500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>49000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>76000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>49500.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>23000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>64395.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>38000.0},
        948295.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 84', freezed_time: '2023-08-11T01:24:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out106.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>127000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>35000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>68000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>90009.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>41500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>77500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>76482.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>58000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>83000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>36000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>11000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>19500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>18000.0},
        887491.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 85', freezed_time: '2023-08-12T00:33:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out107.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>43344.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>83627.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>11000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>37500.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>76482.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>52767.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>98000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>64500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>75000.0},
        677720.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 86', freezed_time: '2023-09-03T09:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out108.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>15000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45187.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>43200.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>35000.0},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>154000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>26500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>65000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24924.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>15500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>71800.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13802.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>69926.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8694.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18302.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20782.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>12172.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>10546.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40219.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>52200.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>32500.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9266.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1728.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>23809.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14700.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>90000.0},
        1256258.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1] - 1)
    end
  end

  context 'when receipt pepito 87', freezed_time: '2023-09-22T03:05:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out109.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>16000.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>14500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>11100.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>96500.0},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>69900.0},
        271500.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 88', freezed_time: '2023-09-29T12:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out110.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21210.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>76421.0},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21890.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>26500.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>35000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>61900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>61900.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>87000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>33000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>28084.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>51000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>27000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>107500.0},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>14000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>14500.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>55500.0},
        789900.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1] + 5)
    end
  end

  context 'when receipt pepito 89', freezed_time: '2023-09-29T12:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out111.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>66000.0},
         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>32000.0},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>23000.0},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>26000.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>13241.0},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>100834.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>35000.0},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>26400.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>63000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>43000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>34000.0},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>92500.0},
         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>9500.0},
         {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>15000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46000.0},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0},
        738475.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 90', freezed_time: '2023-11-04T09:24:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out112.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>70000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>42000.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>75000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16000.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>9500.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>31455.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>36860.0},
        296815.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 91', freezed_time: '2023-12-05T01:41:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out113.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>27000.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>39000.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31900.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>77000.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>26316.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>26826.0},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>66500.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>93668.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>27800.0},
        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>43065.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31950.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6500.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>38000.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>13900.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64008.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0},
        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>42000.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29938.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>7500.0},
        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>72000.0},
        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20666.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>37440.0},
        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17257.0},
        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0},
        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15800.0},
        1040435.0,
        nil]
      )
      expect(sum_of_prices + 1).to eq(result[1])
    end
  end

  context 'when receipt pepito 92', freezed_time: '2023-12-17T10:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out114.jpeg") }

    it 'return 3 values' do
      result = subject

      new_result = result[0].map do |hsh|
        {
          category_name: hsh[:category_name],
          sub_category_name: hsh[:sub_category_name],
          price: hsh[:price]
        }
      end
      new_result << result[1]
      new_result << result[2]
      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)

      expect(new_result).to eq(
        [
          {:category_name=>"Марк", :sub_category_name=>"Памперсы", :price=>121500.0},
          {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>35500.0},
          {:category_name=>"Для дома", :sub_category_name=>"инвентарь", :price=>34000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>61000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>36500.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>94000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46000.0},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>26400.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>88000.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>78052.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>50904.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>35568.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>28909.0},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>6394.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>66500.0},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>86000.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>13000.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>41500.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>38500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>7500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>7500.0},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>7500.0},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>76400.0},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>27846.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16650.0},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>59400.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>20000.0},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>40000.0},
          1438023.0,
          nil
        ]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  # context 'when receipt frestive 1', freezed_time: '2022-11-12T09:20:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out11.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>15000.0,
  #         :full_parsed_line=>"22200003, PASEO, ULTRA, SOFT, 100, 15,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Новопочта",
  #         :price=>38000.0,
  #         :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 38,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>282500.0, :full_parsed_line=>"23023003, SUNKIST, RSTOPSCH, 454, 282,500"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>25000.0,
  #         :full_parsed_line=>"22201002, PASEO, FCL, TISSUE, 200, 25,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0, :full_parsed_line=>"23231017, DELFI, MINI, TOYS, 16,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 48,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 15,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 15,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>100000.0,
  #         :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 100,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>54000.0,
  #         :full_parsed_line=>"23246051, MONGGO, MLK, DARK41, %, 80, 54,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0, :full_parsed_line=>"23152004, OREO, BISC, VNL, CRM137, 10,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>78213.0, :full_parsed_line=>"10031046, MELON, CANTALUOPE, 78,213"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10220.0, :full_parsed_line=>"10300038, PARSLEY, CURLY, LOOSE, 10,220"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8308.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 8,308"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12050.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 12,050"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0, :full_parsed_line=>"10363010, CAPSICUM, GRN, HIDROPO, 18,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40000.0, :full_parsed_line=>"24044044, BELLA, MOZZA, CWN, 100G, 40,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Кофе, Чай",
  #         :price=>145500.0,
  #         :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Алкоголь",
  #         :price=>115000.0,
  #         :full_parsed_line=>"20100030, BINTANG, KLG, 320M, CP6, 115,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49000.0, :full_parsed_line=>"24041025, KRAFT, SINGLES, 10X167, 49,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8927.0, :full_parsed_line=>"10000024, APPLE, RYL, GLA, USA, 80, 8,927"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14560.0, :full_parsed_line=>"10310046, POTATO, MINI, 14,560"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>60500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 60,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 132,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>213000.0,
  #         :full_parsed_line=>"23364022, AL, SHIFA, ACACIA, 400G, 213,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45900.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 45,900"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>101536.0, :full_parsed_line=>"11042001, TUNA, STEAK, 101,536"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>23762.0, :full_parsed_line=>"12301032, CHICKEN, LEG, BONELESS, 23,762"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>86458.0, :full_parsed_line=>"24044010, FRESH, RICOTTA, 86,458"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>15953.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 15,953"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>32500.0, :full_parsed_line=>"24051004, BIOLAND, ORG, EGG, 10'S, 32,500"}],
  #       1982387.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 2', freezed_time: '2022-11-20T03:04:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out19.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>34500.0, :full_parsed_line=>"24214006, WALLS, CRNT, TRM12X28M, 34,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>50000.0,
  #          :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 50,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Хлеб и др",
  #          :price=>22000.0,
  #          :full_parsed_line=>"13021006, DE, BAKKER, HOT, DOG, LA, 22,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Алкоголь",
  #          :price=>115000.0,
  #          :full_parsed_line=>"20100030, BINTANG, KLG, 320M, CP6, 115,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"К пиву",
  #          :price=>60500.0,
  #          :full_parsed_line=>"23030195, THINS, CRM, &, CHIVES, 175, 60, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20090.0, :full_parsed_line=>"10312008, CARROT, MEDIUM, IMPORT, 20, ,, 090"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 48,800"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>15500.0, :full_parsed_line=>"23023004, TONG, SNFLWRS, SEED130, 15,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29880.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 29, ,, 880"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55000.0, :full_parsed_line=>"23645009, KUHNE, FEINE, CORN370, 55,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>50952.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 50,952"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27500.0, :full_parsed_line=>"23823025, BONDUEL, PEAS, FINE200, 27,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>60500.0,
  #          :full_parsed_line=>"24042035, YUMMY, CRM, CHESE, 250, 60, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>54016.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 54,016"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33856.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 33, ,, 856"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18116.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 18, ,, 116"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>50000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 50,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>45765.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 45, ,, 765"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>134000.0,
  #          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>128000.0,
  #          :full_parsed_line=>"24033041, ANCHOR, COOK, CREAM, 1L, 128,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 52,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9042.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 9,042"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 132,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>76000.0,
  #          :full_parsed_line=>"16106004, BERNARDI, HTDG, BF500G, 76,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>66000.0,
  #          :full_parsed_line=>"16403017, EL, PRIMO, CHN, CHS360G, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20500.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 20,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28000.0, :full_parsed_line=>"23246040, MONGGO, CHO, PRALINE40, 28,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>28000.0,
  #          :full_parsed_line=>"23246065, MONGGO, SLTYCRML69, %, 40, 28,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>20000.0, :full_parsed_line=>"24210007, WALLS, MGNM, CHOC095ML, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0, :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 48,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>44000.0, :full_parsed_line=>"10410101, GARLIC, 500GR, B, FRESH, 44,000"}],
  #        1615017.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 3', freezed_time: '2022-11-26T07:58:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out24.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>352500.0, :full_parsed_line=>"20202019, HATTEN, ROSE, CASK, BOX, 352,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39624.0, :full_parsed_line=>"12301007, CHICKEN, WING, 39, ,, 624"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 48,800"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 25,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31635.0, :full_parsed_line=>"12301025, PAHA, ATAS, 31,635"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>36000.0, :full_parsed_line=>"16004803, KAWAN, ROTI, WRPS, 360G, 36,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>119000.0, :full_parsed_line=>"23240011, LINDT, MILK, 100, GR, 119,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>52580.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 52, ,, 580"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>57684.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 57, ,, 684"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35150.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 35, ,, 150"},
  #        {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>10000.0, :full_parsed_line=>"32315002, DM, KITCHEN, WARE, KW1, 10,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 52,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 31,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60368.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 60, ,, 368"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 132,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32000.0, :full_parsed_line=>"10400162, WILD, RUCOLA, ORG, 200G, 32,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21930.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 21,930"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17673.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 17,673"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13462.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 13,462"}],
  #       1272406.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 4', freezed_time: '2022-11-27T07:39:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out25.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31857.0, :full_parsed_line=>"12201019, PORK, LOIN, 31,857"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Бакалея",
  #          :price=>49500.0,
  #          :full_parsed_line=>"23512073, BARILLA, FUSILLI, 500, 49, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>37560.0, :full_parsed_line=>"10031010, MELON, SKY, ROCKET, 37,560"},
  #         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>38080.0, :full_parsed_line=>"16200022, COOKED, HAM, 38, ,, 080"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>24583.0, :full_parsed_line=>"12202009, STREAKY, BACON, 24, ,, 583"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Ванные принадлежности",
  #          :price=>29500.0,
  #          :full_parsed_line=>"32510006, BAGUS, KLAP, SRBGNT301, 29, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>124533.0, :full_parsed_line=>"15410002, PORK, CHOP, 124, ,, 533"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25382.0, :full_parsed_line=>"12201019, PORK, LOIN, 25, ,, 382"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Кухонные принадлежности",
  #          :price=>24000.0,
  #          :full_parsed_line=>"21010003, BAGUS, S., BILAS, T560, 24,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11410.0, :full_parsed_line=>"10352014, CABBAGE, CHINESE, 11,410"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Кухонные принадлежности",
  #          :price=>61000.0,
  #          :full_parsed_line=>"22204014, PASEO, WHITE, 8RL, 280S, 61,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13674.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 13,674"}],
  #        488079.0,
  #        nil
  #       ]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 5', freezed_time: '2022-11-29T09:07:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out27.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26, ,, 500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Новопочта",
  #          :price=>19000.0,
  #          :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19, ,, 000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>67913.0, :full_parsed_line=>"12301032, CHICKEN, LEG, BONELESS, 67,913"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15390.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 15, ,, 390"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>73500.0,
  #          :full_parsed_line=>"16403014, EL, PRIMO, CHC, FRK500G, 73,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>63000.0,
  #          :full_parsed_line=>"16101024, KANZLER, CS, BRWRT360G, 63,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16264.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 16, ,, 264"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>19000.0,
  #          :full_parsed_line=>"23150008, DELFI, OR, CHPIE6P, 180, 19, ,, 000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>52500.0,
  #          :full_parsed_line=>"24041040, PRESIDENT, GOUDA, 200G, 52, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>52500.0,
  #          :full_parsed_line=>"24044017, BEL, CHESE, DIPPRS140G, 52, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>131596.0, :full_parsed_line=>"11042001, TUNA, STEAK, 131,596"},
  #         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>39406.0, :full_parsed_line=>"16200023, DANISH, HAM, 39, ,, 406"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>50840.0,
  #          :full_parsed_line=>"12202007, SMOKELEGBONELESKINON, 50, ,, 840"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>134000.0,
  #          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 5,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 9,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66, ,, 500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>202500.0,
  #          :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 202, ,, 500"}],
  #        1082409.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 6', freezed_time: '2022-12-01T03:14:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out28.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Алкоголь",
  #         :price=>320775.0,
  #         :full_parsed_line=>"20201080, HATTEN, AGA, WHITE, CAS, 320, ,, 775"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>20000.0,
  #         :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 20,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66, ,, 500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>134000.0,
  #         :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134, ,, 000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20024001, RAUCH, HD, PINEAPPLE1L, 56, ,, 500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>56196.0, :full_parsed_line=>"10031015, WATERMELON, RED, 56, ,, 196"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>16000.0,
  #         :full_parsed_line=>"22203017, MITU, B, REG, BLUE, 2X50, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40680.0, :full_parsed_line=>"12301032, CHICKEN, LEG, BONELESS, 40, ,, 680"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40061.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 40, ,, 061"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>13510.0, :full_parsed_line=>"12302005, CHICKEN, GIZZARD, 13, ,, 510"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>30115.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 30, ,, 115"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Молочка",
  #         :price=>52500.0,
  #         :full_parsed_line=>"24041040, PRESIDENT, GOUDA, 200G, 52, ,, 500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Молочка",
  #         :price=>66000.0,
  #         :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 66, ,, 000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42021.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 42, ,, 021"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Фрукты",
  #         :price=>39192.0,
  #         :full_parsed_line=>"10000009, APPLE, RED, DEL, USA125, 39, ,, 192"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16985.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 16,985"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24000.0, :full_parsed_line=>"10400051, DILL, 66, FRESH, HERBS, 24,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"23153001, OREO, MINI, STRWBRRY67, 9,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15000.0, :full_parsed_line=>"15101011, MIXED, JUICE, 15,000"}],
  #       1221535.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 7', freezed_time: '2022-12-02T08:49:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out30.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0, :full_parsed_line=>"23032021, MEIJI, HELLO, PANDA, MI, 8,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Новопочта",
  #          :price=>19000.0,
  #          :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21930.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 21,930"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>110500.0,
  #          :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 110,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 31,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 67,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 25,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>10000.0,
  #          :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 10,000"}],
  #        292930.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 8', freezed_time: '2022-12-04T08:45:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out31.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Колбаса, сосиски",
  #         :price=>286500.0,
  #         :full_parsed_line=>"16100040, EL, PRIMO, BF, CHSE500G, 286,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>49016.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 49,016"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Фрукты",
  #         :price=>39836.0,
  #         :full_parsed_line=>"10000009, APPLE, RED, DEL, USA125, 39, ,, 836"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35406.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 35, ,, 406"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
  #        {:category_name=>"Марк",
  #         :sub_category_name=>"Памперсы",
  #         :price=>128500.0,
  #         :full_parsed_line=>"22242012, MAKUKU, SLIM, PTS, L, 34, 128,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33500.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 33,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20004004, FANTA, STRAW, PET, 1.5L, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21156.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 21,156"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>25000.0, :full_parsed_line=>"23030112, PRINGLES, ORIGINAL, 10, 25,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Кофе, Чай",
  #         :price=>145500.0,
  #         :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>25000.0, :full_parsed_line=>"23030114, PRINGLES, CHDR, CHS107, 25,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25000.0, :full_parsed_line=>"23030113, PRINGLES, SOUR, CREAM, 25,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512073, BARILLA, FUSILLI, 500, 49,500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>33000.0,
  #         :full_parsed_line=>"23640012, KEWPIE, MYNAIS, ORI150, 33,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>59150.0, :full_parsed_line=>"12202011, SMOKED, HAM, 59, ,, 150"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>114500.0,
  #         :full_parsed_line=>"23364009, LDM, SQUEEZY, HNY, 500G, 114,500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Колбаса, сосиски",
  #         :price=>35000.0,
  #         :full_parsed_line=>"16200043, MAMAS, SALAM, MLN0100G, 35,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56672.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 56,672"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>76405.0, :full_parsed_line=>"12201019, PORK, LOIN, 76,405"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>40500.0, :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 40,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>79288.0, :full_parsed_line=>"11101006, SHRIMP, FRESH, VANAME, 79, ,, 288"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 15,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>134000.0,
  #         :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>35500.0,
  #         :full_parsed_line=>"23150009, DELFI, OR, CHPIE12, 360, 35,500"}],
  #       1741929.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 9', freezed_time: '2022-12-06T05:05:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out33.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>39879.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 39,879"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39900.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 39, ,, 900"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40455.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 40, ,, 455"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148000.0, :full_parsed_line=>"23362020, NUTELLA, T680, GR, 148,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 56, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59500.0, :full_parsed_line=>"23240011, LINDT, MILK, 100, GR, 59,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>58500.0, :full_parsed_line=>"23240047, SCHOGTN, MILKCH0100G, 58, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 9,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18320.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 18, ,, 320"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 18,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>133934.0, :full_parsed_line=>"11042001, TUNA, STEAK, 133, ,, 934"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22145.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 22, ,, 145"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 25,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5500.0, :full_parsed_line=>"10400113, PARSLEY, ITALIAN, 100G, 5,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14500.0, :full_parsed_line=>"10400158, RUCOLA, BABY, 200, GR, 14,500"}],
  #        793133.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 10', freezed_time: '2022-12-08T01:40:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out34.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>43425.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 43,425"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39284.0, :full_parsed_line=>"10000009, APPLE, RED, DEL, USA125, 39,284"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>54000.0,
  #          :full_parsed_line=>"23641001, FRENCH, YLW, SQ, MSTD14, 54,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0, :full_parsed_line=>"23231017, DELFI, MINI, TOYS, 16,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16082.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 16,082"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512070, BARILLA, TRTGLIONI500, 49,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>37000.0, :full_parsed_line=>"20015038, JUNGLE, JC, PNAPPLE, 1L, 37,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9310.0, :full_parsed_line=>"10366014, EGGPLANT, PURPLE, 9,310"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>108955.0, :full_parsed_line=>"15410002, PORK, CHOP, 108,955"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31500.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 31,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3773.0, :full_parsed_line=>"10500016, GARLIC, 3,773"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0, :full_parsed_line=>"23231017, DELFI, MINI, TOYS, 16,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0, :full_parsed_line=>"23241016, DELFI, ALMOND, 140GR, 31,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>12642.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 12,642"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>134000.0,
  #          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030191, THINS, ORI, AUS, 175, GR, 66,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 25,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0, :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 30,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>30000.0,
  #          :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 30,000"}],
  #        957971.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 11', freezed_time: '2022-12-11T09:52:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out36.jpg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>21500.0,
  #         :full_parsed_line=>"22202017, PASEO, SOFT, SINGLE250, 21,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>59400.0, :full_parsed_line=>"310014, POTATO, GRANOLA, LOOSE, 59,400"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11760.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 11,760"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20004004, FANTA, STRAW, PET, 1.5L, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>23923.0, :full_parsed_line=>"10082044, MANGO, HRMNIS, TKPOHON, 23,923"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>6500.0, :full_parsed_line=>"24020060, GREENFIELDS, YG, S150G, 6,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>146292.0, :full_parsed_line=>"11042001, TUNA, STEAK, 146,292"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0, :full_parsed_line=>"23241016, DELFI, ALMOND, 140GR, 31,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24020136, M00, KEFIR, 300M, 40,500"}],
  #       474375.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 12', freezed_time: '2022-12-13T06:20:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out37.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Бакалея",
  #         :price=>49500.0,
  #         :full_parsed_line=>"23512075, BARILLA, FARFALLE, 500, 49, ,, 500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>13000.0,
  #         :full_parsed_line=>"23230020, DELFI, ZAP, CHOC, 42, GR, 13,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Молочка",
  #         :price=>50000.0,
  #         :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50, ,, 000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0, :full_parsed_line=>"24211803, WALLS, CRNT, SLRQN108M, 12,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>147500.0,
  #         :full_parsed_line=>"24033041, ANCHOR, COOK, CREAM, 1L, 147, ,, 500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13500.0, :full_parsed_line=>"10400106, RUCOLA, 250, GR, 13,500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Фрукты",
  #         :price=>15308.0,
  #         :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 15, ,, 308"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 31,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Колбаса, сосиски",
  #         :price=>33500.0,
  #         :full_parsed_line=>"16200020, HUNGARISALAM100MAMAS, 33, ,, 500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0, :full_parsed_line=>"23032020, MEIJI, HLLO, PNDA, STR, 8,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0, :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 32,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14320.0, :full_parsed_line=>"10362003, KYURI, BABY, 14, ,, 320"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 32,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22790.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 22, ,, 790"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46710.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 46,710"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0, :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 32,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>22000.0,
  #         :full_parsed_line=>"23230030, KIT, KAT, 2F, ALU, 48X17, 22,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>15000.0,
  #         :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 15, ,, 000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 30,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>15000.0,
  #         :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 15,000"}],
  #       734628.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 13', freezed_time: '2022-12-14T09:52:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out38.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>110500.0,
  #         :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 110,500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Новопочта",
  #         :price=>19000.0,
  #         :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45570.0, :full_parsed_line=>"24041001, PERFETTO, MOZARELLA, C, 45,570"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41535.0, :full_parsed_line=>"10340009, ASPARAGUS, GREEN, B, 41,535"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20640.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 20, ,, 640"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>173020.0, :full_parsed_line=>"11041004, BARRAMUNDI, FILLET, ON, 173,020"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45475.0, :full_parsed_line=>"12301025, PAHA, ATAS, 45,475"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>64812.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 64,812"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Колбаса, сосиски",
  #         :price=>35000.0,
  #         :full_parsed_line=>"16200043, MAMAS, SALAM, MLN0O100G, 35,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 18,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 5,000"}],
  #       665552.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 14', freezed_time: '2022-12-18T10:08:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out39.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0, :full_parsed_line=>"24042040, YUMMY, CREME, FRCE, 200, 77,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 132,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56500.0, :full_parsed_line=>"24044017, BEL, CHESE, DIPPRS140G, 56,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29862.0, :full_parsed_line=>"10363010, CAPSICUM, GRN, HIDROPO, 29,862"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Фрукты",
  #          :price=>18146.0,
  #          :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 18, ,, 146"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>95500.0,
  #          :full_parsed_line=>"16100040, EL, PRIMO, BF, CHSE500G, 95,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>95500.0, :full_parsed_line=>"16100041, EL, PRIMO, BEEF, FR500G, 95,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>40500.0,
  #          :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 40, ,, 500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"К пиву",
  #          :price=>23000.0,
  #          :full_parsed_line=>"23020018, TG, CASHEWNUTS, HNY, 35, 23, ,, 000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4500.0, :full_parsed_line=>"10400259, PARSLEY, 100, GR, 4,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3000.0, :full_parsed_line=>"20081011, NESTLE, WTR, BTL, 600ML, 3,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3500.0, :full_parsed_line=>"20081001, AQUA, WATER, BTL, 600ML, 3,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40388.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 40,388"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>74640.0, :full_parsed_line=>"10000024, APPLE, RYL, GLA, USA, 80, 74,640"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148000.0, :full_parsed_line=>"23362020, NUTELLA, T680, GR, 148,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24020136, M00, KEFIR, 300M, 40, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5934.0, :full_parsed_line=>"10340001, DAUN, BAWANG, BESAR, 5,934"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 25,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18980.0, :full_parsed_line=>"10360014, TOMATO, TW, CURAH, 18,980"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29892.0, :full_parsed_line=>"12301800, CHICKEN, MILL, MEAT, 29, ,, 892"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33630.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 33, ,, 630"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>43977.0, :full_parsed_line=>"12301803, CHICKEN, FILLET, 43,977"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>66822.0, :full_parsed_line=>"12400007, BEEF, TOP, SIDE, 66,822"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9082.0, :full_parsed_line=>"10352014, CABBAGE, CHINESE, 9, ,, 082"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>104000.0,
  #          :full_parsed_line=>"24042004, BAROS, GOUDA, CS, M250G, 104,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 31,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>44500.0, :full_parsed_line=>"24020137, PLAIN, YOGURT, 350G, 44,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>19500.0, :full_parsed_line=>"23023019, REBO, KUACI, SPRORI150, 19,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>67000.0,
  #          :full_parsed_line=>"16200020, HUNGARISALAM100MAMAS, 67,000"}],
  #        1418353.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 15', freezed_time: '2022-12-25T04:26:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out40.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>59500.0, :full_parsed_line=>"16101068, BERNARDI, BF, BTWT310G, 59,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>53514.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 53,514"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>56905.0, :full_parsed_line=>"12301025, PAHA, ATAS, 56.905"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47399.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 47,399"},
  #        {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0, :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45927.0, :full_parsed_line=>"12201001, PORK, LEG, /, EISBEIN, 45,927"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29779.0, :full_parsed_line=>"10301010, DILL, LOOSE, 29, ,, 779"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>29412.0, :full_parsed_line=>"11042002, SWORDFISH, STEAK, 29,412"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>117902.0, :full_parsed_line=>"TUNA, STEAK, 117,902"}],
  #       459338.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 16', freezed_time: '2022-12-28T08:49:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out41.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>50000.0,
  #         :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 50,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39474.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 39,474"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 34,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Кофе, Чай",
  #         :price=>161500.0,
  #         :full_parsed_line=>"23314007, NESCAFE, GOLD, DECAFFE, 161,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>105000.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 105,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11748.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 11,748"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>37442.0, :full_parsed_line=>"12301025, PAHA, ATAS, 37,442"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>34191.0, :full_parsed_line=>"10362018, ZUCCHINI, GREEN, 34, ,, 191"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Овощи",
  #         :price=>104850.0,
  #         :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 104, ,, 850"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40866.0, :full_parsed_line=>"10313005, RED, RADISH, 40, ,, 866"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>50000.0,
  #         :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 50,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12560.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,560"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12000.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 34,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0, :full_parsed_line=>"10400124, RUCOLA, HYDROPNK, 250G, 20,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 18,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>34000.0, :full_parsed_line=>"23241015, DELFI, CHOCOLATEALM50, 34,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>34000.0,
  #         :full_parsed_line=>"23242004, DELFI, FRUIT, &, NUT, 50, 34,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>134000.0,
  #         :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"}],
  #       1026631.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 17', freezed_time: '2022-12-30T07:30:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out42.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>77778.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 77,778"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3000.0, :full_parsed_line=>"20081014, CHEERS, WATER, 500, ML, 3,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>52500.0,
  #          :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 52, ,, 500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>40500.0,
  #          :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 40, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Алкоголь",
  #          :price=>317590.0,
  #          :full_parsed_line=>"20200074, HATTEN, AGA, RED, CASK, 317, ,, 590"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Фрукты",
  #          :price=>23134.0,
  #          :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 23, ,, 134"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>77770.0, :full_parsed_line=>"10000022, APPLE, ROSE, NZ, 80/110, 77,770"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Кофе, Чай",
  #          :price=>145500.0,
  #          :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>150300.0, :full_parsed_line=>"11042001, TUNA, STEAK, 150, ,, 300"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>131706.0, :full_parsed_line=>"12201002, PORK, NECK, 131, ,, 706"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>38025.0, :full_parsed_line=>"10363008, CAPSICUM, RED, HIDROPO, 38, ,, 025"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>57750.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 57,750"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>70000.0,
  #          :full_parsed_line=>"16200043, MAMAS, SALAM, MLN0100G, 70,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>147000.0,
  #          :full_parsed_line=>"16403014, EL, PRIMO, CHC, FRK500G, 147,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>52000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 52, ,, 000"}],
  #        1471053.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 18', freezed_time: '2022-12-31T08:30:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out43.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Для дома",
  #         :sub_category_name=>"инвентарь",
  #         :price=>48000.0,
  #         :full_parsed_line=>"35100003, WOOD, CHARCOAL, 1, KG, 48,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>263900.0, :full_parsed_line=>"20202029, SABABAY, ASCARO, 750M, 263,900"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>75469.0, :full_parsed_line=>"10367010, RED, ONION, LARGE, 75,469"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"К пиву",
  #         :price=>66500.0,
  #         :full_parsed_line=>"23030195, THINS, CRM, &, CHIVES, 175, 66,500"}],
  #       536369.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 19', freezed_time: '2023-01-09T03:47:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out44.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54000.0, :full_parsed_line=>"24041027, BEGA, SPER, SLICES250G, 54,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0, :full_parsed_line=>"24214008, WALLS, MGNUM, M., A6X45M, 50,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29646.0, :full_parsed_line=>"12201001, PORK, LEG, /, EISBEIN, 29,646"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0, :full_parsed_line=>"WALLS, MGNUM, M., A6X45M, 50,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>19890.0, :full_parsed_line=>"PAHA, BAWAH, 19, ,, 890"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>37636.0, :full_parsed_line=>"PAHA, ATAS, 37,636"}],
  #        327172.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 20', freezed_time: '2023-01-21T07:09:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out45.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Новопочта",
  #         :price=>19000.0,
  #         :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 53,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Колбаса, сосиски",
  #         :price=>136694.0,
  #         :full_parsed_line=>"12201012, SALAMINOSTRACBITALIA, 136,694"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>56908.0, :full_parsed_line=>"12202008, BACK, BACON, 56,908"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 59,400"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0, :full_parsed_line=>"23230034, NESTLE, KITKAT, CHNK38, 37,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32000.0, :full_parsed_line=>"10400162, WILD, RUCOLA, ORG, 200G, 32,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 14,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>14000.0,
  #         :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 14,000"}],
  #       477002.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 21', freezed_time: '2023-01-21T07:15:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out46.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"К пиву",
  #         :price=>70500.0,
  #         :full_parsed_line=>"23030195, THINS, CRM, &, CHIVES, 175, 70,500"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>61000.0,
  #         :full_parsed_line=>"22204014, PASEO, WHITE, 8RL, 280S, 61,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 48,800"},
  #        {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20021015, RAUCH, HD, ORANGE, 1L, 48,800"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>31000.0, :full_parsed_line=>"23030055, LORENZ, BARBECUE, 100G, 31,000"}],
  #       260100.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 22', freezed_time: '2023-01-21T07:20:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out47.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>53500.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 53,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8299.0, :full_parsed_line=>"10312008, CARROT, MEDIUM, IMPORT, 8, ,, 299"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>56000.0,
  #          :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 56,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23400.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 23, ,, 400"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25576.0, :full_parsed_line=>"12301025, PAHA, ATAS, 25,576"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>89034.0, :full_parsed_line=>"10070001, CHERRY, 26-28, AUST, 89, ,, 034"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>56000.0,
  #          :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 56,000"}],
  #        311809.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 23', freezed_time: '2023-01-27T08:22:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out48.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>24500.0, :full_parsed_line=>"24010011, GREENFIELDS, F.C, 1L, 24,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>168000.0,
  #          :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 168,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>111000.0,
  #          :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 111,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Кухонные принадлежности",
  #          :price=>24000.0,
  #          :full_parsed_line=>"21010003, BAGUS, S., BILAS, T560, 24,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>20500.0, :full_parsed_line=>"23233005, HERSHEY, KS, CKSNCRM36, 20,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>118800.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 118,800"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Кухонные принадлежности",
  #          :price=>13300.0,
  #          :full_parsed_line=>"21040043, BIO, +, JRK, NPS, 780ML, 13,300"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>134000.0,
  #          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>63000.0, :full_parsed_line=>"23241016, DELFI, ALMOND, 140GR, 63,000"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Ванные принадлежности",
  #          :price=>9500.0,
  #          :full_parsed_line=>"21113003, PROCLIN, W, CRYSTAL125, 9,500"}],
  #        804600.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 24', freezed_time: '2023-01-28T03:00:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out49.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0, :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 14,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 14,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>64000.0,
  #          :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>28000.0, :full_parsed_line=>"23822003, DAUCY, CRS, SWTCORN300, 28,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>97500.0, :full_parsed_line=>"23246120, SQ, B2G1, PROMO, PACK, 97,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>17500.0, :full_parsed_line=>"23802010, BESTANAKU, CHU, OIL, 150, 17,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3500.0, :full_parsed_line=>"20081001, AQUA, WATER, BTL, 600ML, 3,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>191000.0,
  #          :full_parsed_line=>"16100040, EL, PRIMO, BF, CHSE500G, 191,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54000.0, :full_parsed_line=>"24041027, BEGA, SPER, SLICES250G, 54,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21500.0, :full_parsed_line=>"10360001, TOMATO, CHER, RED335, 21,500"}],
  #        505000.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 25', freezed_time: '2023-01-28T03:25:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out50.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Кухонные принадлежности",
  #          :price=>40000.0,
  #          :full_parsed_line=>"22202018, PASEO, SOFT, MED, 220S, 40,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>46000.0, :full_parsed_line=>"23503018, SHUKRIYA, RICE, 1, KG, 46,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>23000.0, :full_parsed_line=>"24010011, GREENFIELDS, F.C, 1L, 23,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>59648.0, :full_parsed_line=>"12201019, PORK, LOIN, 59,648"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>44800.0, :full_parsed_line=>"12201019, PORK, LOIN, 44,800"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>96944.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 96,944"}],
  #        367892.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 26', freezed_time: '2023-02-03T09:42:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out51.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Новопочта",
  #          :price=>19000.0,
  #          :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>25069.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 25,069"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>38000.0, :full_parsed_line=>"20015069, SUNFRSH, PREM, MANGO1L, 38,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>14184.0, :full_parsed_line=>"10031015, WATERMELON, RED, 14, ,, 184"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>157500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 157,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>33200.0, :full_parsed_line=>"23240046, VH, DARK, MILKCHO, 140G, 33,200"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>117000.0, :full_parsed_line=>"23240047, SCHOGTN, MILKCH0100G, 117,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78000.0, :full_parsed_line=>"23360034, METZGR, B, CAFE, PRS150, 78,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>104448.0, :full_parsed_line=>"12201019, PORK, LOIN, 104,448"}],
  #        602401.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 27', freezed_time: '2023-02-12T03:25:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out52.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7905.0, :full_parsed_line=>"10352014, CABBAGE, CHINESE, 7,905"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31600.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,600"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>21000.0,
  #          :full_parsed_line=>"23638061, KIKKOMAN, TRY, LHTM300, 21,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16950.0, :full_parsed_line=>"10351001, BROCCOLI, LOCAL, 16,950"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Алкоголь",
  #          :price=>21000.0,
  #          :full_parsed_line=>"20100004, BALI, HAI, CAN330ML24, ', 21,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>50500.0,
  #          :full_parsed_line=>"24045057, EMINA, SMOK, CHES, 150G, 50, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>14000.0, :full_parsed_line=>"20007004, BINTANG, RDLR, BLCK330, 14,000"}],
  #        387455.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 28', freezed_time: '2023-02-12T04:44:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out53.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Алкоголь",
  #         :price=>320775.0,
  #         :full_parsed_line=>"20201080, HATTEN, AGA, WHITE, CAS, 320, ,, 775"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>36096.0, :full_parsed_line=>"12201019, PORK, LOIN, 36,096"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40704.0, :full_parsed_line=>"12201019, PORK, LOIN, 40, ,, 704"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>81500.0, :full_parsed_line=>"16202014, SVENSCHOC, PORKPT125G, 81,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27000.0, :full_parsed_line=>"23030163, EL, CHILE, CORN, CHP200, 27,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>31000.0, :full_parsed_line=>"23030055, LORENZ, BARBECUE, 100G, 31,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>54000.0,
  #         :full_parsed_line=>"23610028, FILIPPO, EX, VR, OIL250, 54,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"}],
  #       643575.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive not parsed one fake product', freezed_time: '2023-02-12T03:42:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/not_parsed_one_fake_product.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>30192.0, :full_parsed_line=>"12301026, not, parsed, 1, 30, ,, 192"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31540.0, :full_parsed_line=>"12301007, CHICKEN, WING, 31,540"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>110500.0,
  #          :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 110,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>24500.0, :full_parsed_line=>"SPAGHETTI, BOLOGNESE, 24,500"}],
  #        196732.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 29', freezed_time: '2023-02-12T05:36:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out54.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>89500.0, :full_parsed_line=>"23615005, GOLDEN, SNFLOWER, OIL1, 89,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>42745.0, :full_parsed_line=>"12301025, PAHA, ATAS, 42,745"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>117000.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 117,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31291.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 31, ,, 291"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>63000.0, :full_parsed_line=>"23242005, DELFI, FRUIT, &, NUT140, 63,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17000.0, :full_parsed_line=>"10320091, JAMUR, CHAMPIGNON, FRE, 17,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>28000.0, :full_parsed_line=>"10400119, LEAF, OILL, 200, GR, 28,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>8000.0, :full_parsed_line=>"24010014, GREENFIELDS, F.C, 125, 8,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>8000.0, :full_parsed_line=>"24018006, GREENFIELDS, STR125, 8.000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24000.0, :full_parsed_line=>"24203002, WALLS, 3IN1, NPLTN350M, 24,000"}],
  #       483036.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 30', freezed_time: '2023-02-17T14:19:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out55.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>40000.0, :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 40,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 53,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19304.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 19,304"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24042013, KIRI, CHEESE, CRM, 120G, 40,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10000.0, :full_parsed_line=>"10400016, DAUN, BAWANG, 200, SFO, 10,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>88201.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 88,201"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>149380.0, :full_parsed_line=>"15410002, PORK, CHOP, 149,380"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12848.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,848"},
  #        {:category_name=>"Для дома", :price=>28000.0, :sub_category_name=>"Ванные принадлежности", :full_parsed_line=>"22185002, ORALB, TB, STG2, WINNIE, 28,000"},
  #        {:category_name=>"Лиля",:sub_category_name=>"Ванные принадлежности",:price=>9000.0,:full_parsed_line=>"22230008, LAURIER, PL, SLV, DE020, 9,000"}],
  #       603233.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 31', freezed_time: '2023-02-17T14:27:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out56.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>11800.0, :full_parsed_line=>"24011021, GREENFIELDS, CHMLT200, 11,800"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>13500.0, :full_parsed_line=>"23330017, PSM, GULA, 1KG, 13,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>145500.0, :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24201006, WALLS, VANILLA, 700ML, 38,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24203003, WALLS, NPLTNA, 700ML, 38,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>153500.0, :full_parsed_line=>"10060800, STRAWBERRY, KOREA, 250, 153,500"}],
  #        400300.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 32', freezed_time: '2023-02-21T08:22:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out57.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>9000.0, :full_parsed_line=>"10000012, APPLE, RYL, GLA, USA125, 9,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>77400.0, :full_parsed_line=>"10301010, DILL, LOOSE, 77,400"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>107030.0, :full_parsed_line=>"15410002, PORK, CHOP, 107,030"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>156294.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 156,294"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>70713.0, :full_parsed_line=>"12201002, PORK, NECK, 70,713"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17000.0, :full_parsed_line=>"10320091, JAMUR, CHAMPIGNON, FRE, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39500.0, :full_parsed_line=>"24042014, THE, LAUGHNG, CWCHS8S, 39,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33500.0, :full_parsed_line=>"10400106, RUCOLA, 250, GR, 33,500"}],
  #        510437.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 33', freezed_time: '2023-02-21T08:34:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out58.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>35000.0, :full_parsed_line=>"13600041, ROTI, BGB, 35000, 35,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>147000.0, :full_parsed_line=>"10063002, BLUEBERRY, 125GR, SPAN, 147,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>42594.0, :full_parsed_line=>"24041003, ANCHOR, CHDDR, COLOURD, 42,594"},
  #         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>49980.0, :full_parsed_line=>"16200022, COOKED, HAM, 49,980"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Колбаса, сосиски",
  #          :price=>31000.0,
  #          :full_parsed_line=>"16200044, MAMAS, FRNCH, SLMI100G, 31,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Кофе, Чай",
  #          :price=>145500.0,
  #          :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"}],
  #        471074.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 34', freezed_time: '2023-02-28T03:00:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out59.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>24983.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 24,983"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24684.0, :full_parsed_line=>"10340002, DAUN, BAWANG, CHUNG, 24, ,, 684"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52, ,, 500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>47940.0, :full_parsed_line=>"12202013, SMOKED, COOKED, HAM, 47,940"},
  #         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>50711.0, :full_parsed_line=>"16200023, DANISH, HAM, 50,711"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>18500.0, :full_parsed_line=>"23390016, CAKRA, KEMBAR, TERIGU1, 18,500"},
  #         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>20000.0, :full_parsed_line=>"22202018, PASEO, SOFT, MED, 220S, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10209.0, :full_parsed_line=>"10363010, CAPSICUM, GRN, HIDROPO, 10, ,, 209"}],
  #        338027.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 35', freezed_time: '2023-03-02T00:52:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out60.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Кофе, Чай",
  #          :price=>145500.0,
  #          :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>50500.0,
  #          :full_parsed_line=>"23621012, PURA, SEA, SLT, FINE300, 50,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0, :full_parsed_line=>"24042040, YUMMY, CREME, FRCE, 200, 77,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Хлеб и др",
  #          :price=>22500.0,
  #          :full_parsed_line=>"13020005, RUMAH, ROTI, BROWN, COB, 22,500"}],
  #        346000.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 36', freezed_time: '2023-03-05T03:06:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out61.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20026039, RAUCH, HD, CRANBERRY1L, 56,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>134000.0,
  #          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>177870.0, :full_parsed_line=>"15410002, PORK, CHOP, 177,870"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6000.0, :full_parsed_line=>"20000007, COCA, COLA, PET, 390ML, 6,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35894.0, :full_parsed_line=>"12201003, PORK, FILLET, 35,894"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>177000.0,
  #          :full_parsed_line=>"24213001, HAAGENDAZS, VNLA, 100M, 177,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56000.0, :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 56,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Специи, приправы",
  #          :price=>20000.0,
  #          :full_parsed_line=>"23624056, JAYS, BAY, LEAVES, 8, GR, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26450.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 26,450"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 53,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46032.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 46,032"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26640.0, :full_parsed_line=>"10000012, APPLE, RYL, GLA, USA125, 26,640"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>139385.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 139,385"}],
  #        981771.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 37', freezed_time: '2023-03-17T05:46:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out62.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>64000.0,
  #         :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>38976.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 38,976"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Колбаса, сосиски",
  #         :price=>9000.0,
  #         :full_parsed_line=>"16101023, KANZLER, SNGLE, ORI65G, 9,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 59,400"},
  #        {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>67000.0, :full_parsed_line=>"23803006, SUNVIEW, ANCHVY, FIL48, 67,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>26182.0, :full_parsed_line=>"12301800, CHICKEN, MILL, MEAT, 26,182"}],
  #       264558.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 38', freezed_time: '2023-03-24T13:25:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out63.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>70500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 70,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47000.0, :full_parsed_line=>"20026011, COMPAL, NCT, PEACH, 1L, 47,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39500.0, :full_parsed_line=>"24042014, THE, LAUGHNG, CWCHS8S, 39,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>251750.0, :full_parsed_line=>"20201057, ISOLA, WHITE, WINE750M, 251,750"},
  #         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>5000.0, :full_parsed_line=>"33301006, SHOPPING, B, FRESTIVE, 5,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11165.0, :full_parsed_line=>"10312008, CARROT, MEDIUM, IMPORT, 11,165"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>84500.0, :full_parsed_line=>"24044050, YUMMY, FETAH, CHESE250, 84,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49000.0, :full_parsed_line=>"24020117, BIOKUL, YGHRT, STRW, 1L, 49,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9180.0, :full_parsed_line=>"10365005, CORN, SWEET, PEEL, 9,180"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>132073.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 132,073"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35768.0, :full_parsed_line=>"12201005, PORK, BELLY, 35,768"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12060.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 12,060"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 59,400"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55200.0, :full_parsed_line=>"10301010, DILL, LOOSE, 55,200"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"10800007, PURI, CHEERY, 15K, 15,000"}],
  #        1089096.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 39', freezed_time: '2023-03-27T06:09:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out64.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>19008.0, :full_parsed_line=>"10031015, WATERME_ON, RED, 19,008"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>41808.0, :full_parsed_line=>"12400007, BEEF, TOP, SIDE, 41,808"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>145783.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 145,783"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>32500.0, :full_parsed_line=>"24051004, BIOLAND, ORG, EGG, 10'S, 32,500"}],
  #        239099.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 40', freezed_time: '2023-04-09T05:07:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out65.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>104500.0, :full_parsed_line=>"24021072, YUMMY, YOG, STRAW500GR, 104,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD200G, 59,400"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>153500.0, :full_parsed_line=>"10060800, STRAWBERRY, KOREA, 250, 153,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>30000.0,
  #          :full_parsed_line=>"23240006, BALI, BONBON, PLAIN, 50, 30,000"}],
  #        481900.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 41', freezed_time: '2023-04-24T08:31:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out66.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>58500.0, :full_parsed_line=>"23246118, SCHOGTN, STRCITLA100G, 58,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>64000.0, :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>140140.0, :full_parsed_line=>"15410002, PORK, CHOP, 140,140"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13009017, DE, BAKKER, ROSEMARY, B, 22,000"}],
  #        366640.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 42', freezed_time: '2023-04-27T11:03:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out67.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>209000.0, :full_parsed_line=>"20202010, SABABAY, PINK, BLSM750, 209,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0, :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>34155.0, :full_parsed_line=>"10041010, PEAR, HONEY, BELLE, 34,155"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>15000.0, :full_parsed_line=>"23330015, FS, GULA, PUTIH, 1, KG, 15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>112000.0, :full_parsed_line=>"24214008, WALLS, MGNUM, M.A6X45M, 112,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56000.0, :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 56,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45500.0, :full_parsed_line=>"24021046, GREENFIELDS, YG, M500M, 45,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #         {:category_name=>"Лиля", :sub_category_name=>"Ванные принадлежности", :price=>9000.0, :full_parsed_line=>"22230008, LAURIER, PL, SLV, DE020, 9,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>74000.0, :full_parsed_line=>"24021160, MASCARPN, CHSVAN70, 74,000"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Ванные принадлежности",
  #          :price=>28000.0,
  #          :full_parsed_line=>"22185001, ORALB, TB, STG3, PRINCE, 28,000"},
  #         {:category_name=>nil, :sub_category_name=>nil, :price=>105500.0, :full_parsed_line=>"24044084, 8DG, CH, GRK, STFT200GR, 105,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>70500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 70,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27000.0, :full_parsed_line=>"10400106, RUCOLA, 250, GR, 27,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"}],
  #        914655.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 43', freezed_time: '2023-05-07T02:28:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out68.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 32,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>10660.0, :full_parsed_line=>"10031011, PEPAYA, CALIFORNIA, 10,660"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47000.0, :full_parsed_line=>"20026010, COMPAL, NCT, PEAR, 1L, 47,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>64000.0, :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 56,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
  #         {:category_name=>"Для дома",
  #          :sub_category_name=>"Кухонные принадлежности",
  #          :price=>21500.0,
  #          :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 21,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>153000.0, :full_parsed_line=>"24043015, PAYSON, BRETON, E, 250, 153,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23256.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 23,256"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>14500.0, :full_parsed_line=>"23373057, QUAKER, OAT, INS, R200G, 14,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17000.0, :full_parsed_line=>"24021039, GRENFLDS, Y, BLUEBERRY, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021045, GREENFIELD, YG, MG125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>109500.0, :full_parsed_line=>"10064005, RASPBERRY, 170, ALLSEA, 109,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021045, GREENFIELD, YG, MG125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>136000.0, :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 136,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD200G, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0, :full_parsed_line=>"23230034, NESTLE, KITKAT, CHNK38, 25,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>74000.0, :full_parsed_line=>"24021160, MASCARPN, CHSVAN70, 74,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SÄLTD200G, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>12201.0, :full_parsed_line=>"10021002, ANGGUR, BALI, 12,201"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>59500.0, :full_parsed_line=>"16200042, MAMAS, STRKY, BCN, 250G, 59,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49500.0, :full_parsed_line=>"24040015, MINI, BABYBEL, CHDDR5S, 49,500"}],
  #        1381617.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 44', freezed_time: '2023-06-01T01:20:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out69.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Для дома",
  #         :sub_category_name=>"инвентарь",
  #         :price=>43500.0,
  #         :full_parsed_line=>"22104050, ANTIS, HS, JRK, NP, 200B, 43,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24610.0, :full_parsed_line=>"10362003, KYURI, BABY, 24,610"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>44500.0,
  #         :full_parsed_line=>"23618002, SW, DSTLD, WHT, VNGR16, 44,500"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Ванные принадлежности",
  #         :price=>7000.0,
  #         :full_parsed_line=>"21114012, KISPRAY, GOLD, 300, ML, 7,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25500.0, :full_parsed_line=>"24010011, GREENFIELDS, F.C, 1L, 25,500"}],
  #       181110.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 45', freezed_time: '2023-06-22T05:21:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out70.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>115500.0,
  #         :full_parsed_line=>"23615002, MAZÜLA, SNFLWR, OIL900, 115,500"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>64000.0,
  #         :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>54500.0,
  #         :full_parsed_line=>"23638117, HEINZ, YEL, MUSTRD, 140, 54,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Молочка",
  #         :price=>64500.0,
  #         :full_parsed_line=>"24021156, MILKUP, CTTGCHS9, %, 250G, 64,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>19951.0, :full_parsed_line=>"10021002, ANGGUR, BALI, 19,951"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>44880.0, :full_parsed_line=>"10020801, GRAPE, GREEN, SEEDLES, 44,880"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24288.0, :full_parsed_line=>"10362003, KYURI, BABY, 24,288"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Сладости",
  #         :price=>56000.0,
  #         :full_parsed_line=>"24214008, WALLS, MGNUM, M., A6X45M, 56,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24203003, WALLS, NPLTNA, 700ML, 38,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>25392.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 25,392"}],
  #       638511.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 46', freezed_time: '2023-06-25T11:30:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out71.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>78336.0, :full_parsed_line=>"10031013, WATERMELON, YELLOW, 78,336"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39984.0, :full_parsed_line=>"10020009, GRAPE, CALMERIA, USA, 39,984"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>12500.0, :full_parsed_line=>"23030120, PRINGLES, CHEESY, CHEE, 12,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>5500.0, :full_parsed_line=>"23013007, FINNA, PARS, BARBEQU40, 5,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>43218.0, :full_parsed_line=>"10020009, GRAPE, CALMERIA, USA, 43,218"}],
  #        179538.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 47', freezed_time: '2023-06-26T03:43:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out72.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42845.0, :full_parsed_line=>"10366002, KABOCHA, RED, 42,845"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Полуфабрикаты/морозилка",
  #          :price=>35000.0,
  #          :full_parsed_line=>"10701800, GOLDEN, FRAM, G.P, 500G, 35,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>147070.0, :full_parsed_line=>"15410002, PORK, CHOP, 147,070"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>151724.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 151,724"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18656.0, :full_parsed_line=>"10082073, MANGO, BUDI, RAJA, 18,656"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512073, BARILLA, FUSILLI, 500, 49,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>37000.0, :full_parsed_line=>"23512135, SAN, REMO, COUSCOUS500, 37,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>64500.0,
  #          :full_parsed_line=>"24021156, MILKUP, CTTGCHS9, %, 250G, 64,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>11124.0, :full_parsed_line=>"10082075, MANGOSTEEN, 11,124"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>125000.0, :full_parsed_line=>"24031019, LURPAK, DANISH, BUTTER, 125,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47488.0, :full_parsed_line=>"12021002, BEEF, TENDERLOIN, 47,488"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12496.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,496"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11616.0, :full_parsed_line=>"10362003, KYURI, BABY, 11,616"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>41000.0, :full_parsed_line=>"23512067, BARILLA, SPGHTTI5, 500, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17000.0, :full_parsed_line=>"24021039, GRENFLDS, Y, BLUEBERRY, 17,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Хлеб и др",
  #          :price=>40000.0,
  #          :full_parsed_line=>"13009014, DE, BAKKER, OLIVE, BREA, 40,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>15000.0, :full_parsed_line=>"13200001, WAFFLES, ORIGINAL, 70G, 15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021032, GREENFIELD, YG, OR125M, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 34,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34000.0, :full_parsed_line=>"24021056, GREENFIELDS, YG, M125G, 34,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021045, GREENFIELD, YG, MG125G, 17,000"}],
  #        1099019.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 48', freezed_time: '2023-06-29T11:19:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out73.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>74000.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 74,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Хлеб и др",
  #          :price=>20500.0,
  #          :full_parsed_line=>"13010009, RUMAH, ROTI, BREAD, WHI, 20,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Алкоголь",
  #          :price=>185250.0,
  #          :full_parsed_line=>"20201081, HATTEN, ALEXZANDRIA, B, 185,250"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12232.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,232"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>23000.0, :full_parsed_line=>"23802009, SUNBELL, TUNA, VEG, 185, 23,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>52302.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 52,302"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>56500.0, :full_parsed_line=>"10410109, ONI, BOM, R500, SUNRISE, 56,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14696.0, :full_parsed_line=>"10362003, KYURI, BABY, 14,696"}],
  #        438480.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 49', freezed_time: '2023-07-12T14:00:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out74.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда",
  #         :sub_category_name=>"Новопочта",
  #         :price=>38000.0,
  #         :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 38,000"},
  #        {:category_name=>"Еда",
  #         :sub_category_name=>"Специи, приправы",
  #         :price=>64000.0,
  #         :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>47500.0, :full_parsed_line=>"24052001, ROSSA, L.COLEST, EGG10, 47,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0, :full_parsed_line=>"13600007, BGB, BREAD, 16.000, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32000.0, :full_parsed_line=>"24021056, GREENFIELDS, YG, M125G, 32,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>56896.0, :full_parsed_line=>"10082042, MANGO, GEDONG, GINCU, 56,896"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27186.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 27,186"},
  #        {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33936.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 33,936"},
  #        {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>55552.0, :full_parsed_line=>"12021002, BEEF, TENDERLOIN, 55,552"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 16,000"},
  #        {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>16000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 16,000"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>16500.0,
  #         :full_parsed_line=>"22200003, PASEO, ULTRA, SOFT, 100, 16,500"},
  #        {:category_name=>"Для дома",
  #         :sub_category_name=>"Кухонные принадлежности",
  #         :price=>21500.0,
  #         :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 21,500"},
  #        {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>11520.0, :full_parsed_line=>"10031008, MELON, GOLDEN, 11,520"},
  #        {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>74000.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 74,000"}],
  #       661090.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 50', freezed_time: '2023-07-18T01:38:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out75.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>28500.0, :full_parsed_line=>"23503025, ROYAL, JASMN, RICE, 1KG, 28,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>236726.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 236,726"},
  #         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>10500.0, :full_parsed_line=>"20081023, BALIAN, WTR, BTL, 500ML, 10,500"}],
  #        275726.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 51', freezed_time: '2023-08-28T02:26:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out76.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>51300.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 51,300"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36500.0, :full_parsed_line=>"24042014, THE, LAUGHNG, CWCHS8S, 36,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>123000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 123,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0, :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 68,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53000.0, :full_parsed_line=>"24021112, BIOKUL, GR, YG, STR473G, 53,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021056, GREENFIELDS, YG, M125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 34,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>33408.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 33,408"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>46500.0, :full_parsed_line=>"23240016, TOBLERONE, MILK, 100GR, 46,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>120000.0, :full_parsed_line=>"23240008, RITTER, SPR, MLKCH0100, 120,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>70455.0, :full_parsed_line=>"15410002, PORK, CHOP, 70,455"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 34,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021056, GREENFIELDS, YG, M125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0, :full_parsed_line=>"23140021, DEKA, MN, WFR, BTSCH080, 8,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021049, GREENFIELD, YG, ST125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>109500.0, :full_parsed_line=>"10064005, RASPBERRY, 170, ALLSEA, 109,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 16,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148900.0, :full_parsed_line=>"23233014, KINDER, SCHOKOBON, 200, 148,900"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0, :full_parsed_line=>"23230013, DELFI, TOP, XL, 38, GR, 10,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>19000.0, :full_parsed_line=>"13008002, DE, BAKKER, COUNTRY, BR, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26772.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 26,772"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 16,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD200G, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>56211.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 56,211"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11900.0, :full_parsed_line=>"10316002, PEELED, GARLIC, 11,900"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>63000.0, :full_parsed_line=>"10063008, BLUEBERRY, IMPORT, 125, 63,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35000.0, :full_parsed_line=>"10400162, WILD, RUCOLA, ORG, 200G, 35,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>14678.0, :full_parsed_line=>"10031008, MELON, GOLDEN, 14,678"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>54000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 54,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 68,000"}],
  #        1540124.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 52', freezed_time: '2023-09-08T02:04:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out77.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>113750.0, :full_parsed_line=>"11041006, SALMON, FILLET, 113,750"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>31500.0, :full_parsed_line=>"23802005, PRONAS, TUNA, OIL, 185, 31,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 48,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>123000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 123,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 32,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD200G, 132,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64500.0, :full_parsed_line=>"24021156, MILKUP, CTTGCHS9, %, 250G, 64,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>110000.0, :full_parsed_line=>"24044047, GREENFIELDS, BCNI330G, 110,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>14098.0, :full_parsed_line=>"10031021, MELON, ROCK, 14,098"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>115500.0, :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 115,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23230007, SILVER, QUEEN, R, /, MLK22, 15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0, :full_parsed_line=>"23230018, DELFI, BAR, WFR, CHOC18, 5,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>58500.0, :full_parsed_line=>"10060013, STRAW, A, 220, LA, FRESA, 58,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41760.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 41,760"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45936.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 45,936"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>86938.0, :full_parsed_line=>"11041006, SALMON, FILLET, 86,938"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23125.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 23,125"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>63000.0, :full_parsed_line=>"10063008, BLUEBERRY, IMPORT, 125, 63,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56000.0, :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 56,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>31000.0, :full_parsed_line=>"13000015, DE, BAKKER, CHAMPAGNE, 31,000"}],
  #        1211107.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 53', freezed_time: '2023-09-16T09:22:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out78.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>66000.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 66,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>130000.0, :full_parsed_line=>"23615801, MAZOLA, SUNFLOWER, 450, 130,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14157.0, :full_parsed_line=>"10316002, PEELED, GARLIC, 14,157"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24201006, WALLS, VANILLA, 700ML, 38,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19000.0, :full_parsed_line=>"10360002, TOM, CHR, RD, HIDROP250, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14364.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 14,364"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051004, BIOLAND, ORG, EGG, 10'S, 37,500"}],
  #        479521.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 54', freezed_time: '2023-09-16T09:32:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out79.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>nil, :sub_category_name=>nil, :price=>52000.0, :full_parsed_line=>"23123009, CASA, R, SAVOI, TIRM200, 52,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>45900.0, :full_parsed_line=>"23370020, KELLOGGS, FRT, LPS300G, 45,900"},
  #         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0, :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>86500.0, :full_parsed_line=>"23361017, BONNE, BLCKBRY, 370G, 86,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>26500.0, :full_parsed_line=>"24051005, RED, EGG, 10'S, 26,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>25000.0, :full_parsed_line=>"23802009, SUNBELL, TUNA, VEG, 185, 25,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>28536.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 28,536"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>18320.0, :full_parsed_line=>"24041003, ANCHOR, CHDDR, COLOURD, 18,320"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>45500.0, :full_parsed_line=>"10022008, GRAPE, MUS, RRC450-500, 45,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 32,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>56500.0, :full_parsed_line=>"10410109, ONI, BOM, R500, SUNRISE, 56,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>48900.0, :full_parsed_line=>"24033050, HULALA, WHIP, 500, ML, 48,900"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>78351.0, :full_parsed_line=>"10082042, MANGO, GEDONG, GINCU, 78,351"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35000.0, :full_parsed_line=>"10400162, WILD, RUCOLA, ORG, 200G, 35,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021056, GREENFIELDS, YG, M125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>82390.0, :full_parsed_line=>"15410002, PORK, CHOP, 82,390"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15928.0, :full_parsed_line=>"10362003, KYURI, BABY, 15,928"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>19000.0, :full_parsed_line=>"24000006, GREENFIELDS, FULL, 500, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48500.0, :full_parsed_line=>"23362021, NUTELLA, T, 200, GR, 48,500"},
  #         {:category_name=>"Для дома", :sub_category_name=>"Аптека", :price=>20500.0, :full_parsed_line=>"23223030, STREPSIL, VITC, 20.8G, 20,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>29792.0, :full_parsed_line=>"24041002, ANCHOR, CHEEDDR, PALE, 29,792"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 17,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>28500.0, :full_parsed_line=>"24072003, TARAMI, JLY, MNGO, 150G, 28,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5500.0, :full_parsed_line=>"23394013, NUTRIJELL, DELIMA15GR, 5,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15312.0, :full_parsed_line=>"10362003, KYURI, BABY, 15,312"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>101500.0, :full_parsed_line=>"16106014, Fume, Duck, LegConfit, 101,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>100000.0, :full_parsed_line=>"10060006, STRAWBERRY, AUS, 250GR, 100,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18500.0, :full_parsed_line=>"10083010, PINEAPPLE, BB, HN, PACK, 18,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>71000.0, :full_parsed_line=>"10064006, RASPBERRY, 125, GR, 71,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>63000.0, :full_parsed_line=>"10063008, BLUEBERRY, IMPORT, 125, 63,000"}],
  #        1347429.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt frestive 55', freezed_time: '2023-11-05T02:23:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/frestive/out80.jpeg") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512075, BARILLA, FARFALLE, 500, 49,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>31200.0, :full_parsed_line=>"10315802, KAPRI, 31,200"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11286.0, :full_parsed_line=>"10352004, CABBAGE, WHITE, 11,286"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>202908.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 202,908"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16500.0, :full_parsed_line=>"13200001, WAFFLES, ORIGINAL, 70G, 16,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>64500.0, :full_parsed_line=>"24021156, MILKUP, CTTGCHS9, %, 250G, 64,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24020136, MOO, KEFIR, 300M, 40,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7038.0, :full_parsed_line=>"10313024, BEETROOT, M, 7,038"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11300.0, :full_parsed_line=>"10316002, PEELED, GARLIC, 11,300"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"10410135, CARROT, ORGANIC, 500GR, 15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27860.0, :full_parsed_line=>"10351006, BROCCOLI, IMPORT, 27,860"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16368.0, :full_parsed_line=>"10362003, KYURI, BABY, 16,368"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13904.0, :full_parsed_line=>"10362003, KYURI, BABY, 13,904"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>42080.0, :full_parsed_line=>"12201005, PORK, BELLY, 42,080"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>38880.0, :full_parsed_line=>"12400007, BEEF, TOP, SIDE, 38,880"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19000.0, :full_parsed_line=>"10360002, TOM, CHR, RD, HIDROP250, 19,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41610.0, :full_parsed_line=>"10082158, AVOCADO, SUPER, 41,610"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16506.0, :full_parsed_line=>"10031008, MELON, GOLDEN, 16,506"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>99500.0, :full_parsed_line=>"24042003, BAROS, GOUDA, CHSE250G, 99,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>99500.0, :full_parsed_line=>"10063007, BLUEBERRY, 125, ALLSEA, 99,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>11983.0, :full_parsed_line=>"10031011, PEPAYA, CALIFORNIA, 11,983"},
  #         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>41000.0, :full_parsed_line=>"23512067, BARILLA, SPGHTTI5, 500, 41,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"}],
  #       980923.0,
  #       nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end

  # context 'when receipt bali direct store 1', freezed_time: '2022-11-15T10:06:00+00:00' do
  #   let(:get_telegram_image) { File.read("spec/images/out14.png") }

  #   it 'return 3 values' do
  #     result = subject

  #     sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
  #     expect(result).to eq(
  #       [[{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>184500.0, :full_parsed_line=>"Organic, Whole, Chicken, 1, Rp184,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>132500.0,
  #          :full_parsed_line=>"Little, Smokey, Cheese, Sausage, 1, Rp132,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>145000.0, :full_parsed_line=>"Gold, Band, Snapper, Fillet, 1, Rp145,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>48000.0, :full_parsed_line=>"Eggs, 16, Rp48,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>46000.0, :full_parsed_line=>"Goat, Kefir, 1, Rp46,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>57500.0, :full_parsed_line=>"Mozzarella, Low, Fat, 1, Rp57,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>122000.0, :full_parsed_line=>"Cheese, Alpine, 1, Rp122,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20000.0, :full_parsed_line=>"Lemon, Certified, Organic, 1, Rp20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16000.0, :full_parsed_line=>"Pineapple, 1, Rp16,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"Cucumber, Local, Organic, 1, Rp15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12500.0, :full_parsed_line=>"Green, Onion, Organic, 1, Rp12,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26000.0, :full_parsed_line=>"Beetroot, Certified, Organic, 1, Rp26,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0, :full_parsed_line=>"Arugula, Wild, Organic, 1, Rp20,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8000.0, :full_parsed_line=>"Sweet, Corn, 1, Rp8,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"Potato, 1, Rp15,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13500.0, :full_parsed_line=>"Baby, Carrot, Organic, 1, Rp13,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33000.0, :full_parsed_line=>"Cabbage, Green, Large, 1, Rp33,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Овощи",
  #          :price=>18000.0,
  #          :full_parsed_line=>"Mix, Plum, Cherry, Tomato, Certified, 1, Rp18,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>91500.0, :full_parsed_line=>"Beef, Cubes, Organic, 1, Rp91,500"},
  #         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14000.0, :full_parsed_line=>"Tomato, 1, Rp14,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>33500.0, :full_parsed_line=>"Tomato, Puree, 1, Rp33,500"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Сладости",
  #          :price=>40000.0,
  #          :full_parsed_line=>"Cookonuts, Dulce, de, Leche, Cookies, 1, Rp40,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Полуфабрикаты/морозилка",
  #          :price=>130000.0,
  #          :full_parsed_line=>"Syrniki, Classic, 1, Rp130,000"},
  #         {:category_name=>"Еда",
  #          :sub_category_name=>"Молочка",
  #          :price=>75000.0,
  #          :full_parsed_line=>"Sourdough, Coconut, Milk, Bread, 1, Rp75,000"},
  #         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>64500.0, :full_parsed_line=>"Beef, Pastrami, 1, Rp64,500"}],
  #        1381000.0,
  #        nil]
  #     )
  #     expect(sum_of_prices).to eq(result[1])
  #   end
  # end
end
