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
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99, :full_parsed_line=>"MASLO, POLSKIE, 200G, M, £, 2.99"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"CZEKOLADA, ORZECHOWA, £, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.0, :full_parsed_line=>"2, @, 1.50, £, 3.00"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>1.35, :full_parsed_line=>"KASZA, JECZMIENNA, SRE, £, 1.35"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>2.95, :full_parsed_line=>"KASZA, GRYCZANA, 400G, £, 2.95"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.55, :full_parsed_line=>"KINDER, MLECZNA, KANAP, £, 0.55"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.78, :full_parsed_line=>"Grocery, £, 3.78"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"Kinder, joy, 20g, £, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.29, :full_parsed_line=>"Grocery, £, 2.29"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>4.04, :full_parsed_line=>"Grocery, £, 4.04"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>2.65, :full_parsed_line=>"1, £, 2.65"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.85, :full_parsed_line=>"£, 2.85"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.55, :full_parsed_line=>"Schogetten, czekolada, 1.55"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.75, :full_parsed_line=>"SEREK, MILANDIA, SMIET, £, 1.75"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>3.35, :full_parsed_line=>"MINI, GOLKA, 160G, £, 3.35"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.2, :full_parsed_line=>"BURACZKI, PAP, CEB, 460, £, 1.20"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.09, :full_parsed_line=>"Butchery, £, 1.09"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>0.6, :full_parsed_line=>"OREO, 30g, £, 0.60"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.29, :full_parsed_line=>"Butchery, £, 1.29"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.5, :full_parsed_line=>"Fruit, &, Veg, £, 5.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.03, :full_parsed_line=>"Fruit, &, Veg, £, 2.03"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.73, :full_parsed_line=>"Fruit, &, Veg, £, 2.73"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.99, :full_parsed_line=>"Grocery, £, 2.99"}],
         29.58,
         nil]
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
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"£, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.6, :full_parsed_line=>"£, 1.60"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"£, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.75, :full_parsed_line=>"£, 1.75"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.93, :full_parsed_line=>"£, 0.93"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.29, :full_parsed_line=>"£, 5.29"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.99, :full_parsed_line=>"Grocery, £, 3.99"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>1.79, :full_parsed_line=>"AMOY, LIGHT, SOY, SAUCE, 1.79"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.85, :full_parsed_line=>"WALKERS, CRISPS, CHEESE, &, 1.85"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.45, :full_parsed_line=>"COOP, MOZZARELLA, 1.45"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.67, :full_parsed_line=>"ELMLEA, DOUBLE, 1.67"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.99, :full_parsed_line=>"LURPAK, BUTTER, SLIGHTLY, S, 2.99"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"COOP, 4PT, WHOLE, FRESH, MIL, -1.95"},
          {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>9.99, :full_parsed_line=>"BEEFSTK, &, LIBERTY, MALBEC, 9.99"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>1.6, :full_parsed_line=>"COOP, 2PT, WHOLE, FRESH, MIL, 1.60"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.25, :full_parsed_line=>"GROCERY, NON, VAT, 1.25"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.85, :full_parsed_line=>"WALKERS, CRISPS, CHEESE, &, 1.85"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.85, :full_parsed_line=>"LIL, -, LETS, NON, APP, REG, *, 1, 1.85"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.89, :full_parsed_line=>"ORAL, B, PRO, EXPERT, PROTEC, 3.89"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.4, :full_parsed_line=>"MCDOUGAL, PLAIN, FLOUR, 1.40"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.99, :full_parsed_line=>"GROCERY, NON, VAT, 1.99"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.55, :full_parsed_line=>"6, Fresh, Free, Range, Eggs, 2.55"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99, :full_parsed_line=>"V, BEEFSTEAK, CLUB, MALBE, 19.99"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.1, :full_parsed_line=>"C, &, M, MINI, PIADINA, 1.10"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0, :full_parsed_line=>"V, FRUIT, SHOOT, BLKCRRNT, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>2.0, :full_parsed_line=>"V, FRT, SHTS, LS, S, /, FRTS, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, LEMON, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, PEACH, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5, :full_parsed_line=>"WR, ESS, WHOLE, MILK, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.9, :full_parsed_line=>"WR, ESS, WHOLE, MILK, 0.90"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.5, :full_parsed_line=>"HELLMANNS, MAYONNAISE, 2.50"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, PEACH, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.25, :full_parsed_line=>"F, /, TRADE, BANANAS, 1.25"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>1.5, :full_parsed_line=>"V, LIPTON, ICE, TEA, LEMON, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.0, :full_parsed_line=>"V, RITTER, SPORT, HONEY, 1.00"},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.5, :full_parsed_line=>"STARBCKS, HOUSE, BLEND, 2.50"},
          {:category_name=>"Для дома", :sub_category_name=>"Ванные принадлежности", :price=>7.33, :full_parsed_line=>"V, VENUS, OLAY, RAZOR, 7.33"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.55, :full_parsed_line=>"WR, ESS, SWEETCORN, 1.55"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.35, :full_parsed_line=>"WR, ESS, LEMON, 0.35"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>0.5, :full_parsed_line=>"SILVER, SPOON, SGR, 0.50"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.3, :full_parsed_line=>"LEERDAMMER, ORIGINAL, 2.30"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>2.3, :full_parsed_line=>"LEERDAMMER, ORIGINAL, 2.30"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.55, :full_parsed_line=>"WR, ESS, SWEETCORN, 1.55"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.66, :full_parsed_line=>"BIO, -, TIFUL, KEFIR, 1.66"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WR, DORG, RADISH, BUNCH, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>2.2, :full_parsed_line=>"WR, 2, HALF, CIABATTAS, 2.20"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WR, DORG, RADISH, BUNCH, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WR, PR, AVOCADOS, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.4, :full_parsed_line=>"WR, CLASSIC, VINE, TOMS, 2.40"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.12, :full_parsed_line=>"WR, ESS, CHKN, LEGS, 1.12"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.55, :full_parsed_line=>"MIXED, PEPPERS, P, /, P, 1.55"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.0, :full_parsed_line=>"WR, WHITE, FARMHOUSE, 1.00"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>3.5, :full_parsed_line=>"WR, ESS, K, /, PRAWNS, ASC, 3.50"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>2.1, :full_parsed_line=>"V, LINDT, CHILLI, CHOC, 2.10"},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>3.95, :full_parsed_line=>"U, /, E, TORCHON, HAM, 3.95"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>1.7, :full_parsed_line=>"JONGENS, TST, WAFFLES, 1.70"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>2.4, :full_parsed_line=>"ROWSE, RUNNY, HONEY, 2.40"},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>2.5, :full_parsed_line=>"STARBCKS, HOUSE, BLEND, 2.50"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.2, :full_parsed_line=>"WR, POME, DEI, MORO, TMS, 2.20"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"WILD, ROCKET2, 801, B, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.55, :full_parsed_line=>"WR, WATERMELON, 2.55"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"GALBANI, MOZZARELLA, 1.95"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>0.05, :full_parsed_line=>"GALBANI, MOZZARELLA, 0.05"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"ASPARAGUS, TIPS, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>1.25, :full_parsed_line=>"V, POM, -, BEAR, ORIGINAL, 1.25"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.5, :full_parsed_line=>"YEO, VALL, DOUB, CREAM, 1.50"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>19.99, :full_parsed_line=>"V, BEEFSTEAK, CLUB, MALBE, 19.99"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"CRAVENDALE, MILK, 2.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"CRAVENDALE, MILK, 2.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"V, WR, ESS, STILL, WATER, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.0, :full_parsed_line=>"V, WR, ESS, CHAM, HAND, WSH, 1.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.25, :full_parsed_line=>"MUTTI, F, /, CHOPPED, TOMS, 1.25"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.9, :full_parsed_line=>"YEO, VALL, DOUB, CREAM, 1.90"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.2, :full_parsed_line=>"WR, ESS, SALTED, BUTTER, 2.20"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.45, :full_parsed_line=>"V, JOHNSON, BATH, WASH, 3.45"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>1.0, :full_parsed_line=>"WR, ESS, FT, BANANAS, 1.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.4, :full_parsed_line=>"LARGE, ORANGES, 2.40"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.65, :full_parsed_line=>"WR, SWEET, PEPPERS, 1.65"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"WR, GRANNY, SMITHS, 2.10"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.39, :full_parsed_line=>"WR, BEST, BRIT, APPLES, 1.39"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.5, :full_parsed_line=>"YEO, VALLEY, NAT, YOG, 2.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.2, :full_parsed_line=>"DORG, CARROTS, 1.20"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.4, :full_parsed_line=>"WR, ESS, CHAR, POTS, 1KG, 1.40"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.0, :full_parsed_line=>"WR, ESS, CONFRNS, PEARS, 1.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.0, :full_parsed_line=>"WR, ESS, CONFRNS, PEARS, 1.00"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>0.7, :full_parsed_line=>"WR, ESS, RADISH, 0.70"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3.5, :full_parsed_line=>"WR1, PR, XL, AVOCADOS, 3.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"WR, GOLDEN, DELICIOUS, R, 2.10"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.15, :full_parsed_line=>"BABYBEL, MINI, ORIGINL, 2.15"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.4, :full_parsed_line=>"2, @, £, 0.70, 1.40"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.05, :full_parsed_line=>"3, @, £, 0.35, TL, 1.05"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"WR, DORG, PONTD, CABBGE, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"WR, CRANBERRIES, 2.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.25, :full_parsed_line=>"WR, SALMON, FILLETS, 5.25"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>6.53, :full_parsed_line=>"WR, NO1, MSC, COD, LOIN, 6.53"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.5, :full_parsed_line=>"WR, ESS, CHICKN, LIVERS, 1.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.2, :full_parsed_line=>"WR, ESS, STRAWBERRIES, 2.20"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.3, :full_parsed_line=>"NO.1, CHICKEN, DRUM, 3.30"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.5, :full_parsed_line=>"CHERRY, VINE, TOMS, P, /, P, 2.50"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"GALBANI, MOZZARELLA, 1.95"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>1.95, :full_parsed_line=>"GALBANI, MOZZARELLA, 1.95"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.29, :full_parsed_line=>"WR, DRY, CURED, B, /, BACON, 3.29"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.35, :full_parsed_line=>"WR, SMOKED, SALAMI, 2.35"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.35, :full_parsed_line=>"WR, SMOKED, SALAMI, 2.35"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.09, :full_parsed_line=>"WR, HONEY, ROAST, HAM, 3.09"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.0, :full_parsed_line=>"WR, HONEY, ROAST, HAM, 3.00"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"ASPARAGUS, TIPS, 2.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.5, :full_parsed_line=>"CHERRY, VINE, TOMS, P, /, P, 2.50"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>2.0, :full_parsed_line=>"ASPARAGUS, TIPS, 2.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.95, :full_parsed_line=>"V, WKRS, LESS, SLT, C, &, 0, 1.95"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>5.6, :full_parsed_line=>"4, @, £, 1.40, 5.60"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.0, :full_parsed_line=>"V, NESTLE, SMARTIES, PENG, 2.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.95, :full_parsed_line=>"WR, FR, MIXED, EGGS, 2.95"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.45, :full_parsed_line=>"JACKSON, WHIE, BLOOMER, 1.45"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>3.5, :full_parsed_line=>"V, RITTER, SPORT, MINI, 3.50"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.8, :full_parsed_line=>"V, VICKS, TA, LOZENGE, 0.80"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.8, :full_parsed_line=>"V, HALLS, ORIGINAL, 0.80"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>3.0, :full_parsed_line=>"V, BATHTIME, CRAYONS, 3.00"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.35, :full_parsed_line=>"V, CREEPY, PUMPKNS, CHOCS, 1.35"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>1.6, :full_parsed_line=>"WR, WILD, ROCKET, 1.60"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.65, :full_parsed_line=>"WR, CAVOLO, NERO, 200G, 1.65"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.76, :full_parsed_line=>"00069366, Loose, Bananas, £, 0.76"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"29197538, HAPPY, LOLLIES, £, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>1.5, :full_parsed_line=>"29197538, HAPPY, LOLLIES, £, 1.50"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>1.3, :full_parsed_line=>"29304813, OG, WINGS, 750G, £, 1.30"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>4.0, :full_parsed_line=>"00083249, TRKY, S, /, LESS, FIL, £, 4.00"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.5, :full_parsed_line=>"00082723, NECTARINES, £, 2.50"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.75, :full_parsed_line=>"0015981, CHERRY, REC, SML, £, 2.75"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0, :full_parsed_line=>"00805100, EASYPEEL, FAMILY, £, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.0, :full_parsed_line=>"29095759, PR, MANGO, Y2, £, 2.00"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.65, :full_parsed_line=>"0080586, !, ORANGE, LOOSE, £, 0.65"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>0.65, :full_parsed_line=>"0080586, !, ORANGE, LOOSE, £, 0.65"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25, :full_parsed_line=>"00983006, POMEGRANATE, £, 2.25"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>2.25, :full_parsed_line=>"00983006, POMEGRANATE, £, 2.25"}],
         24.11,
         nil]
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
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"BREAD, £, 2.10"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"ENGLISH, BUTTER, £, 2.10"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.1, :full_parsed_line=>"ENGLISH, BUTTER, £, 2.10"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>4.25, :full_parsed_line=>"SMOKED, SALMO, £, 4.25"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.45, :full_parsed_line=>"THICK, DBL, CRM, £, 1.45"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.3, :full_parsed_line=>"CHICKEN, FILLET, £, 2.30"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>2.95, :full_parsed_line=>"PLATTER, £, 2.95"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>1.95, :full_parsed_line=>"WALKERS, CRISPS, *, £, 1.95"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>0.3, :full_parsed_line=>"BAG, FOR, LIFE, *, £, 0.30"}],
         19.5,
         nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>41700.0,
          :full_parsed_line=>
           "PEP, TO, MARKET, CANGGU, 11., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C10000017446, Counter, :, C1, 01, -, Nov, -, 2022, 18:08:47, DIAH, PRAMESTI, 101024011712, [, NANAS, HONI, MEDIUM, ], 41,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>6900.0,
          :full_parsed_line=>"101010000628, [, NU, GREEN, TEA, ORIGINAL, 450ML, 6.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>32900.0,
          :full_parsed_line=>"101012035544, (, MILK, LIFE, PURE, PLAIN, 1000ML, 32,900"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4500.0, :full_parsed_line=>"10102301599TKYURI, ], 4,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>23000.0,
          :full_parsed_line=>"101013029632, [, MAMAS, GAMMON, HAM, 100GR, ], 23,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>18500.0,
          :full_parsed_line=>"101013029629, [, MAMAS, PORK, BREAKFAST, 100GR, ], 18.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>11500.0,
          :full_parsed_line=>"101013038348, (, KANZLER, SINGLES, ORIGINAL, €, 5, GR, ], 11,500"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22500.0, :full_parsed_line=>"101066012151LJONUT, SPRINKLE, ], 22,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>49522.0,
          :full_parsed_line=>"101024011708, (, MANGGA, GDONG, GNC, KG, ], 49,522"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>9699.0,
          :full_parsed_line=>"101024011707, (, DRAGON, FRUIT, MERAH, ], 9,699"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>33509.0,
          :full_parsed_line=>"101016010907, [, CHIC, BREAST, BONELESS, KG, ], 33.509"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>92500.0,
          :full_parsed_line=>"101003044413, [, LAY, CHIPS, SC, ON, 175GR, ], 92,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>45348.0,
          :full_parsed_line=>"101021029986, [, MAMAS, GAMMON, HAM, KG, \", 45.348"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>38570.0, :full_parsed_line=>"101022011267, [, MARLIN, STEAK, ], 38,570"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>57000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, BOX, 6, *, 45, 57.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47400.0,
          :full_parsed_line=>"101010034003LUIMFS, CLASIC, SOUR, CHERY, NEC, 1LT, ], 47,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18400.0,
          :full_parsed_line=>"101023011394, [, PAPRIKA, HIJ, :, U, HYDKUJ, 18.400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>65000.0,
          :full_parsed_line=>"101066048097, [, BAME, MINI, OREO, CAKES, ], 65.000"}],
        618448.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>61424.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4020000086312, Counter, :, C2, 09, -, Nov, -, 2022, 09:55:09, PUSPITA, DEHI, 101024011692, SEMANGKA, MERAH, NB, KG, ], 61.424"},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0, :full_parsed_line=>"101051022866, [, PEPITO, BAG, LI, 12.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56500.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 56.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>33000.0,
          :full_parsed_line=>"101012041159, (, KIN, FRESHMILK, REDUCE, FAT, 96, 33.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>9900.0,
          :full_parsed_line=>"101012009140, (, GREENFIELDS, YOG, DRINK, LYCHE, E, 250M.1, 9.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>9300.0,
          :full_parsed_line=>"1010120090471BIOKUL, YOG, DR, APRICT, 150ML, ], 9.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>21200.0,
          :full_parsed_line=>"101012009159, (, KIN, BULGARIAN, YOG, LCYHEE, 200M, ., ), 21,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>9900.0,
          :full_parsed_line=>"101012009137, (, GREENFIELDS, YOG, DRNK, BB, 250, M., ], 9.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>100500.0,
          :full_parsed_line=>"101002034779, [, LINDT, AMANDES, FLEUR, DE, 150, ], 100,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>9300.0,
          :full_parsed_line=>"101012009073, (, BIOKUL, YOG, DR, ORANGE, 150ML, ), 9.300"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0, :full_parsed_line=>"101024011712INANAS, HONI, MEDIUM, ], 41.700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>12500.0,
          :full_parsed_line=>"101012046726, (, DELICYO, YOG, STRAH, &, BANANA, 200ML, ), 12.500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>37000.0,
          :full_parsed_line=>"101033032574, (, CLEAR, SHP, 3IN1, ACTIVE, CLN16, 37.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>12500.0,
          :full_parsed_line=>"101012046728, (, DEL, ICYO, YOG, BLUEBERRY, 200ML, 12.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>11000.0,
          :full_parsed_line=>"101012031563, (, CIMORY, SQUEEZE, BLUEBERRY, 12, 11.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>40000.0,
          :full_parsed_line=>"1010070287881SHUKRIYA, BASMATI, RICE, IKG, ], 40.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>84500.0,
          :full_parsed_line=>"101011040728, (, BINTANG, CRYSTAL, CAN, 320X4, M, LIPCK, ], 84.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>33495.0,
          :full_parsed_line=>"1010240116831SUNPRIDE, PISANG, CAVENDISH, KI, 33.495"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>137500.0,
          :full_parsed_line=>"101003037583, (, KANGAROO, PISTACHIOS, 250GRI, 137,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>15300.0,
          :full_parsed_line=>"101044020918, (, PASEO, SP, ULTRS, 100S, ), 15.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>31812.0,
          :full_parsed_line=>"101023011627, [, BEEF, TOMATO, RED, KG, ), 31.812"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15360.0, :full_parsed_line=>"1010240117091ALPUKAT, KG, ], 15.360"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>85000.0,
          :full_parsed_line=>"101024032325, (, GRAPE, GREEN, MUSCAT, 500, GRI, 85.000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>28500.0,
          :full_parsed_line=>"1010030436991YOUTH, KITCHEN, KAPK, TEMPE, 10, 28.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>24000.0,
          :full_parsed_line=>"101012009324, TELUR, AYAM, NGRI, 10S, ], 24.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>42000.0,
          :full_parsed_line=>"101002005202, (, KIT, KAT, CHUNKY, 38GR, ], 42.000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>42400.0,
          :full_parsed_line=>"101055023820, (, PANASONIC, ALK, MAHI, 42,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>12500.0,
          :full_parsed_line=>"101012046727, (, DELICYO, YOG, POMEGRANATE, 200, 12.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>28000.0,
          :full_parsed_line=>"1010660122231WHOLE, WHEAT, TOASTI, 28.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>78210.0,
          :full_parsed_line=>"101021011195EAR, DOOKED, HAM, KG, ], 78.210"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>6800.0,
          :full_parsed_line=>"101033014426IMITU, BABY, WIPES, F, &, C, PINK, CH, ERRY, 245, ], 6.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>18500.0,
          :full_parsed_line=>"101015009989, (, MAGNUM, CLASSIC, 90MI, 18.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>71800.0,
          :full_parsed_line=>"101013041053, TRIPLE, THREE, STREAKY, BACON, 100GR, ], 71.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>79500.0,
          :full_parsed_line=>"1010130447821SMITHFIELD, MARPLE, HAM, 100GR, 79.500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>12000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, ., Item, Sales, Bill, No, :, 4C20000082147, Counter, :, C2, 17, -, Nov, -, 2022, 08:57:09, SRI, ARSENI, 101051022866, [, PEPITO, BAG, L, ], 12,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10650.0, :full_parsed_line=>"101023011599, (, KYURI, ], 10,650"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>114000.0,
          :full_parsed_line=>"101015009985, (, MAGNUM, MIX, 6X45ML, ], 114.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>36736.0,
          :full_parsed_line=>"101023011627, [, BEEF, TOMATO, RED, KG, ], 36.736"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>57000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, 6X45ML, ], 57,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>24500.0,
          :full_parsed_line=>"101044020895, [, PASEO, SINGLE, 2005, ], 24,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>90500.0,
          :full_parsed_line=>"101003004721, [, MR.P, DRY, PISCHIO, 130, ], 90,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>10600.0,
          :full_parsed_line=>"101003041480, [, PRINGLES, CHEESY, CHEESE, 42GR, 10.600"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24800.0, :full_parsed_line=>"101023011588, [, BROKOLI, LOKAL, ], 24,800"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19176.0, :full_parsed_line=>"101023011534, [, KENTANG, BESAR, ], 19.176"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>60000.0,
          :full_parsed_line=>"101034017833, [, J, &, J, COTT, H, &, B, BB, 500ML, ., ], 60,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>116730.0,
          :full_parsed_line=>"P, 101011000337, (, BALI, HAI, PREMIUM, CAN, 6X320M, 129,700 - 12.970"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>44000.0,
          :full_parsed_line=>"101003027709, (, DB, GLUTEN, FR, GRISSINI, 125GR, 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>11000.0,
          :full_parsed_line=>"101003032886, [, OREO, RED, VELVET, 133GR, ], 11.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>10000.0,
          :full_parsed_line=>"101003008002, [, OREO, FESTIVE, 137, ], 10.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>192900.0,
          :full_parsed_line=>"101002038665, [, M, &, M, MILK, CHOCOLATE, MINIS, 10, OZ, ), 192,900"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>20500.0, :full_parsed_line=>"101012009315, TELUR, MERAH, 10S, ], 20.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>132000.0,
          :full_parsed_line=>"101002005779, [, LINDT, MILK, HZNUT100, ], 132,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005410, [, LINDT, WHOLEALMON100, ], 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32500.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 32,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>52500.0,
          :full_parsed_line=>"101013029640, [, MAMAS, BACK, BACON, SLICED, 250, GR, ], 52,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>78500.0,
          :full_parsed_line=>"101002008185, [, LINDT, EXCCREAMY100, ], 78,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>21000.0,
          :full_parsed_line=>"101013026948, [, MAMAS, ROAST, BLACK, PEPPER, 1, OOGR, ], 21.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>71800.0,
          :full_parsed_line=>"101013041053, [, TRIPLE, THREE, STREAKY, BACON, 100GR, ], 71.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>79500.0,
          :full_parsed_line=>"101013044782, [, SMITHFIELD, MARPLE, HAM, 100GR, 79.500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>15300.0,
          :full_parsed_line=>"101044020918, [, PASEO, SP, ULTRS, 100S, ], 15,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>18000.0,
          :full_parsed_line=>"101002008133, [, DELFI, CHACHA, PEANUT, 40GR, ), 18,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>54900.0,
          :full_parsed_line=>"P, 101012009491, (, LAUGHING, CON, CHEEZ, DIPPERS, 140GR, ], 59.900 - 5,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>45900.0,
          :full_parsed_line=>"P, 101033014624, [, COLGATE, TP, SPARK, 100GR, ], 50,100 - 4,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>22900.0,
          :full_parsed_line=>"101006002416, (, KIKKO, KCP, ASIN, JP150, ], 22,900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>8000.0,
          :full_parsed_line=>"101044020839, (, POLYTEX, SPONGE, ANGRS, ], 8,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C10000020364, Counter, :, C1, 18, -, Nov, -, 2022, 08:45:13, NI, KADEK, DEVI, P, 101010001057, [, COCA, COLA, PET, 1500ML, ], 15,900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>22000.0,
          :full_parsed_line=>"101043020202, [, PROCLIN, PN, REF, 400ML, ], 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>156300.0,
          :full_parsed_line=>"101005000139, [, NESCAFE, GOLD, B, 100GR, ], 156.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>91000.0,
          :full_parsed_line=>"101003004721, [, MR.P, DRY, PISCHIO, 130, ], 91,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>132000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 132,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>"101011008649, [, HW, HATTEN, AGA, WHITE, 2LT, ], 319,000"},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0, :full_parsed_line=>"101051022861, [, PEPITO, BAG, MI, 9,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>64000.0,
          :full_parsed_line=>"101002005378, [, KINDER, BUENO, CHOCO, T, -, 21, 64.000"}],
        809200.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>15904.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C30000043001, Counter, :, C3, 18, -, Nov, -, 2022, 15:30:12, YUMAS, MAHADEWI, 101023011608, [, JAGUNG, MANIS, KULIT, ], 15,904"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>115000.0,
          :full_parsed_line=>"101003005020, [, LAYS, SOUR, CRM, &, ONION, ], 115,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>64000.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 64,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>36330.0,
          :full_parsed_line=>"101016010905, [, CHICKEN, LEG, /, PAHA, KG, ], 36,330"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>54900.0,
          :full_parsed_line=>"P, 101012009491, [, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900 - 5,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>40900.0,
          :full_parsed_line=>"101043020201, [, VANISH, WHT, BTL, 500ML, ], 40,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>45000.0,
          :full_parsed_line=>"101066012151, [, DONUT, SPRINKLE, ], 45,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>50300.0,
          :full_parsed_line=>"101006000185, [, BARILLA, FARFALLE, 500, GR, ], 50,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>54900.0,
          :full_parsed_line=>"P, 101006052516, [, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60.500 - 5,600"},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>9000.0, :full_parsed_line=>"101051022861, [, PEPITO, BAG, M, ], 9,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>22770.0,
          :full_parsed_line=>"101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, G, ], 22,770"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55383.0, :full_parsed_line=>"101023011534, [, KENTANG, BESAR, ], 55,383"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10560.0, :full_parsed_line=>"101023011531, [, WORTEL, MEDAN, ], 10,560"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>116730.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C10000012650, Counter, :, C1, 22, -, Nov, -, 2022, 08:58:41, KSR, IVANA, LISDI, P, 101011000337, [, BALI, HAI, PREMIUM, CAN, L, ], 129,700 - 12,970"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41514.0, :full_parsed_line=>"101023011534, [, KENTANG, BESAR, ], 41,514"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ], 15,900"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12012.0, :full_parsed_line=>"101023011531, [, WORTEL, MEDANI, 12,012"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>64000.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ], 64,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011643, [, TOMAT, CHERRY, HDR, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>198000.0,
          :full_parsed_line=>"101002000021, (, LINDT, MRAISIN, NUT100, ], 198,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>54900.0,
          :full_parsed_line=>"P, 101012009491, [, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900 - 5,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>34675.0,
          :full_parsed_line=>"101016010916, [, MINCED, CHICKEN, KG, ], 34.675"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>40565.0,
          :full_parsed_line=>"101016010907, [, CHIC, BREAST, BONELESS, KG, ], 40,565"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>27132.0,
          :full_parsed_line=>"101016010907, [, CHIC, BREAST, BONELESS, KG, ], 27,132"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17325.0, :full_parsed_line=>"101023011374, [, KALE, LOKAL, ], 17,325"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>6000.0,
          :full_parsed_line=>"101023011367, IDN, BAWANG, BESAR, PCS, ], 6,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>80200.0,
          :full_parsed_line=>"101013044793, TRIPLE, THREE, BLACK, FORES, HA, M, 100GR, ], 80.200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>18500.0,
          :full_parsed_line=>"101013029629, [, MAMAS, PORK, BREAKFAST, 100GR, ], 18,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>23000.0,
          :full_parsed_line=>"101013029632, [, MAMAS, GAMMON, HAM, 100GR, ], 23.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>78000.0,
          :full_parsed_line=>"101013052013, [, GRAVAD, LAX, CLASSIC, 100GR, ], 78.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>29000.0,
          :full_parsed_line=>"101002008204, [, KINDER, JOY, BOY, 20GR, ), 29,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8500.0, :full_parsed_line=>"101023052044, [, EO, HERB, DILLI, 8,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>62500.0,
          :full_parsed_line=>"101006030015, [, THINS, SOUR, CREAM, &, CHIVES, 1, 75gr, ), 62,500"}],
        948553.0,
        nil]
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
        [[{:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>24500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C30000087711, Counter, :, C3, 23, -, Nov, -, 2022, 10:33:29, MAYLDA, ANDRIANI, 101044020895, [, PASEO, SINGLE, 200S, ], 24,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, ], 56,500 - 8,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>50000.0,
          :full_parsed_line=>"101006006392, [, BARILLA, MACCHERONI, 500, GR, ], 50,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>"101002048214, [, SCHOGETTEN, ALPINE, MILK, HAZE, LNUT, 100GR, ], 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>"101002052949, [, SCHOGETTEN, ALPINE, MILK, CHOC, 100G, ], 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005779, [, LINDT, MILK, HZNUT100, ], 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>40150.0,
          :full_parsed_line=>"101005006855, [, NESCAFE, 3IN1, ORG, 30S, ], 40,150"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>156300.0,
          :full_parsed_line=>"101005000139, [, NESCAFE, GOLD, B, 100GR, ], 156.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011643, [, TOMAT, CHERRY, HDR, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>13410.0,
          :full_parsed_line=>"P, 101004051678, [, ANDROS, STRAWBERRY, PINK, GUAV, A, FMU, 90GR, ], 14,900 - 1.490"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44700.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, N05, 500, G, R, ], 44,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>13410.0,
          :full_parsed_line=>"P, 101004051675, [, ANDROS, SOURSOP, &, APPLE, FMU, 90, 14.900 - 1,490"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19328.0, :full_parsed_line=>"101023011599, [, KYURI, ], 19,328"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>9000.0,
          :full_parsed_line=>"101023011371, [, DN, BAWANG, CHUNG, PCS, ], 9,000"}],
        625698.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>41700.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C20000084014, Counter, :, C2, 24, -, Nov, -, 2022, 09:36:06, SRI, ARSENI, 101024011712, [, NANAS, HONI, MEDIUM, ], 41.700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>52371.0,
          :full_parsed_line=>"101024011692, [, SEMANGKA, MERAH, NB, KG, ], 52,371"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>51388.0,
          :full_parsed_line=>"101024011733, [, APEL, RED, WASHINGTON, ), 51,388"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22140.0, :full_parsed_line=>"101023011599, [, KYURI, ], 22,140"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21560.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 21,560"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>25740.0,
          :full_parsed_line=>"101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, G, ], 25,740"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ), 56,500 - 8,600"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27224.0, :full_parsed_line=>"101023011657, [, PARSLEY, ], 27,224"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>34500.0,
          :full_parsed_line=>"101006002394, (, LKK, SOY, SAUCE, 500ML, ], 34,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>95019.0,
          :full_parsed_line=>"101022011269, (, MAHI, -, MAHI, FILLET, ], 95,019"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69900.0,
          :full_parsed_line=>"P, 101005003831, [, NUTELLA, C, SPREAD, 350, ], 80,000 - 10,100"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13120.0, :full_parsed_line=>"101023011656, (, DAUN, DIIL, ], 13.120"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>26630.0,
          :full_parsed_line=>"101016010910, [, CHICKEN, BOTTOM, LEG, ], 26,630"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>54900.0,
          :full_parsed_line=>"P, 101006052516, [, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60,500 - 5,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>114000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, 6X45ML, ], 114,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29715.0, :full_parsed_line=>"101016010903, [, CHICKEN, WING, KG, ], 29,715"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>36895.0,
          :full_parsed_line=>"101023011607, [, TOMAT, GONDOL, MERAH, KG, ], 36,895"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>24000.0,
          :full_parsed_line=>"101012009324, (, TELUR, AYAM, NGRI, 10S, ], 24.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>47000.0,
          :full_parsed_line=>"101013009711, [, BERNARDI, BEEF, SSG, 6S, ], 47,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>25830.0,
          :full_parsed_line=>"101016010905, [, CHICKEN, LEG, /, PAHA, KG, ], 25,830"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>50300.0,
          :full_parsed_line=>"101006002127, [, FRENCH, MUSTARD, SQUEZ, ], 50.300"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>40500.0,
          :full_parsed_line=>"101033051925, [, HETKINS, CLEAN, N, FLUSH, 72S, ], 40.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>62600.0,
          :full_parsed_line=>"101006030015, THINS, SOUR, CREAM, &, CHIVES, 1, 75gr, ), 62.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>330000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 330,000"},
         {:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>112500.0,
          :full_parsed_line=>"101034017881, (, SWEETY, PANT, R.GL, XL, ], 112,500"}],
        1457432.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>330000.0,
          :full_parsed_line=>
           "POPULAR, EXPRESS, BERAWA, Berawa, ,, Tibubeneng, -, Badung, Jl, ., Pantai, PT, Sentral, Retailindo, Dewata, Item, Sales, Counter, :, C1, Bill, No, :, 4C10000018824, 15:21:13, MOD, 1, BRAWA, 26, -, Nov, -, 2022, [, LINDT, MRAISIN, NUT100, ], 330,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>64000.0,
          :full_parsed_line=>"[, KINDER, BUENO, CHOCO, T, -, 2, ], 64,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Полуфабрикаты/морозилка",
          :price=>60000.0,
          :full_parsed_line=>"[, GANESHA, SORA, MOZZARELA, PIZZ, A, 200GR, ], 60,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>75600.0,
          :full_parsed_line=>"101012009494, (, GREENFIELDS, RICOTTA, 250GR, ), 75,600"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>19289.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C30000045239, Counter, :, C3, 28, -, Nov, -, 2022, 11:22:15, ENI, PUSPA, YANTI, P, 101023011608, [, JAGUNG, MANIS, KULIT, ], 20,304 - 1,015"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>5700.0,
          :full_parsed_line=>"P, 101023011367, [, DN, BAWANG, BESAR, PCS, ], 6,000 - 300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>89974.0,
          :full_parsed_line=>"P, 101023011627, [, BEEF, TOMATO, RED, KG, ], 94,710 - 4,736"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12515.0, :full_parsed_line=>"P, 101023011599, [, KYURI, ], 13,174 - 659"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>7994.0,
          :full_parsed_line=>"P, 101023011374, [, KALE, LOKAL, ], 8,415 - 421"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>53816.0,
          :full_parsed_line=>"P, 101023011600, [, ZUCHINI, HIJAU, KG, ], 56,648 - 2,832"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>64000.0,
          :full_parsed_line=>"101012008983, (, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 64,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>54900.0,
          :full_parsed_line=>"P, 101012009491, [, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900 - 5,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>47700.0,
          :full_parsed_line=>"101012009326, [, TELUR, RENDAH, KOLESTEROL, 10S, 47,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002008264, [, ZAINI, TOY, S, T, EGG, 601, 69.700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002008202, [, ZAINI, FROZEN, 6OGR, ], 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>95100.0,
          :full_parsed_line=>"101006051073, [, KENKOH, MAYONAISE, IMPORT, 500, ML, ], 95,100"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>24500.0,
          :full_parsed_line=>"101044020895, [, PASEO, SINGLE, 200S, ], 24.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 66.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7700.0,
          :full_parsed_line=>"101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ], 7,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>62600.0,
          :full_parsed_line=>"101006030014, [, THINS, LIGHT, &, TANGY, 175GR, ], 62,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>32000.0,
          :full_parsed_line=>"101002008316, [, HALLS, EXTRA, STRONG, 34GR, ], 32,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>12000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C20000092685, Counter, :, C2, 01, -, Dec, -, 2022, 15:45:30, YUMAS, MAHADEWI, 101051022866, [, PEPITO, BAG, LI, 12,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>128000.0,
          :full_parsed_line=>"101012009576, (, BERRI, JUICE, MANGO, 2LT, ], 128,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>169000.0,
          :full_parsed_line=>"P, 101011040728, (, BINTANG, CRYSTAL, CAN, 320X4, M, LTPCK, ], 169,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>"101011000539, [, HH, HATTEN, BALI, ROSE, 2LT, ], 319,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>40000.0,
          :full_parsed_line=>"101007028788, [, SHUKRIYA, BASMATI, RICE, 1KG, ], 40,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>12900.0,
          :full_parsed_line=>"101044043277, [, MONTISS, TISSU, REFILL, 250S, ], 12,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>99400.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 99,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006002889, [, HEINZ, WHITE, VNG, 16OZ, !, 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>7900.0,
          :full_parsed_line=>"101005004071, [, G, DAY, CHOCOCINO, C, 5S, ], 7.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>50700.0,
          :full_parsed_line=>"101023011553, (, BF, RED, ONION, PACKI, 50,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>15400.0,
          :full_parsed_line=>"101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ], 15,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>13500.0,
          :full_parsed_line=>"101007001773, [, RB, GULA, PUTIH, 1KG, ], 13,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>14700.0,
          :full_parsed_line=>"101043048819, [, SUNLIGHT, KOREAN, STRAW, PCH, 1, 2X560ML, ], 14,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>7900.0,
          :full_parsed_line=>"101005006852IG, DAY, ORIGINAL, C, 551, 7,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>7900.0,
          :full_parsed_line=>"101005006848, [, G, DAY, MOCA, C, MIX, 5S1, 7,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>57000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, 6X45MLI, 57,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>9500.0,
          :full_parsed_line=>"101003032887, [, OREO, CHOCO, VANI, WAFER, 40.4G, R, ], 9,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>22600.0,
          :full_parsed_line=>"101033016537, [, DETTOL, HW, ENERGI, REFFML, ], 22,600"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5454.0, :full_parsed_line=>"101023011531, [, WORTEL, MEDAN, ], 5,454"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>138000.0,
          :full_parsed_line=>"101006030015, THINS, SOUR, CREAM, &, CHIVES, 1, 75gr, ), 138,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>41500.0,
          :full_parsed_line=>"101004007271, (, PEACHY, AP, M, &, BNN, 110, ], 41.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>29800.0,
          :full_parsed_line=>"101004051676, (, ANDROS, MANGO, BANANA, PASION, FMU, 90GR1, 29,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>40000.0,
          :full_parsed_line=>"101005053405, [, AUSTRALIA, HARVEST, INSTANT, O, ATS, 500G, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>110300.0,
          :full_parsed_line=>"101003005018, (, CHEETO, C.PUFFS, JMB, ], 110.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>27075.0,
          :full_parsed_line=>"101021029985, (, MAMAS, DELI, HAM, KG, ], 27,075"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32500.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 32,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>44809.0,
          :full_parsed_line=>"101021011108, [, DIAMOND, CHEDDAR, KG, ], 44,809"}],
        1496838.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>21000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, Sentral, Retailindo, Dewata, Item, Sales, C1, Counter, :, Bill, No, :, 4C10000018612, YULINDA, DEWI, 05, -, Dec, -, 2022, 15:41:23, [, PPUF, SUPERSHROOMS, ROASTED, C, ORN, 25GR, ], 21.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>57000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, 6X45ML, ), 57,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>621500.0,
          :full_parsed_line=>"101011051118, [, BI, PLAGA, DOLCE, SHEET, CASK, 3, 621,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18260.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 18,260"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>9000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C20000105026, Counter, :, C2, 08, -, Dec, -, 2022, 10:35:15, KUMARA, DEWI, 101051022861, [, PEPITO, BAG, M, ], 9,000"},
         {:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>48000.0,
          :full_parsed_line=>"101034017891, [, MERRIES, P.GOOD, S, LI, 48,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>69000.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 69,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>60500.0,
          :full_parsed_line=>"101006052516, [, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60,500"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3800.0, :full_parsed_line=>"101009000754, [, AQUA, BTL, 600ML, ], 3,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>64000.0,
          :full_parsed_line=>"101002005378, [, KINDER, BUENO, CHOCO, T, -, 2, ], 64,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>70000.0,
          :full_parsed_line=>"101002034786, [, VALOR, HELLO, KITTY, TRIO, EGGS, 60GR, ], 70,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>70000.0,
          :full_parsed_line=>"101002000028, [, ZAINI, MICKEY, 60G, ], 70,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>198000.0,
          :full_parsed_line=>"101002005410, [, LINDT, WHOLEALMON100, ], 198,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>15400.0,
          :full_parsed_line=>"101002000018, IDF, CHACHA, MINIS, HATS, 30GR, ], 15,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>25000.0,
          :full_parsed_line=>"101002008155, [, ZAINI, CARS, 18GR, ], 25,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>57318.0,
          :full_parsed_line=>"101023011627, [, BEEF, TOMATO, RED, KG, ], 57,318"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>94387.0,
          :full_parsed_line=>"101024011675, [, MANGGA, BUDI, RAJA, KG, ], 94,387"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>29133.0, :full_parsed_line=>"101024011739, [, PEAR, PACKAM, KGJ, 29,133"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>55500.0,
          :full_parsed_line=>"101015009992, [, MAGNUM, ALMOND, 90ML, ], 55,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>74000.0,
          :full_parsed_line=>"101015009989, [, MAGNUM, CLASSIC, 90ML, ], 74,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>12000.0,
          :full_parsed_line=>"101002005202, [, KIT, KAT, CHUNKY, 38GR, ], 12,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>12000.0,
          :full_parsed_line=>"101002005202, [, KIT, KAT, CHUNKY, 38GR, ], 12,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>14500.0,
          :full_parsed_line=>"P, 101002008205, (, KINDER, JOYS, GIRL, 201, 14.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>149100.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 149.100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>14900.0,
          :full_parsed_line=>"101004051678, [, ANDROS, STRAWBERRY, PINK, GUAV, A, FMU, 90GR, ], 14,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>"101011000539, [, HW, HATTEN, BALI, ROSE, 2LT, ], 319,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>7500.0, :full_parsed_line=>"101066012157, [, DONUT, TRIPPLE, ], 7,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>129700.0,
          :full_parsed_line=>"101013027244, [, BHO, LITTLE, NUERNBRGR, 250GR, ], 129,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>14900.0,
          :full_parsed_line=>"101004051675, [, ANDROS, SOURSOP, &, APPLE, FMU, 90, GR, ], 14.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>29299.0,
          :full_parsed_line=>"P, 101023011627, [, BEEF, TOMATO, RED, KG, ], 32,554 - 3,255"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>10800.0,
          :full_parsed_line=>"P, 101023011370, [, DAUN, BAWANG, FRE, PCS, ], 12,000 - 1,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>9000.0,
          :full_parsed_line=>"101051022861, [, PEPITO, BAG, M, ], 9,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>60500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C30000093956, Counter, :, C3, 13, -, Dec, -, 2022, 15:51:19, NI, PUTU, SURIAST, 101006052516, [, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>99400.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, 99,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>483000.0,
          :full_parsed_line=>"101011044499, [, BI, PLAGA, WHITE, BLEND, CASK, 3, L, ], 483,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>15300.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C30000048928, Counter, :, C3, 15, -, Dec, -, 2022, 09:31:59, PUSPITA, DEWI, 101044020918, (, PASEO, SP, ULTRS, 10051, 15,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>66900.0,
          :full_parsed_line=>"101007001992, [, FB, EXT, VIRGIN, 250M.1, 66.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>45236.0,
          :full_parsed_line=>"P, 101023011627, (, BEEF, TOMATO, RED, KG, ), 50,262 - 5,026"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>60003.0,
          :full_parsed_line=>"P, 101024040681, [, PLUM, RED, AUST, KG, ], 66.670 - 6,667"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>45180.0,
          :full_parsed_line=>"P, 101024011793, (, JERUK, HON, MURCOT, PREJ, 50.200 - 5,020"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>56900.0,
          :full_parsed_line=>"101007031129, [, MCKENZIES, YELLOW, LENTILS375, 56,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>11365.0,
          :full_parsed_line=>"P, 101023011531, [, WORTEL, MEDAN, ], 12.628 - 1.263"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>24500.0,
          :full_parsed_line=>"101044020895, [, PASEO, SINGLE, 20051, 24.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>128000.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 128,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002005480, [, ZAINI, MINIE, T, EGG, 601, 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>83500.0,
          :full_parsed_line=>"101014009816, (, ROSITAS, BORRITO, TRTL, 460GRI, 83,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052322, (, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, 56,500, 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002000028, (, ZAINI, MICKEY, 60G1, 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"1010020082641ZAINI, TOY, S, T, EGG, 601, 69.700"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>48100.0,
          :full_parsed_line=>"101055023809, (, ENERGIZER, E92, AAA, -, 4, MAX, ], 48,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>24000.0,
          :full_parsed_line=>"1010020354721FINI, JELLY, BERRIES, 100GR, ], 24,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>99400.0,
          :full_parsed_line=>"101012009283, (, YUMMY, RICOTTA, 250GR, ], 99,400"},
         {:category_name=>"Марк", :sub_category_name=>"Игрушки", :price=>34900.0, :full_parsed_line=>"101048028893, [, YASUKA, 349001, 34.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>32076.0,
          :full_parsed_line=>"P, 1010240280741ALPUKAT, MENTEGA, SUPER, 500GR, UP, KG, ], 35.640 - 3.564"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>36526.0,
          :full_parsed_line=>"P, 101023011396, [, PAPRIKA, KUNING, HYDRO, ], 40,584 - 4.058"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>9900.0,
          :full_parsed_line=>"1010090010431BALIAN, MINERAL, WATER, PET, 50, OML, ], 9,900, 9,900"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4102.0, :full_parsed_line=>"P, 101023011591, (, BUNCIS, ], 4.558 - 456"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>47200.0,
          :full_parsed_line=>"101006047939, [, PAPA, RICE, VERMICELLI, 400GR, ], 47.200"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>16200.0,
          :full_parsed_line=>"101055044354, (, ABC, BATERAI, BIRU, CZ, R6, ], 16.200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16434.0,
          :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 18.260 - 1.826"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12420.0, :full_parsed_line=>"P, 101023011599, (, KYURI, ], 13.800 - 1.380"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>44005.0,
          :full_parsed_line=>"P, 101024011806, [, PEAR, FORELLE, KG, ], 48.895 - 4.890"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>20146.0,
          :full_parsed_line=>"P, 101024011683, (, SUNPRIDE, PISANG, CAVENDISH, K, 22.385 - 2.239"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>45000.0,
          :full_parsed_line=>"101012009312, TELUR, OMEGA, 3, 10S, AA, ], 45,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>47000.0,
          :full_parsed_line=>"101006006306, [, SMYNG, HOT, CHICKEN, 141, 47.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>17226.0,
          :full_parsed_line=>"P, 101023011374, (, KALE, LOKALI, 19,140 - 1.914"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002034786, (, VALOR, HELLO, KITTY, TRIO, EGGS, 60GR, ), 69.700"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>12200.0,
          :full_parsed_line=>
           "POPULAR, EXPRESS, BERAWA, Jl, ., Pantai, Berawa, ,, Tibubeneng, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C20000061734, Counter, :, C2, 18, -, Dec, -, 2022, 16:51:43, KSR, IVANA, LISDI, ANA, MARIAYANTI, 101023011599, (, KYURI, ], 12,200"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>4800.0,
          :full_parsed_line=>"101033038145, [, LIFEBUOY, SOAP, LEMON75GR, ], 4.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>38700.0,
          :full_parsed_line=>"P, 101002005378, (, KINDER, BUENO, CHOCO, T, -, 2, ], 48.000 - 9,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>53900.0,
          :full_parsed_line=>"P, 101006052516, [, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60.500 - 6.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>132000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 132,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>10000.0,
          :full_parsed_line=>"101003008003, [, OREO, CHOC, 137, ], 10,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>37500.0,
          :full_parsed_line=>"101002005202, [, KIT, KAT, CHUNKY, 38GR, ], 37,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C10000020143, Counter, :, C1, 20, -, Dec, -, 2022, 09:08:22, DIAH, PRAMESTI, 101006002395, [, LLK, SOY, S, PREMIUM, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>60900.0,
          :full_parsed_line=>"P, 101012008983, (, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 64,000 - 3,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>80700.0,
          :full_parsed_line=>"101005003790, [, TS, HONEY, 350ML, ], 80,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>1900.0,
          :full_parsed_line=>"P, 101009001044, [, CRYSTALLINE, PET, 600ML, ], 2,500 - 600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>"101011008649, HW, HATTEN, AGA, WHITE, 2LT, ], 319,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>16500.0,
          :full_parsed_line=>"101007001606, [, SEGITIGA, BIRU, TPG, TRG, 1KG, ), 16,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>44234.0,
          :full_parsed_line=>"P, 101024011806, [, PEAR, FORELLE, KG, ], 49,149 - 4,915"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>69000.0,
          :full_parsed_line=>"101006030015, THINS, SOUR, CREAM, &, CHIVES, 1, 75gr, ], 69,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002008264, [, ZAINI, TOY, S, T, EGG, 601, 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002000028, [, ZAINI, MICKEY, 60G, ], 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002005480, [, ZAINI, MINIE, T, EGG, 601, 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>69700.0,
          :full_parsed_line=>"101002005479, (, ZAINI, SOFIA, T, EGG, 601, 69,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>99400.0,
          :full_parsed_line=>"101012009283, YUMMY, RICOTTA, 250GR, ], 99,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>95400.0,
          :full_parsed_line=>"101012009326, [, TELUR, RENDAH, KOLESTEROL, 10S, 95,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>2900.0,
          :full_parsed_line=>"101051052804, [, AVANI, ECO, CASSAVA, BAG, MEDIU, M, PEPITO, ], 2,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>38208.0,
          :full_parsed_line=>"P, 101023011536, [, RED, RADISH, ], 42,453 - 4,245"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>39600.0,
          :full_parsed_line=>"P, 101023011558, (, S, BAWANG, PUTIH, 300GR, ], 44,000 - 4,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>132000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT1001, 132,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>27000.0,
          :full_parsed_line=>"101002008133, (, DELFI, CHACHA, PEANUT, 40GR, ), 27,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>14900.0,
          :full_parsed_line=>"101004051679, (, ANDROS, APPLE, BANANA, FMU, 90G, 14,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>14900.0,
          :full_parsed_line=>"101004051678, LANDROS, STRAWBERRY, PINK, GUAV, A, FMU, 90GR, ], 14.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITTIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>65000.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 65,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>24000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C20000098707, Counter, :, C2, 25, -, Dec, -, 2022, 10:19:20, YUMAS, MAHADEWI, 101051022866, [, PEPITO, BAG, LI, 24,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>60900.0,
          :full_parsed_line=>"P, 101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ], 64,000 - 3,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>95800.0,
          :full_parsed_line=>"P, 101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ], 113,000 - 17,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>116730.0,
          :full_parsed_line=>"P, 101011000337, [, BALI, HAI, PREMIUM, CAN, 6X320M, L, ], 129,700 - 12,970"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>41700.0,
          :full_parsed_line=>"101024011712, [, NANAS, HONI, MEDIUM, ], 41,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>28380.0,
          :full_parsed_line=>"101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, 28,380"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>57663.0,
          :full_parsed_line=>"101024011733, (, APEL, RED, WASHINGTON, ], 57,663"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>57960.0,
          :full_parsed_line=>"101023011600, (, ZUCHINI, HIJAU, KG, ], 57,960"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9835.0, :full_parsed_line=>"101023011595, (, KOL, PUTIH, BULAT, ], 9,835"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>15819.0,
          :full_parsed_line=>"101023011608, [, JAGUNG, MANIS, KULITI, 15,819"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, (, COCA, COLA, PET, 1500ML, ), 15,900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>24500.0,
          :full_parsed_line=>"101034043611, [, NEPPI, BABY, WIPES, PARFUME, 50, S, ], 24,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>25000.0,
          :full_parsed_line=>"101002008153, [, ZAINI, MINNIE, 18GR, ], 25,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>25000.0,
          :full_parsed_line=>"101002008152, [, ZAINI, MICKEY, 18GR, ], 25,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>138000.0,
          :full_parsed_line=>"101003035550, (, THINS, CHICKEN, 175GR, ), 138,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>49000.0,
          :full_parsed_line=>"101044020895, [, PASEO, SINGLE, 200S, ], 49,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>89400.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, NO5, 500, G, R, ], 89,400"},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>12000.0, :full_parsed_line=>"101051022866, [, PEPITO, BAG, LI, 12,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>77500.0,
          :full_parsed_line=>"101007052809, [, ORGANICO, WHITE, QUINOA, 500, G, 77,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011646IF, TOMAT, CHERY, RED, PC, ), 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ), 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>69000.0,
          :full_parsed_line=>"101003035551, [, THINS, CHEESE, AND, ONION, 175G, R, ], 69,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>6300.0,
          :full_parsed_line=>"101009000761, (, AQUA, CLICK, N, GO, 750, ML, ], 6.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>34500.0,
          :full_parsed_line=>"101006034829, (, BAMBOO, RICE, NOODLE, 5, MM, (, L, ), 34,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>55300.0,
          :full_parsed_line=>"101005007055, (, QUAKER, OATS, QUICK, COOKING, B, AG, BOOGR1, 55.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, (, TRADITIONAL, TOAST, ), 26.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>99400.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ), 99,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>30900.0,
          :full_parsed_line=>"101023011395, [, PAPRIKA, MERAH, HYDRO, ], 30.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15000.0,
          :full_parsed_line=>"101066049470, (, BIANKA, YOUNG, COCONUT, 15K, ], 15,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>27000.0,
          :full_parsed_line=>"101043020515, (, SUNLIGHT, MINT, REFF, 755ML, ), 27,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>56900.0,
          :full_parsed_line=>"101007031126, [, MCKENZIES, RED, LENTILS, 375GRI, S, ], 56,900"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7000.0, :full_parsed_line=>"1010230113671DN, BAWANG, BESAR, PCS, ), 7.000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>59000.0, :full_parsed_line=>"101024011772, BLUEBERRIES, 125GR, ], 59,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>50700.0,
          :full_parsed_line=>"101023011553, [, BF, RED, ONION, PACK, ], 50,700"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>20000.0,
          :full_parsed_line=>"101044020912, [, PASEO, SOFTPACK, PURES, 130S, ], 20,000"},
         {:category_name=>"Лиля",
          :sub_category_name=>"Ванные принадлежности",
          :price=>16900.0,
          :full_parsed_line=>"101033017411, [, CAREFREE, FRESH, SD, 20S, ], 16,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>41900.0,
          :full_parsed_line=>"101012009342, [, LAUGHING, COW, CHS, PLAIN, 120G, R, ], 41,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>2500.0,
          :full_parsed_line=>"101002039798, [, DELFI, BAR, BAR, 18GR, ], 2,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>18000.0,
          :full_parsed_line=>"101002008133, [, DELFI, CHACHA, PEANUT, 40GR, ), 18,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>4000.0,
          :full_parsed_line=>"101002041477, [, DELFI, CHIC, CHOC, MINI, 20GR, ], 4,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>132000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 132,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005440, [, DF, BAR, CASHEW, 125GR, ], 30,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005441, [, DF, BAR, ALMOND, 125GR, ], 30,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>50000.0,
          :full_parsed_line=>"101002008155, [, ZAINI, CARS, 18GR, ], 50,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>23000.0,
          :full_parsed_line=>"101006006038, [, FERMIPAN, 4S, X, 11GR, ], 23,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>4900.0,
          :full_parsed_line=>"101006006032, (, KP2U, SODA, KUE, 81GR, ], 4,900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>4900.0,
          :full_parsed_line=>"101006003246, [, KP2, PHRN, MERAH, TUA, 31, 4,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>53900.0,
          :full_parsed_line=>"P, 101006052516, (, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60,500 - 6.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>33500.0,
          :full_parsed_line=>"101006003451, [, CIRIO, PURE, TOMAT, 350, ], 33,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>52900.0,
          :full_parsed_line=>"101012009366, [, BABYBEL, MINI, CHEESE, 5S, ], 52,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>90000.0,
          :full_parsed_line=>"101012009312, [, TELUR, OMEGA, 3, 10S, AA, ], 90,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>69900.0,
          :full_parsed_line=>"P, 101012009430, [, BEGA, MILD, CHEDDAR, 250GR, ], 82,500 - 12.600"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21897.0, :full_parsed_line=>"101023011535, [, BEETROOT, ], 21,897"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32500.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 32,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>38349.0,
          :full_parsed_line=>"101021011216, [, MAMAS, FRENCH, SALAMI, KG, ], 38,349"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>23600.0,
          :full_parsed_line=>"101023011394, [, PAPRIKA, HIJAU, HYDRO, ], 23,600"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>49000.0,
          :full_parsed_line=>"101033016338, [, DOVE, BW, AQUA, MOIST, REF, 400M, L, ], 49,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>29800.0,
          :full_parsed_line=>"101004051679, (, ANDROS, APPLE, BANANA, FMU, 90G, R, ], 29.800"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15790.0, :full_parsed_line=>"101023011599, (, KYURI, ], 15.790"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9630.0, :full_parsed_line=>"101023011657, [, PARSLEY, ], 9.630"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10954.0, :full_parsed_line=>"101023011531, [, WORTEL, MEDAN, ], 10.954"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>6975.0, :full_parsed_line=>"101024011735, (, LEMON, IMPORT, KG, ], 6.975"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21780.0, :full_parsed_line=>"101023011374, (, KALE, LOKAL, ], 21.780"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7808.0, :full_parsed_line=>"101023011365, (, RUCOLA, LETTUCE, ], 7.808"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>65500.0,
          :full_parsed_line=>"101044020858, [, PASEO, TISSUE, WHITE, 8ROLL, ], 65,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60000.0,
          :full_parsed_line=>"101066051212, [, BAME, TARO, CAKE, ), 60,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>44500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobckan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 4C20000094437, Counter, :, C2, 30, -, Dec, -, 2022, 15:37:12, KSR, PUTRI, AISAH, 1010060348421HUGO, RETZ, GRKIN, BABY, DILL6, 44,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>141500.0,
          :full_parsed_line=>"101012009288, [, ANCHOR, SPECIAL, COOKING, CREA, M, 1LT, ], 141,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>106272.0,
          :full_parsed_line=>"101021011194, [, AR, SMOKE, HAM, KG, ], 106,272"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>40000.0,
          :full_parsed_line=>"101007028788, [, SHUKRIYA, BASMATI, RICE, 1KG, ], 40,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>50405.0,
          :full_parsed_line=>"P, 101034017781, [, J, &, J, B.MILK, BATH, 500ML, ), 59,300 - 8,895"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>12200.0,
          :full_parsed_line=>"101044020848, [, POLYTEX, PKT, SABUT, SPON, REGU, LER, 2S, ], 12,200"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>34800.0,
          :full_parsed_line=>"101033014560, [, COLG.WHITENNING, 160, ], 34,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>38700.0,
          :full_parsed_line=>"P, 101002005378, [, KINDER, BUENO, CHOCO, T, -, 21, 48,000 - 9,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>80000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 80,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>14000.0,
          :full_parsed_line=>"101006048609, (, GOLDEN, CANNED, GREEN, PEAS, 39, 14,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>149100.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 149,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>24000.0,
          :full_parsed_line=>"101002005202, [, KIT, KAT, CHUNKY, 38GR, ], 24,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>33500.0,
          :full_parsed_line=>"101034049725, [, JORDAN, KIDS, TOOTHPASTE, 75GR, 33,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>53500.0,
          :full_parsed_line=>"101002008147, [, M, &, M, PEANUT, BUTTER, ], 53,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>53500.0,
          :full_parsed_line=>"101002008146, [, M, &, M, PEANUT, 1.74, OZI, 53,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>61800.0,
          :full_parsed_line=>"101002005442, [, DELFI, FRUIT, &, NUT, 140GR, ], 61.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>16000.0,
          :full_parsed_line=>"101078037977, [, NEW, BRUXEL, ORIGINAL, ], 16,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>23900.0,
          :full_parsed_line=>"P, 101006003414, [, BOND, EXT, FINE, PEAS, 2, ], 27,500 - 3.600"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>10500.0,
          :full_parsed_line=>"101033015911, [, DETTOL, BARSOAP, SKIN100GR, ], 10,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>29000.0,
          :full_parsed_line=>"101002007975, (, KIT, KAT, C2F, /, 1021, 29,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005440, [, DF, BAR, CASHEW, 125GR, ], 30,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>17500.0,
          :full_parsed_line=>"101078037976, [, NEW, BRUXEL, CHOCOLATE, ], 17,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000001618, Counter, :, C3, 07, -, Jan, -, 2023, 15:38:35, FITRI, INDAH, SAR, 101002005370, [, CADBURY, LICKABLER, 20G, ], 16,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>76400.0,
          :full_parsed_line=>"101013044795, [, TRIPLE, THREE, HONEY, BAKED, HA, M, 100GR, ], 76.400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66500.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 66.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005410, [, LINDT, WHOLEALMON100, ], 66.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005440, [, DF, BAR, CASHEW, 125GR, ], 30.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005442, [, DELFI, FRUIT, &, NUT, 140GR, ], 30.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>11000.0,
          :full_parsed_line=>"101002039948, [, CHOMP, CHOMP, BRGR, MRSMLW, 60G, R, ], 11.000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>57105.0, :full_parsed_line=>"101019010987, (, PORK, FILLET, KG, ], 57.105"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, 33.000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17050.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 17,050"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>15400.0,
          :full_parsed_line=>"101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ], 15,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>110600.0,
          :full_parsed_line=>"101021011087, [, BOCCONCINI, FRESH, CHS, KG, ], 110,600"}],
        530855.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 22', freezed_time: '2023-01-09T03:39:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out44.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>84500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Counter, :, C2, Bill, No, :, 5C20000001524, 2023, 09:13:44, ENI, PUSPA, YANTI, 06, -, Jan, -, 101034043603, [, NEPPI, DIAPER, BABY, L, 265, ], 84,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>41200.0,
          :full_parsed_line=>"101003000067, [, LRZ, NAT, CLASSIC, 100G, ], 41.200"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>69000.0,
          :full_parsed_line=>"101003035550, (, THINS, CHICKEN, 175GRI, 69,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>42900.0,
          :full_parsed_line=>"101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, 42,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>35000.0,
          :full_parsed_line=>"101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, S, ], 35,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>52640.0,
          :full_parsed_line=>"101017010961, [, PRIME, BEEF, STRIPLOIN, ], 52,640"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>49613.0,
          :full_parsed_line=>"101017010961, [, PRIME, BEEF, STRIPLOIN, ], 49.613"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>77767.0,
          :full_parsed_line=>"101021011074, [, MOZZARELLA, FRESH, KG, ], 77.767"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>17800.0,
          :full_parsed_line=>"101023011394, [, PAPRIKA, HIJAU, HYDRO, ], 17.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>"101011008649, [, HW, HATTEN, AGA, WHITE, 2LT, ], 319,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000002918, Counter, :, C3, 12, -, Jan, -, 2023, 16:32:16, YUMAS, MAHADEWI, 101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ], 56,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>16000.0,
          :full_parsed_line=>"101007001617, [, KUNCI, BR, TPG, TRG, 1KG, ], 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>34320.0, :full_parsed_line=>"101023011599, [, KYURI, ], 34,320"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>24500.0,
          :full_parsed_line=>"101044020895, [, PASEO, SINGLE, 2008, ], 24,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>12000.0,
          :full_parsed_line=>"101002040433, [, DILAN, CHO, CRNCHY, PCH, 10X9.5, 12,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>38500.0,
          :full_parsed_line=>"101012054385, [, MILK, UP, PLAIN, YOGURT, 330ML, ], 38,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>57000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, 6X45ML, ), 57,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15660.0, :full_parsed_line=>"101023011365, [, RUCOLA, LETTUCE, ], 15,660"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>17200.0,
          :full_parsed_line=>"101023011394, [, PAPRIKA, HIJAU, HYDRO, ], 17.200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>24000.0,
          :full_parsed_line=>"101012009324, [, TELUR, AYAM, NGRI, 10S1, 24.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ], 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>43500.0,
          :full_parsed_line=>"101003028839, [, LORENZ, NAT, ., MIT, PARMESAN, 10, OGR, ), 43.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>43500.0,
          :full_parsed_line=>"101003007695, (, LRZ, NAT, ROSEMRY, 100G, ], 43.500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>24500.0,
          :full_parsed_line=>"101034043612, [, NEPPI, BABY, W.NON, PARFUME, 50, 24,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>39500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000004255, Counter, :, C2, 15, -, Jan, -, 2023, 13:57:04, YUMAS, MAHADEWI, 101015009981, (, WALLS, CRNT, MINI, CHVN, ], 39,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>149100.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 149,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006002395ILLK, SOY, S, PREMIUM, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ], 15,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>52800.0,
          :full_parsed_line=>"101006006395, [, DC, CONHIGLIE, RIGATE, ], 52,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>72500.0,
          :full_parsed_line=>"1010020054791ZAINI, SOFIA, T, EGG, 601, 72,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>18000.0,
          :full_parsed_line=>"101002008133, [, DELFI, CHACHA, PEANUT, 40GR, ], 18,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>14800.0,
          :full_parsed_line=>"101002050616, (, ELVAN, TRUFFLE, COCONUT, 115GR, 14,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITIONAL, TOAST, !, 26.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>60500.0,
          :full_parsed_line=>"101006052516, (, KEWPIE, MAYONAIS, ORIGINAL, 30, OGR, ], 60.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, S, ], 33.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7700.0,
          :full_parsed_line=>"101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ), 7,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>104130.0,
          :full_parsed_line=>"101022011273, [, TUNA, B, TORO, FILLE, ], 104,130"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17108.0, :full_parsed_line=>"101023011535, [, BEETROOT, ], 17.108"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7700.0,
          :full_parsed_line=>"101002000018, [, DF, CHACHA, MINIS, HATS, 30GR, ), 7,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>72500.0,
          :full_parsed_line=>"101002008264, [, ZAINI, TOY, S, T, EGG, 601, 72.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32344.0,
          :full_parsed_line=>"101021029987, [, MAMAS, SALAMI, MILANO, KG, ], 32,344"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>29000.0,
          :full_parsed_line=>"101002007975, [, KIT, KAT, C2F, /, 1021, 29,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005440, [, DF, BAR, CASHEW, 125GR, ], 30,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005441, (, DF, BAR, ALMOND, 125GR, ], 30,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>27885.0,
          :full_parsed_line=>"101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, 27,885"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>57000.0,
          :full_parsed_line=>"101015009983, (, MAGNUM, MINI, ALMOND, 6X45ML, ], 57,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>67500.0,
          :full_parsed_line=>"101012054384, [, MILK, UP, SOUR, CREAM, 25, %, 330M, L, ], 67,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>70000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, PERERENAN, Jl, ., By, Pass, Munggu, -, Pererenan, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000007522, Counter, :, C2, 25, -, Jan, -, 2023, 15:38:44, DIAN, AMIRA, SARI, 101015041382, IL, GELATO, VANILLA, 100ML, ], 70,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITTIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>32000.0,
          :full_parsed_line=>"101002008314, [, HALLS, MENTHOLYPTUS, 34GR, ], 32,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000006253, Counter, :, C3, 25, -, Jan, -, 2023, 21:14:45, GITA, SINTYA, DEW, 101011008649, [, HW, HATTEN, AGA, WHITE, 2LT1, 319,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>148000.0,
          :full_parsed_line=>"101012009577, (, BERRI, JUICE, PINEAPPLE, 2LT, ], 148,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ), 15,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>39500.0,
          :full_parsed_line=>"101015009982, [, WALLS, CRNT, MN, CHTRM, ), 39,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>43500.0,
          :full_parsed_line=>"101003007683, [, LOREN, SALTL, BREZ, 150, ], 43.500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>14000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000008709, Counter, :, C2, 25, -, Jan, -, 2023, 07:47:55, MAYLDA, ANDRIANI, 101002051539, [, DF, BAR, BAR, SHARE, PACK, 10S, ], 14.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>111500.0,
          :full_parsed_line=>"101012009493, [, GREENFIELDS, CHS, BOCCONCINI, 330GR, ), 111,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>31500.0,
          :full_parsed_line=>"P, 101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, 35,000 - 3,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>59500.0,
          :full_parsed_line=>"1010020327221THE, NATURAL, BERRY, BLISS, 180, GR, ], 59,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>"101002054508, [, MILKA, AARDBEI, YOGHURT, 100GR, 44.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>11583.0,
          :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 12.870 - 1.287"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>29000.0,
          :full_parsed_line=>"101002007975, [, KIT, KAT, C2F, /, 102, ], 29.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>30900.0,
          :full_parsed_line=>"101002005442, (, DELFI, FRUIT, &, NUT, 140GR, ], 30,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>51190.0,
          :full_parsed_line=>"101013053322IMAMAS, KALBERWURSTI, 51.190"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18000.0,
          :full_parsed_line=>"P, 101023011646, [, F, TOMAT, CHERY, RED, PC1, 20.000 - 2.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>99400.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GRI, 99.400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>82894.0,
          :full_parsed_line=>"P, 101023011600, (, ZUCHINI, HIJAU, KG, ], 92.104 - 9.210"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>26037.0,
          :full_parsed_line=>"P, 101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, 28.930 - 2,893"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000005124, Counter, :, C3, 21, -, Jan, -, 2023, 16:53:46, MITA, JUNIANTARI, P, 101010000612, [, HAPPY, DAY, MIXED, JUICE, 1LT, ], 56,500 - 8,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>85900.0,
          :full_parsed_line=>"P, 101007001919, (, BORGES, SUNFLOWER, 1LT, ], 97.000 - 11,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>67000.0,
          :full_parsed_line=>"101012009542, [, JUNGLE, JC, MANGO, 2LT, ], 67.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>137500.0,
          :full_parsed_line=>"101003037583, [, KANGAROO, PISTACHIOS, 250GR, ], 137,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ], 15.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>"101002054508, [, MILKA, AARDBEI, YOGHURT, 100GR, 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>"101002054500, [, MILKA, GEBROKEN, NOOT, 100GR, ], 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>39500.0,
          :full_parsed_line=>"101015009982, [, WALLS, CRNT, MN, CHTRM, ], 39,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000009362, Counter, :, C2, 02, -, Feb, -, 2023, 08:07:39, MITA, JUNIANTARI, 101066012224, [, TRADITIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>42322.0,
          :full_parsed_line=>"P, 101019010989, [, PORK, ROAST, KG, ], 47,025 - 4,703"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>45900.0,
          :full_parsed_line=>"P, 101010001115, [, HAPPY, DAY, ORANGE, 1LT, ], 56.500 - 10,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>34632.0,
          :full_parsed_line=>"P, 101023011536, [, RED, RADISH, ], 38,480 - 3.848"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16038.0,
          :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 17.820 - 1,782"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>67500.0,
          :full_parsed_line=>"101012009257, [, ANCHOR, BUTTER, SALTED, PACK, 2, 27GR, ], 67,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>31700.0,
          :full_parsed_line=>"101033037567, [, CHARMI, DENTAL, FLOSS, &, PICK50S, 31,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16200.0,
          :full_parsed_line=>"P, 101023011375, [, MUSHROOM, CHAMPIGNON, ], 18,000 - 1.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 56,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32500.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 32,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>22000.0,
          :full_parsed_line=>"101013029631, [, MAMAS, SMOKED, HAM, 100GR, ], 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>79500.0,
          :full_parsed_line=>"1010130447821SMITHFIELD, MARPLE, HAM, 100GR, 79,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72000.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>102000.0,
          :full_parsed_line=>"101003005009, [, LAYS, BBQ, 6.5OZ, ], 102,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>27115.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000008898, Counter, :, C2, 31, -, Jan, -, 2023, 15:08:38, YUMAS, MAHADEWI, 101024011683, [, SUNPRIDE, PISANG, CAVENDISH, K, G, ], 27.115"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>95040.0,
          :full_parsed_line=>"101022011336, [, SALMON, FILLET, KG, ], 95,040"},
         {:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>3900.0,
          :full_parsed_line=>"101051048696, [, AVANI, ECO, CASSAVA, BAG, LARGE, PEPITO, ], 3,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>59900.0,
          :full_parsed_line=>"101012009491, [, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>88900.0,
          :full_parsed_line=>"P, 101007001881, [, MAZOLA, SUNFLWR, OIL, 900ML, ], 101,000 - 12,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>57600.0,
          :full_parsed_line=>"101012009454, [, YUMMY, CREAM, CHEESE, 250GR, ], 57,600"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000011903, Counter, :, C3, 04, -, Feb, -, 2023, 08:35:10, KUMARA, DEWI, 101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ], 56,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>149100.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 149,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18000.0,
          :full_parsed_line=>"P, 101023011643, [, TOMAT, CHERRY, HDR, ], 20,000 - 2,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16300.0,
          :full_parsed_line=>"101002008400, [, HARIBO, WORM, 80GR, ], 16,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>78030.0,
          :full_parsed_line=>"P, 101023029795TSUNRISE, RED, ONION, 500, GR, ], 86,700 - 8,670"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>"101002054508, [, MILKA, AARDBEI, YOGHURT, 100GR, 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>24000.0,
          :full_parsed_line=>"101002005202, [, KIT, KAT, CHUNKY, 38GR, ], 24,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>15400.0,
          :full_parsed_line=>"101002000018, [, DF, CHACHA, MINIS, HATS, 30GR, ], 15,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>31950.0,
          :full_parsed_line=>"P, 101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, S, ], 35,500 - 3,550"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>124225.0,
          :full_parsed_line=>"P, 101022011269, [, MAHI, -, MAHI, FILLET, ], 138,028 - 13,803"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>56800.0,
          :full_parsed_line=>"101002008151, [, KINDER, JOY, NATOONS, 20GR, ], 56,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ], 15,900"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>139500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000008499, Counter, :, C2, 30, -, Jan, -, 2023, 07:36:38, KSR, PUTRI, AISAH, 101005003836, [, NUTELLA, C, SPREAD, 650, ], 139,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>21000.0,
          :full_parsed_line=>"101043020197, [, PROC, WHT, CRTI, ., BTL4001, 21,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ], 56,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>21000.0,
          :full_parsed_line=>"101044020902, [, PASEO, SF, PCK, M, 250S, ], 21,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>37873.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 42,081 - 4,208"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>"101012008983, (, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 56,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITTIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27254.0, :full_parsed_line=>"P, 101023011599, [, KYURI, ], 30,282 - 3,028"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>22394.0,
          :full_parsed_line=>"P, 101023011374, [, KALE, LOKAL, ], 24.882 - 2,488"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>31500.0,
          :full_parsed_line=>"P, 101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, S, ], 35,000 - 3,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>42048.0,
          :full_parsed_line=>"P, 101023011656, [, DAUN, DIIL, ], 46,720 - 4,672"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8891.0, :full_parsed_line=>"P, 101023011657, [, PARSLEY, ], 9,879 - 988"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, S, ], 33,000"},
         {:category_name=>"Лиля",
          :sub_category_name=>"Одежда",
          :price=>29900.0,
          :full_parsed_line=>"101033017649, (, C, &, D, JEPIT, RAMBUT, ], 29,900"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>107500.0,
          :full_parsed_line=>
           "POPULAR, EXPRESS, BERAWA, Jl, ., Pantai, Berawa, ,, Tibubeneng, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5010000004644, Counter, :, C1, 10, -, Feb, -, 2023, 13:22:10, KSR, PUTU, EKAYAN, 101002053595, [, KITKAT, MINI, STRAWBERRY, 124G, R, ], 107,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44500.0,
          :full_parsed_line=>"101002054510, [, MILKA, OREO, WHITE, 100GRI, 44,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>49500.0,
          :full_parsed_line=>"101002054505, [, MILKA, BUBBLY, 100GR, ], 49,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>47000.0,
          :full_parsed_line=>"101002054507, [, MILKA, OREO, SANDWICH, 92GR, ], 47.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44500.0,
          :full_parsed_line=>"101002054503, [, MILKA, DAIM, 100GR, ], 44.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITIONAL, TOAST, ], 26.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>103500.0,
          :full_parsed_line=>"101007001881, [, MAZOLA, SUNFLWR, OIL, 900ML, ], 103,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>21000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5020000010910, Counter, :, C2, 07, -, Feb, -, 2023, 07:45:40, KOMANG, SRI, DEWI, 101013026948, (, MAMAS, ROAST, BLACK, PEPPER, 1, COGR, ], 21,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32500.0,
          :full_parsed_line=>"101013029635IMAMAS, SALAMI, MILANO, 100GR, ), 32,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32558.0,
          :full_parsed_line=>"1010210112251AROMA, STREAKY, BACON, KGJ, 32,558"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>47509.0,
          :full_parsed_line=>"P, 101016010898, CHICKEN, BROILER, KG, ], 52,788 - 5.279"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>45791.0,
          :full_parsed_line=>"P, 101016010898, CHICKEN, BROILER, KG, ], 50,879 - 5.088"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>179500.0,
          :full_parsed_line=>"101013009706, [, TV, SMOKED, BR, SAUSAGE, 396GRI, 179.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>45900.0,
          :full_parsed_line=>"P, 101010000608, (, HAPPY, DAY, STRAWBERRY, 1L, ], 56.500 - 10,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"1010120092821YUMMY, SOUR, CREAM, 200GR, ), 39.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>17597.0,
          :full_parsed_line=>"P, 101023011536, (, RED, RADISHI, 19.552 - 1,955"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>67500.0,
          :full_parsed_line=>"101012009247LANCHOR, BUTTER, UNSALT, PACK22, 7GR, ], 67.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>52000.0,
          :full_parsed_line=>"101012050373, (, PRESIDENT, GOUDA, TASTY, 10S1, 52.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>14751.0,
          :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 16,390 - 1.639"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>6300.0,
          :full_parsed_line=>"P, 101023011370, (, DAUN, BAWANG, FRE, PCS, ], 7.000 - 700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>84000.0,
          :full_parsed_line=>"101013053701, (, UBUD, COLD, SMOKED, SALMON, CLA, SSIC, 100GRI, 84.000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>54900.0,
          :full_parsed_line=>"1010340177820J, &, J, B.WASH, TTT, 500MLJ, 54,900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>14800.0,
          :full_parsed_line=>"101044020840, (, POLYTEX, SABUT, SPON, EXTRA, KU, 14.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>74900.0,
          :full_parsed_line=>"101021011087, (, BOCCONCINI, FRESH, CHS, KG, ], 74,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>"101002005405, (, LINDT, MILK, 100GRI, 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>132000.0,
          :full_parsed_line=>"101002005410, (, LINOT, WHOLEALNON1001, 132,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>10500.0,
          :full_parsed_line=>"101033014478, [, FORMULA, TBRUSH, SANRIO, ], 10,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4864.0, :full_parsed_line=>"P, 101023011657, (, PARSLEY, ], 5.405 - 541"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>41900.0,
          :full_parsed_line=>"101012031786, [, ROSSA, 75, %, RENKOL, 1061, 41.900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>35000.0,
          :full_parsed_line=>"101033052604, INATUR, SHAMPOO, GINSENG, EXTRA, CT, 140, MLI, 35.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>107500.0,
          :full_parsed_line=>"101002031139, (, KITKAT, MINI, ORIGINAL, 163GRI, 107.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>22000.0,
          :full_parsed_line=>"101066012226, [, BATARD, BREAD, 300GR, ], 22.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>37920.0,
          :full_parsed_line=>"P, 1010020053781KINDER, BUENO, CHOCO, T, -, 21, 48,000 - 10.080"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>65500.0,
          :full_parsed_line=>"101044020858, PASEO, TISSUE, WHITE, 8ROLL1, 65,500"}],
        1348490.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 35', freezed_time: '2023-02-12T05:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out57.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>59460.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000011653, Counter, :, C2, 09, -, Feb, -, 2023, 14:40:47, KSR, PUTRI, AISAH, 101021011074, [, MOZZARELLA, FRESH, KG, ], 59,460"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0, :full_parsed_line=>"[, TOMAT, CHERRY, HDR, ], 20.000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8835.0, :full_parsed_line=>"[, JAGUNG, MANIS, KUPAS, ], 8.835"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>179500.0,
          :full_parsed_line=>"[, JV, SMOKED, BR, SAUSAGE, 396GR, ], 179.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>179500.0,
          :full_parsed_line=>"[, JV, GARLIC, BRATWURS, 396GR, ], 179.500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>22000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C10000007856, Counter, :, C1, 16, -, Feb, -, 2023, 07:45:00, NI, MADE, SARI, AS, 101066012226, [, BATARD, BREAD, 300GR1, 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, 33,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 40,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5947.0, :full_parsed_line=>"P, 101023011657, [, PARSLEY, ], 6,608 - 661"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ], 15,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>58000.0,
          :full_parsed_line=>"101012048564, [, GANESHA, SORA, MOZZARELLA, PAS, TA, 200GR, ], 58,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>149100.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 149.100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>111500.0,
          :full_parsed_line=>"101012009493, [, GREENFIELDS, CHS, BOCCONCINI, 330GR, ], 111.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16650.0,
          :full_parsed_line=>"P, 101023011375, [, MUSHROOM, CHAMPIGNON, ], 18.500 - 1.850"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>85756.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 95.284 - 9,528"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>28500.0,
          :full_parsed_line=>"101006045767, [, LEE, KUM, KEE, SOY, SAUCE, 250ML, 28,500"},
         {:category_name=>"Коля",
          :sub_category_name=>"Ванные принадлежности",
          :price=>45500.0,
          :full_parsed_line=>"101033014735, (, GILLETE, FM, MTH, 175GR, ], 45,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>84500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, VOUCHER, RAMA, HOLIDAY, Item, Sales, Bill, No, :, 5C10000010215, Counter, :, C1, 16, -, Feb, -, 2023, 09:05:13, DIMAS, KSR, 101034043604, [, NEPPI, DIAPERS, BABY, XL, 22, S, ], 84,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11730.0, :full_parsed_line=>"101023011596, [, SAWI, PUTIH, ], 11.730"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>35500.0,
          :full_parsed_line=>"101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, 35,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>41500.0,
          :full_parsed_line=>"101004007274, [, PEACHY, B, CANT, &, PTT110, ], 41,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011643, [, TOMAT, CHERRY, HDR, ], 20.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>14900.0,
          :full_parsed_line=>"101004051676, [, ANDROS, MANGO, BANANA, PASION, FMU, 90GR, ], 14,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>14900.0,
          :full_parsed_line=>"101004051679, [, ANDROS, APPLE, BANANA, FMU, 90G, R, ], 14.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16300.0,
          :full_parsed_line=>"101002008384, [, HRB, G, BEARS, 80GR, ], 16.300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>46107.0,
          :full_parsed_line=>"101021038850, [, MAMAS, GERMAN, SALAMI, KG, ], 46,107"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>71800.0,
          :full_parsed_line=>"101013044797, [, TRIPLE, THREE, BACK, BACON, 100, GR, ], 71,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>80200.0,
          :full_parsed_line=>"101013044793, (, TRIPLE, THREE, BLACK, FORES, HA, M, 100GR, ], 80,200"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13800.0,
          :full_parsed_line=>
           "POPULAR, EXPRESS, BERAWA, Jl, ., Pantai, Berawa, ,, Tibubeneng, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000010889, Counter, :, C2, 16, -, Feb, -, 2023, 12:45:57, KSR, IBNU, P, 101010000886, [, GREENFIELD, UHT, FULLCREAM, 25, OML, ], 15,600 - 1,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>28400.0,
          :full_parsed_line=>"101002008151, [, KINDER, JOY, NATOONS, 20GR, ], 28.400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>49500.0,
          :full_parsed_line=>"101002054505, [, MILKA, BUBBLY, 100GR, ], 49,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>47000.0,
          :full_parsed_line=>"101002054507, [, MILKA, OREO, SANDWICH, 92GR, ], 47,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>65000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000014072, Counter, :, C2, 18, -, Feb, -, 2023, 15:02:57, ENI, PUSPA, YANTI, 101066045222, [, BAME, MINI, BLACK, FOREST, CAKE, 65,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>68000.0,
          :full_parsed_line=>"101066045311, (, BAME, MINI, RED, VELVET, ], 68,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>"101012008983, (, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ], 56,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>22000.0,
          :full_parsed_line=>"101066012226, [, BATARD, BREAD, 300GR, ], 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>17200.0,
          :full_parsed_line=>"101010000885, [, GREENFIELD, UHT, FULLCREAM, 12, 5ML, ), 17,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>59300.0,
          :full_parsed_line=>"101002034264, (, THE, BELGIAN, MILK, HAZEL, 100G, R, ], 59,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>46500.0,
          :full_parsed_line=>"101002054507, [, MILKA, OREO, SANDWICH, 92GR, ], 46,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>"101002054501, [, MILKA, ALPENMELK, 100GR, ], 44.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>45360.0,
          :full_parsed_line=>"101022011270, [, TUNA, STEAK, FRESH, ], 45.360"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>84960.0,
          :full_parsed_line=>"101022011270, (, TUNA, STEAK, FRESH, ], 84,960"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>46080.0,
          :full_parsed_line=>"101022011270, [, TUNA, STEAK, FRESH, ], 46,080"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>32600.0,
          :full_parsed_line=>"101002008400, [, HARIBO, WORM, 80GR, ], 32,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>47900.0,
          :full_parsed_line=>"P, 101012026289, [, BEGA, SUPER, SLICE, 250GR, ], 57,500 - 9,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 40,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17000.0, :full_parsed_line=>"101023052044, [, EO, HERB, DILL, ], 17,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>22950.0,
          :full_parsed_line=>"101021029986, (, MAMAS, GAMMON, HAM, KG, ], 22,950"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>21780.0,
          :full_parsed_line=>"101021011195, [, AR, COOKED, HAM, KG, ], 21.780"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>28400.0,
          :full_parsed_line=>"101002008151, [, KINDER, JOY, NATOONS, 20GR, ], 28,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>56300.0,
          :full_parsed_line=>"101006006406, (, DLV, FARFALLE, 22, 500G, ), 56,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>11000.0,
          :full_parsed_line=>"101023011371, [, DN, BAWANG, CHUNG, PCS, ], 11,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000017753, Counter, :, C3, 21, -, Feb, -, 2023, 09:30:47, AYU, KADEK, PUTRI, 101006001871, [, MS, MAYONAISE, 300GR, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>15900.0,
          :full_parsed_line=>"101010001057, [, COCA, COLA, PET, 1500ML, ], 15.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>149100.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 149,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>12000.0,
          :full_parsed_line=>"101003004904, [, CHITATO, BEEF, BBQ, 681, 12.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>102000.0,
          :full_parsed_line=>"101003005010, (, LAYS, SALT, &, VINEGAR, ], 102.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16300.0,
          :full_parsed_line=>"101002008400, (, HARIBO, WORM, 80GR, ], 16,300"}],
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
      expect(result).to eq(
        [[{:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>121500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000008572, Counter, :, C3, 23, -, Feb, -, 2023, 07:33:05, DEWA, AYU, KADE, S, UARNITI, ASIH, 101034017883, [, SWEETY, PANT, R.GL, LJ, 121,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 56.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>10044.0,
          :full_parsed_line=>"P, 101023011657, [, PARSLEY, ], 11,160 - 1,116"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>18100.0,
          :full_parsed_line=>"101033017507, [, MITU, BABY, WIPES, F, &, C, PINK, CH, ERRY, 40S, ], 18.100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>254000.0,
          :full_parsed_line=>"101015009983, [, MAGNUM, MINI, ALMOND, 6X45ML, ), 254,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>38919.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 43.243 - 4.324"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>39292.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 43.658 - 4,366"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>60000.0,
          :full_parsed_line=>"101044048871, [, AYU, JAS, HUJAN, PONCO, 60000, ), 60,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>179500.0,
          :full_parsed_line=>"101013009707, [, JV, COOKED, BR, SAUSAGE, 396GRI, 179.500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>121500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C10000008986, Counter, :, C1, 23, -, Feb, -, 2023, 09:24:46, NI, MADE, SARI, AS, 101034017881, [, SWEETY, PANT, R.GL, XL, ], 121,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>71800.0,
          :full_parsed_line=>"101013044799, [, TRIPLE, THREE, BREAKFAST, HAM, 100GR, ], 71.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>24640.0,
          :full_parsed_line=>"101024011683, (, SUNPRIDE, PISANG, CAVENDISH, K, G, ], 24.640"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>23000.0,
          :full_parsed_line=>"101066012229, [, MULTI, CEREAL, BREAD, ], 23,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0, :full_parsed_line=>"101023011536, [, RED, RADISH, ], 31,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>15000.0,
          :full_parsed_line=>"101023011610, [, TOMAT, CHERRY, RED, ], 15,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>17500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000008343, Counter, :, C3, 21, -, Feb, -, 2023, 15:12:46, DEWA, AYU, KADE, S, UARNITI, ASIH, 101049041782, [, LEM, CASTOL, BESAR, ], 17.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>36300.0,
          :full_parsed_line=>"101015038414, [, PALETAS, STRAWBERRY, KIWI, ], 36,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7000.0,
          :full_parsed_line=>"101015009991, [, HALLS, FEAST, VANILA, 65ML, ], 7,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000016622, Counter, :, C2, 26, -, Feb, -, 2023, 08:10:24, NOVI, PRIMANTARI, 101002054506, [, MILKA, CONFETTI, 100GR, ], 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>46500.0,
          :full_parsed_line=>"101002054507, [, MILKA, OREO, SANDWICH, 92GR, ], 46,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>88000.0,
          :full_parsed_line=>"101002054500, [, MILKA, GEBROKEN, NOOT, 100GR, ], 88,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>39516.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 43,907 - 4,391"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44700.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, N05, 500, G, R, ], 44,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>39591.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 43,990 - 4,399"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>41900.0,
          :full_parsed_line=>"101012009342, [, LAUGHING, COW, CHS, PLAIN, 120G, R, ], 41,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>100166.0,
          :full_parsed_line=>"P, 101017010961, [, PRIME, BEEF, STRIPLOIN, ], 111,296 - 11,130"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>119920.0,
          :full_parsed_line=>"P, 101024011742, [, GRAPE, GREEN, SEEDLES, ], 133,245 - 13,325"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>9900.0,
          :full_parsed_line=>"101009001043, [, BALIAN, MINERAL, WATER, PET, 50, OML, ), 9,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>7254.0,
          :full_parsed_line=>"P, 101023011609, [, JAGUNG, MANIS, KUPAS, ], 8,060 - 806"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>19440.0,
          :full_parsed_line=>"P, 101023011535, (, BEETROOT, ], 21,600 - 2,160"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>92606.0,
          :full_parsed_line=>"P, 101022011336, (, SALMON, FILLET, KG, ., 102.896 - 10,290"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>89208.0,
          :full_parsed_line=>"P, 101022011336, [, SALMON, FILLET, KG1, 99,120 - 9,912"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>10375.0,
          :full_parsed_line=>"P, 101023011531, [, HWORTEL, MEDAN, ], 11,528 - 1,153"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>8986.0,
          :full_parsed_line=>"P, 101024011687ISALAK, BALI, KG, ], 9,984 - 998"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>44944.0,
          :full_parsed_line=>"P, 101023011627, [, BEEF, TOMATO, RED, KG, ], 49,938 - 4,994"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>24000.0,
          :full_parsed_line=>"101012009324, [, TELUR, AYAM, NGRI, 10S, ], 24.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, 1, 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>39734.0,
          :full_parsed_line=>"P, 101023030120, (, PLAGA, F, CELERY, STICK, LOKAL, ), 44.149 - 4,415"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>43500.0,
          :full_parsed_line=>"101003007405, [, WF, PISTACIO, SALT, 501, 43,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, (, TRADITIONAL, TOAST, ], 26,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16300.0,
          :full_parsed_line=>
           "PEPITO, MARKET, ECHO, BEACH, Jl, ., Pantai, Batu, Bolong, -, Canggu, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000019876, Counter, :, C3, 27, -, Feb, -, 2023, 09:17:32, KUMARA, DEWI, 101002008400, [, HARIBO, WORM, 80GR, ], 16,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>14000.0,
          :full_parsed_line=>"101023011497, [, GL, ROCOLA, LETTUCE, ], 14,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>56000.0,
          :full_parsed_line=>"101012008983, [, GREENFIELD, FRSH, MILK, FULL, C, REAM, 1890ML, ), 56,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>28400.0,
          :full_parsed_line=>"101002008151, [, KINDER, JOY, NATOONS, 20GR, ], 28,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>59300.0,
          :full_parsed_line=>"101012009325, [, TELUR, OMEGA, 3, 10S, ], 59,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011643, [, TOMAT, CHERRY, HDR, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>111500.0,
          :full_parsed_line=>"101012009493, [, GREENFIELDS, CHS, BOCCONCINI, 330GR, ], 111,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>67500.0,
          :full_parsed_line=>"101012009257, [, ANCHOR, BUTTER, SALTED, PACK, 2, 67,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16720.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 16.720"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>42500.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000016504, Counter, :, C2, 07, -, Mar, -, 2023, 09:40:25, ROSDIANTI, OKTAV, 101005052742, [, YAVA, GRANOLA, W, CASHEW, CHOC, BNNA, 200G, ], 42,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>32000.0,
          :full_parsed_line=>"101002005378, (, KINDER, BUENO, CHOCO, T, -, 2, ], 32,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>68000.0,
          :full_parsed_line=>"101012009247, [, ANCHOR, BUTTER, UNSALT, PACK22, 7GR, ], 68,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>49200.0,
          :full_parsed_line=>"101012009015, [, YUMMY, YOG, NATURAL, PLAIN, 500, GR, ], 49,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>49700.0,
          :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 49,700"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>35500.0,
          :full_parsed_line=>
           "OTTO, MARKET, CANGGU, Fyfa, aya, Canggu, NPI, .046.836.9-904.000, PT, Retailindo, Dewata, Item, Sa, ..., Bill, No, :, 5C30000015923, Counter, :, C3, 08, -, Mar, -, 2023, 10:24:05, GITA, SINTYA, DEW, 101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, S, ], 35,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>59300.0,
          :full_parsed_line=>"101012009325, [, TELUR, OMEGA, 3, 10S, ], 59,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>70434.0,
          :full_parsed_line=>"101021052802, [, MUHLENHOF, BUTTER, CHEESE, 45, %, 70,434"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>40000.0,
          :full_parsed_line=>"101007028788, [, SHUKRIYA, BASMATI, RICE, 1KG, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>45477.0,
          :full_parsed_line=>"101017010961, [, PRIME, BEEF, STRIPLOIN, ], 45,477"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>53500.0,
          :full_parsed_line=>"101002053131, [, SNICKERS, CHOCOLATE, 1.86OZ, ], 53,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>50000.0,
          :full_parsed_line=>"101002005245, [, TWIX, CRML, 1.79, OZ, ), 50,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>27285.0,
          :full_parsed_line=>"101021011198, [, AR, -, DANISH, HAM, WHOLE, KG, ], 27,285"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>28224.0,
          :full_parsed_line=>"101021011224, [, AROMA, BACK, BACON, KG, ], 28,224"}],
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
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>53700.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000021129, Counter, :, C2, 12, -, Mar, -, 2023, 10:23:28, NI, MADE, SARI, AS, 101033040534, [, NATUR, SHP, TEA, TREE, OIL, 270M, 53,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>49500.0,
          :full_parsed_line=>"101002054504, [, MILKA, CHOCO, SWING, BISCUIT, 1, OOGR, ], 49,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>45000.0,
          :full_parsed_line=>"101002054498, [, MILKA, SANDWICH, LU, 87GR, ], 45,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>31000.0,
          :full_parsed_line=>"101043020756, [, BAGUS, SERAP, AIR, 4X50, ], 31,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>46000.0,
          :full_parsed_line=>"101043020769, [, BAGUS, SERAP, AIR, 22S, ], 46,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>55300.0,
          :full_parsed_line=>"101005007055, (, QUAKER, OATS, QUICK, COOKING, B, AG, 800GR, ], 55,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>45235.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 45,235"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>33480.0,
          :full_parsed_line=>"101021011201, [, AROMA, PORK, HONEY, HAM, KG, ], 33,480"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>68000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 68,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7200.0, :full_parsed_line=>"101023011657, [, PARSLEY, ], 7,200"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12558.0, :full_parsed_line=>"101023011599, [, KYURI, ], 12,558"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>41900.0,
          :full_parsed_line=>"101012009342, [, LAUGHING, COW, CHS, PLAIN, 120G, R, ], 41.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44700.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, N05, 500, G, R, ], 44,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>163770.0,
          :full_parsed_line=>"101022011336, [, SALMON, FILLET, KG, ), 163,770"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>14268.0,
          :full_parsed_line=>"101023011627, [, BEEF, TOMATO, RED, KG, ], 14,268"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>15080.0,
          :full_parsed_line=>"101023011607, [, TOMAT, GONDOL, MERAH, KG, ], 15,080"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>127000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5010000011817, Counter, :, C1, 16, -, Mar, -, 2023, 12:41:14, NOVI, PRIMANTARI, 101015009983, [, MAGNUM, MINI, ALMOND, 6X45MLJ, 127,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>28500.0,
          :full_parsed_line=>"101006045767, [, LEE, KUM, KEE, SOY, SAUCE, 250ML, 28,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>41000.0,
          :full_parsed_line=>"101005042429, [, BONCAFE, CLMBN, INSTN, COFFE, 5, OG, ), 41,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, I, 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>46500.0,
          :full_parsed_line=>"101002054507, [, MILKA, OREO, SANDWICH, 92GR1, 46,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44000.0,
          :full_parsed_line=>"101002054500, [, MILKA, GEBROKEN, NOOT, 100GR, ], 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66700.0,
          :full_parsed_line=>"101002005647LJUNGLEGOLD, COCONUT, 100GR, ], 66.700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005779, [, LINDT, MILK, HZNUT100, ], 66.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GRI, 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>25502.0,
          :full_parsed_line=>"101021029987, [, MAMAS, SALAMI, MILANO, KG, ], 25,502"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>20492.0,
          :full_parsed_line=>"101021011225, [, AROMA, STREAKY, BACON, KG, ], 20,492"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>9000.0,
          :full_parsed_line=>"101015041076, [, HALLS, OREO, VANILLA, CUP, 90ML, 9,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>6000.0,
          :full_parsed_line=>"101015010020, [, WALLS, POPULAIRE, STRW, ], 6.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>38688.0,
          :full_parsed_line=>"101021011201, [, AROMA, PORK, HONEY, HAM, KG, ], 38.688"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>23690.0,
          :full_parsed_line=>"101016010904, [, CHICKEN, BREAST, KG, ], 23,690"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>25380.0, :full_parsed_line=>"101023011656, [, DAUN, DIIL, ], 25,380"}],
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
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>31000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5010000012310, Counter, :, C1, 20, -, Mar, -, 2023, 11:49:04, KSR, PUTRI, AISAH, 101043020756, [, BAGUS, SERAP, AIR, 4X50, ], 31,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>45800.0,
          :full_parsed_line=>"P, 101010000914, [, GREENFIELD, UHT, FULLCREAM, 1L, 50,000 - 4,200"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>20000.0,
          :full_parsed_line=>"101044020912, [, PASEO, SOFTPACK, PURES, 130S, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18229.0,
          :full_parsed_line=>"P, 101023011374, [, KALE, LOKAL, !, 19,188 - 959"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>42579.0,
          :full_parsed_line=>"101016010898, (, CHICKEN, BROILER, KG, ], 42.579"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>39425.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 39,425"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, I, 56.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>38559.0,
          :full_parsed_line=>"101016010916, [, MINCED, CHICKEN, KG, ], 38,559"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27953.0, :full_parsed_line=>"P, 101023011599, (, KYURI, ], 29,424 - 1.471"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44700.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, NO5, 500, G, 44,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>84000.0,
          :full_parsed_line=>"101013053701, (, UBUD, COLD, SMOKED, SALMON, CLA, SSIC, 100GR, ], 84.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>9500.0,
          :full_parsed_line=>"101003008010, [, OREO, MINI, VANILA, CUP, ], 9.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>88000.0,
          :full_parsed_line=>"101002054500, (, MILKA, GEBROKEN, NOOT, 100GR, ), 88,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>46500.0,
          :full_parsed_line=>"101002054507, [, MILKA, OREO, SANDWICH, 92GR, ), 46.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>12065.0,
          :full_parsed_line=>"P, 101023052101, [, MUSHROOM, KANCING, BELAH, PCS, ], 12,700 - 635"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>52900.0,
          :full_parsed_line=>"P, 101012009491, (, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900 - 7.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>19800.0,
          :full_parsed_line=>"101003004690, [, YAVA, SEA, SALT, 35GR, ], 19,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16000.0,
          :full_parsed_line=>"101002005378, (, KINDER, BUENO, CHOCO, T, -, 21, 16.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>8500.0,
          :full_parsed_line=>"101013053028, (, SO, NICE, SOSIS, PREMIUM, CHESS, E, 60, GR, ], 8.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>8500.0,
          :full_parsed_line=>"101013053031ISO, NICE, SOSIS, PR, BRATWURST, 60, GR1, 8.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>24000.0,
          :full_parsed_line=>"101012009324, (, TELUR, AYAM, NGRI, 108, ], 24,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>12000.0,
          :full_parsed_line=>"101002005202, (, KITKAT, CHUNKY, 38GR, ], 12,000"}],
        772510.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 51', freezed_time: '2023-03-27T06:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out73.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>31000.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, SEMINYAK, Jl, ., Raya, Kerobokan, -, Br, ., Taman, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000023055, Counter, :, C2, 27, -, Mar, -, 2023, 10:24:36, MIRAH, MEYSHA, 101066012240, [, WHITE, SOUR, DOUGH, BRD, ], 31.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>17500.0,
          :full_parsed_line=>"101007001618, [, CAKRA, KBR, TPG, TERIGU, 1KG, ], 17,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>34000.0,
          :full_parsed_line=>"101066012219, [, ROTI, SOBEK, 20GR, X, 61, 34,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>55000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000014540, Counter, :, C3, 30, -, Mar, -, 2023, 09:32:06, NOVI, PRIMANTARI, 101006028778, [, MCC, GARLIC, POWDER, 50G, ], 55,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>21000.0,
          :full_parsed_line=>"101044020902, [, PASEO, SF, PCK, M, 250S, ], 21,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>39093.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 39,093"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>47476.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 47,476"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>80000.0,
          :full_parsed_line=>"101005047739, [, INDONESSO, NES, BALI, KINTAMAN, I, 10S, ], 80,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33807.0, :full_parsed_line=>"101023011536, [, RED, RADISH, ], 33,807"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14080.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 14,080"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18500.0,
          :full_parsed_line=>"101023011375, [, MUSHROOM, CHAMPIGNON, ], 18.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>32760.0,
          :full_parsed_line=>"101024011675, [, MANGGA, BUDI, RAJA, KG, ], 32,760"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>35500.0,
          :full_parsed_line=>"101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, S, ], 35,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>31000.0,
          :full_parsed_line=>"101066012240, [, WHITE, SOUR, DOUGH, BRD, ], 31,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, S, ], 33,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>18000.0,
          :full_parsed_line=>"101013046422, [, KANZLER, SINGLES, MINI, 65GR, ], 18,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>19888.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000015011, Counter, :, C3, 02, -, Apr, -, 2023, 13:56:39, DEWA, AYU, KADE, S, UARNITI, ASIH, 101023011599, [, KYURI, ], 19,888"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>41002.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 41.002"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052323, [, HAPPY, DAY, FRUIT, JUICE, MANGO, DRINK, 1, LT, ], 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>22000.0,
          :full_parsed_line=>"101066012226, [, BATARD, BREAD, 300GR, ], 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>203688.0,
          :full_parsed_line=>"101022011336, [, SALMON, FILLET, KG, ], 203,688"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16643.0,
          :full_parsed_line=>"101023048966, [, BABY, GHERKIN, KG, ], 16,643"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>68000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 68,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>6400.0,
          :full_parsed_line=>"101002005481, (, DELFI, ZAP, CHOC, 421, 6,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, 33,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>79500.0,
          :full_parsed_line=>"101013044785, [, SMITHFIELD, OFF, THE, BONE, HAM, 100GR, ], 79,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>37807.0,
          :full_parsed_line=>"101021011225, [, AROMA, STREAKY, BACON, KG, ], 37,807"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>12090.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000023688, Counter, :, C2, 04, -, Apr, -, 2023, 14:37:16, ROSDIANTI, OKTAV, 101023011362, [, BABY, ROMANA, LETTUCE, ], 12,090"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72500.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>41000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 41,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>66000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>61800.0,
          :full_parsed_line=>"P, 101012008979, [, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 66,000 - 4,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>249000.0,
          :full_parsed_line=>"101011053207, [, PLM, ISOLA, BIANCO, 750ML, ), 249,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>109500.0,
          :full_parsed_line=>"101006038653, [, HEINZ, YELLOW, MUSTARD, 14OZ, ], 109.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>131000.0,
          :full_parsed_line=>"101007001697, [, FB, EXTRA, VIRGIN, 5001, 131,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0, :full_parsed_line=>"101066012348, [, CUP, CAKE, ], 30,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>16000.0,
          :full_parsed_line=>"101066012151, [, DONUT, SPRINKLE, ], 16,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>8000.0,
          :full_parsed_line=>"101066012153, [, DONUT, CHOCOLATE, !, 8,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>106000.0,
          :full_parsed_line=>"101012052206, [, 8, DEGREE, GREEK, FETTA, 200GR, ], 106,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>18500.0,
          :full_parsed_line=>"101043020495, [, MAMA, LEMON, DISHASH, PCH, 680, 18,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>45152.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, SC10000015822, Counter, :, C1, 10, -, Apr, -, 2023, 10:26:39, DEWA, AYU, KADE, S, UARNITI, ASIH, 101016010898, [, CHICKEN, BROILER, KG, ], 45,152"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>43741.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 43,741"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>45500.0,
          :full_parsed_line=>"101013009687, [, AROMA, PORK, COCKTAIL, 250GR, ], 45,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>78600.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 78.600"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>32000.0,
          :full_parsed_line=>"101043020770, (, BAGUS, SA, REFFIL, 4501, 32,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>36500.0,
          :full_parsed_line=>"101012009466, [, ARLA, CREAM, CHEESE, NATURAL, 1, 50GR, ], 36,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16606.0, :full_parsed_line=>"P, 101023011599, [, KYURI, ], 17,480 - 874"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>67500.0,
          :full_parsed_line=>"101012009257, [, ANCHOR, BUTTER, SALTED, PACK, 2, 67,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>76953.0,
          :full_parsed_line=>"101017010962, [, PRIME, BEEF, TOP, SIDE, ], 76,953"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>45274.0,
          :full_parsed_line=>"101021011198, [, AR, -, DANISH, HAM, WHOLE, KG, ], 45,274"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39500.0,
          :full_parsed_line=>"101012033844, [, ANCHOR, PROCESSED, CHEDDAR, 20, 39.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>23303.0,
          :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 24.530 - 1.227"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>27399.0,
          :full_parsed_line=>"P, 101023011536, RED, RADISH, ], 28,841 - 1.442"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>29536.0,
          :full_parsed_line=>"101016010916, [, MINCED, CHICKEN, KG, ], 29,536"},
         {:category_name=>"Лиля",
          :sub_category_name=>"Ванные принадлежности",
          :price=>6500.0,
          :full_parsed_line=>"101033017460, (, LAURIER, PL.N, PRF, 201, 6,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>21000.0,
          :full_parsed_line=>"101002007974, [, KIT, KAT, CO, 4F, /, 35, ], 21.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>32000.0,
          :full_parsed_line=>"101002005378, (, KINDER, BUENO, CHOCO, T, -, 21, 32,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>46500.0,
          :full_parsed_line=>"101002055349, [, MILKA, TENDER, DRK, MILK, CRML, ZEEZOUT, 85G1, 46,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>46500.0,
          :full_parsed_line=>"101002055351, [, MILKA, TENDER, ORK, MLK, PUUR, 8, 46.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>107000.0,
          :full_parsed_line=>"101002008149, [, M, &, M, MILK, CHOCOLATE, ], 107,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005779, [, LINDT, MILK, HZNUT100, ], 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>19118.0,
          :full_parsed_line=>"P, 101023011374, (, KALE, LOKAL, ], 20,124 - 1,006"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>249000.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000025971, Counter, :, C2, 13, -, Apr, -, 2023, 07:32:35, ROSDIANTI, OKTAV, 101011053211, [, PLM, ISOLA, ROSATO, 750ML, ], 249,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010001115, [, HAPPY, DAY, ORANGE, 1LT, ], 56,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>20000.0,
          :full_parsed_line=>"101044020912, [, PASEO, SOFTPACK, PURES, 130S, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44700.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, N05, 500, G, R, ], 44,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>22000.0,
          :full_parsed_line=>"101066012230, [, FRENCH, BREAD, 300GR, ], 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>80000.0,
          :full_parsed_line=>"101005047742, [, INDONESSO, NESPRESSO, PAPUA, W, AMENA, 10S, ], 80,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>6500.0,
          :full_parsed_line=>"101043041061, [, BAYCLIN, REGULAR, 200ML, ], 6,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>68000.0,
          :full_parsed_line=>"101012009247, [, ANCHOR, BUTTER, UNSALT, PACK22, 7GR, ], 68,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>29000.0,
          :full_parsed_line=>"101006045767, [, LEE, KUM, KEE, SOY, SAUCE, 250ML, 29,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>30900.0,
          :full_parsed_line=>"P, 101012008979, [, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 33,000 - 2,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44500.0,
          :full_parsed_line=>"101006006439, (, SAN, R, COUS, COUS, 500, ], 44,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44500.0,
          :full_parsed_line=>"101002054502, [, MILKA, WHITE, 100GR, ], 44,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44500.0,
          :full_parsed_line=>"101002054506, [, MILKA, CONFETTI, 100GR, ], 44,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>44500.0,
          :full_parsed_line=>"101002054497, [, MILKA, OREO, 100GR, ), 44,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>16000.0,
          :full_parsed_line=>"101066012151, [, DONUT, SPRINKLE, ], 16,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>8000.0,
          :full_parsed_line=>"101066012153, [, DONUT, CHOCOLATE, ], 8,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>27000.0,
          :full_parsed_line=>"101066012268, [, ALMOND, CROISSANT, ], 27,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>84500.0,
          :full_parsed_line=>"101013053701, [, UBUD, COLD, SMOKED, SALMON, CLA, SSIC, 100GR, ], 84,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>24000.0,
          :full_parsed_line=>"101012009324, [, TELUR, AYAM, NGRI, 10S, ], 24,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>71800.0,
          :full_parsed_line=>"101013041053, TRIPLE, THREE, STREAKY, BACON, 100GR, ], 71,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>14256.0,
          :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 15,840 - 1,584"}],
        1030156.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt pepito 57', freezed_time: '2023-04-18T01:52:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/pepito/out79.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>182600.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, :, 5C20000027210, Counter, :, C2, Bill, No, 18, -, Apr, -, 2023, 07:36:56, MIRA, YANI, 101007001657, [, GOLD, BRID, SUNFLOW, OJ, 182,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"[, HAPPY, DAY, STRAWBERRY, 1L, ], P, 101010000608, 56,500 - 8,600"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0, :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 78,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>41000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 41,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>41000.0,
          :full_parsed_line=>"101033014536, [, SENSODYNE, WHITENING, ], 41,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44500.0, :full_parsed_line=>"101002054497, [, MILKA, OREO, 100GR, ], 44,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>61000.0, :full_parsed_line=>"101002005406, [, LINDT, WHITE, CHOC100, ], 61,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>49500.0,
          :full_parsed_line=>"101013029639, [, MAMAS, STREAKY, BACON, SLC, 250, GR, ], 49,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>23500.0,
          :full_parsed_line=>"101013029632, [, MAMAS, GAMMON, HAM, 100GR, ], 23.500"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72500.0, :full_parsed_line=>"101003035550, THINS, CHICKEN, 175GR, ], 72,500"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>30000.0, :full_parsed_line=>"101066012244, [, FRENCH, VILLAGE, BREAD, ], 30,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>13800.0,
          :full_parsed_line=>"P, 101002008134, [, DELFI, CHACHA, CHOCO, MILK, 40G, R, ], 18,000 - 4,200"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0, :full_parsed_line=>"101002005202, (, KITKAT, CHUNKY, 38GR, ], 25.000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>17000.0,
          :full_parsed_line=>"[, ELLIPS, VIT, NUTRI, BLISTER, ], 17,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, :full_parsed_line=>"101066012150, [, DONUT, ICING, ], 8,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, :full_parsed_line=>"101066012151, [, DONUT, SPRINKLE, ], 8.000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, :full_parsed_line=>"101066012153, [, DONUT, CHOCOLATE, ], 8,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>38500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000032375, Counter, :, C2, 21, -, Apr, -, 2023, 08:53:09, LUH, TUTIK, ASRI, 101014009878, [, GOLDEN, FARM, GREEN, PEAS, 500G, R, ], 38,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>38993.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 43.326 - 4,333"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>41969.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 46,632 - 4,663"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>295901.0,
          :full_parsed_line=>"P, 101022011336, [, SALMON, FILLET, KG, ], 328,779 - 32,878"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>76248.0,
          :full_parsed_line=>"P, 101024011742, [, GRAPE, GREEN, SEEDLES, ], 84.720 - 8,472"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>54900.0,
          :full_parsed_line=>"1010340177821J, &, J, B.WASH, TIT, 500ML, ], 54,900"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>8000.0, :full_parsed_line=>"101066012157, [, DONUT, TRIPPLE, ], 8.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>24500.0,
          :full_parsed_line=>"101003044811, [, COVITA, HEALTHY, BAR, PNT, BTR, 40GR, ], 24,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>66000.0, :full_parsed_line=>"101002005779, (, LINDT, MILK, HZNUT100, ], 66,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42867.0, :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 47,630 - 4,763"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>44000.0, :full_parsed_line=>"101002054506, [, MILKA, CONFETTI, 100GR, ), 44,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>45800.0,
          :full_parsed_line=>"P, 101010000914, [, GREENFIELD, UHT, FULLCREAM, 1L, 50,000 - 4,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>52900.0,
          :full_parsed_line=>"P, 101012009491, [, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900 - 7,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>68000.0, :full_parsed_line=>"101002000021ILINDT, MRAISIN, NUT1001, 68.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>115551.0,
          :full_parsed_line=>"P, 101024040681, [, PLUM, RED, AUST, KG, ], 128.390 - 12,839"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>18000.0,
          :full_parsed_line=>"101013046422, (, KANZLER, SINGLES, MINI, 65GR, ), 18.000"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>72000.0, :full_parsed_line=>"101003035550, (, THINS, CHICKEN, 175GR, ], 72.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>48000.0,
          :full_parsed_line=>"101012009296, (, ANCHOR, WHIPPING, CREAM, 250ML, 48,000"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>144000.0, :full_parsed_line=>"101012009325, TELUR, OMEGA, 3, 10S1, 144.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>71800.0,
          :full_parsed_line=>"101013041053, TRIPLE, THREE, STREAKY, BACON, 100GR, ], 71.800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>86240.0,
          :full_parsed_line=>"101021011263, (, SMOKED, TURKEY, BREAST, KG, ], 86.240"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>36261.0, :full_parsed_line=>"P, 101016010903, [, CHICKEN, WING, KG, ], 40.290 - 4.029"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16650.0,
          :full_parsed_line=>"P, 101023011375, (, MUSHROOM, CHAMPIGNON, 18.500, !, 18,500 - 1.850"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11952.0, :full_parsed_line=>"P, 1010230116221PAPRIKA, HIJAU, ], 13.280 - 1.328"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>24775.0,
          :full_parsed_line=>"P, 101023011586, (, ASPARAGUS, LOKAL, SPRI, 27.528 - 2.753"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>41051.0,
          :full_parsed_line=>"P, 101023011627, (, BEEF, TOMATO, PED, KG, ], 45.612 - 4.561"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>24000.0, :full_parsed_line=>"101066049563, (, CINAMON, ROLL, ., DANISH, ], 24,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>9191.0,
          :full_parsed_line=>"P, 101024011676, (, PEPAYA, CALINA, KG, ], 10,212 - 1,021"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8070.0, :full_parsed_line=>"101023011351, [, KAILAN, ], 8.967 - 897"}],
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
      expect(result).to eq(
        [[{:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>122000.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000030907, Counter, :, C2, 02, -, May, -, 2023, 07:29:52, YENI, ASTARI, 101034017883, [, SWEETY, PANT, R.GL, LI, 122.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>65843.0,
          :full_parsed_line=>"P, 101024011692, [, SEMANGKA, MERAH, NB, KG, ], 73,159 - 7,316"},
         {:category_name=>nil, :sub_category_name=>nil, :price=>67500.0, :full_parsed_line=>"-, 101012009535, [, JUNGLE, JC, APL, 2000ML, ], 67,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>28350.0,
          :full_parsed_line=>"P, 101024011715, [, STRAWBERRY, 250GR, ], 31,500 - 3,150"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, CANGGU, Jl, ., Raya, Canggu, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000027641, Counter, :, C3, 03, -, May, -, 2023, 15:41:56, FITRI, INDAH, SAR, 101002005406, [, LINDT, WHITE, CHOC100, ], 60,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15500.0, :full_parsed_line=>"101002005436, [, DF, CASHEW, 50GR, ], 15,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>136000.0, :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ], 136,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60000.0, :full_parsed_line=>"101066051212, [, BAME, TARO, CAKE, ], 60,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>200000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000020782, Counter, :, C3, 08, -, May, -, 2023, 08:38:22, NOVI, PRIMANTARI, 101011054591, [, ISPN, PLAGA, ROSE, 750MLJ, 200,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>44445.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 49.383 - 4,938"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>40846.0,
          :full_parsed_line=>"P, 101016010898, [, CHICKEN, BROILER, KG, ], 45.384 - 4.538"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>41897.0, :full_parsed_line=>"P, 101016010903, [, CHICKEN, WING, KG, ], 46.552 - 4.655"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>29500.0,
          :full_parsed_line=>"101006006196, [, AYM, BRAND, WHL, MUSHROOM, 420G, R, ], 29,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>9500.0,
          :full_parsed_line=>"101007001434, [, DOLPHIN, GARAM, 200GR, ], 9,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>32500.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 32,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>91000.0, :full_parsed_line=>"101006003203, [, MC, C, PAPRIKA, SMKD, 371, 91,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>84000.0,
          :full_parsed_line=>"101013053704, [, UBUD, GRAVAD, LAX, CLASSIC, 100, GR, ], 84,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>49032.0,
          :full_parsed_line=>"P, 101024040681, [, PLUM, RED, AUST, KG, ], 54,480 - 5,448"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>179500.0,
          :full_parsed_line=>"101013009706DJV, SMOKED, BR, SAUSAGE, 396GRI, 179.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>20147.0,
          :full_parsed_line=>"P, 101024011693, [, SEMANGKA, KUNING, NB, KGJ, 22.386 - 2,239"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>25500.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000032873, Counter, :, C2, 09, -, May, -, 2023, 14:50:21, YENI, ASTARI, 101011040546, [, BINTANG, CRYSTAL, PINT, 330ML, ), 25,500"},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>47000.0, :full_parsed_line=>"101011000333, [, BINTANG, BTL, PINT, 330ML, ], 47,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, :full_parsed_line=>"101012009125, (, GREENFIELDS, YOG, STRAW, 125GR, 15,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, :full_parsed_line=>"101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>15500.0,
          :full_parsed_line=>"101012009124, [, GREENFIELDS, YOG, BLUEBERRY, 1, 25GR, ], 15,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>4955.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000033977, Counter, :, C2, 14, -, May, -, 2023, 10:50:15, YENI, ASTARI, 101023011604, [, TIMUN, ACAR, BANDUNG, ], 4,955"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>26000.0, :full_parsed_line=>"101010000914, [, GREENFIELD, UHT, FULLCREAM, 1L, 26,000"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"101010001096, [, HAPPY, DAY, APPLE, 1LT, ], 56,500"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ], 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>67500.0,
          :full_parsed_line=>"101012056179, [, ANCHOR, BUTTER, UNSALTED, PACK, 200GR, ], 67,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78600.0, :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 78,600"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>21000.0, :full_parsed_line=>"101002007974, [, KIT, KAT, CO, 4F, /, 35, ], 21,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, :full_parsed_line=>"101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>15500.0, :full_parsed_line=>"101012009125, [, GREENFIELDS, YOG, STRAW, 125GR, 15,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, S, ], 33,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0, :full_parsed_line=>"101066012153, [, DONUT, CHOCOLATE, ], 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>16000.0, :full_parsed_line=>"101066012151, [, DONUT, SPRINKLE, ], 16.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>13500.0,
          :full_parsed_line=>"101002055291, [, KIT, KAT, CHUNKY, RAISIN, &, CKIES, 38G, ], 13,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>33000.0,
          :full_parsed_line=>"101013029635, [, MAMAS, SALAMI, MILANO, 100GR, ], 33,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>22000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5010000022185, Counter, :, C1, 15, -, May, -, 2023, 14:16:44, NI, MADE, SARI, AS, 101066012226, (, BATARD, BREAD, 300GR, ], 22,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>74347.0, :full_parsed_line=>"P, 101023011536, (, RED, RADISH, ], 78,260 - 3.913"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27398.0, :full_parsed_line=>"P, 101023011534, [, KENTANG, BESAR, ], 28.840 - 1.442"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0, :full_parsed_line=>"101002005401, [, TOBL, CHO, MILK, 100GR, ), 48.000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>60500.0, :full_parsed_line=>"101002005406, (, LINDT, WHITE, CHOC100, ], 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>44700.0,
          :full_parsed_line=>"101006006370, [, BARILLA, SPAGHETTI, N05, 500, G, R, ], 44.700"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0, :full_parsed_line=>"101002039798, (, DELFI, BAR, BAR, 18GR, ], 10.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 40,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>27500.0, :full_parsed_line=>"101002008182, [, LINDT, EXC, DRK, 35GR, ], 27,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>28508.0, :full_parsed_line=>"P, 101023011586LASPARAGUS, LOKAL, SPR, ], 30.008 - 1,500"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25875.0, :full_parsed_line=>"101016010910, (, CHICKEN, BOTTOM, LEGI, 25,875"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>69616.0,
          :full_parsed_line=>"P, 101024011742, [, GRAPE, GREEN, SEEDLES, ], 73.280 - 3.664"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>86040.0, :full_parsed_line=>"1010220112700TUNA, STEAK, FRESH, !, 86,040"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>35000.0,
          :full_parsed_line=>"101012008979, (, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 35,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>9000.0,
          :full_parsed_line=>"101002008134, [, DELFI, CHACHA, CHOCO, MILK, 40G, R, ], 9.000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"101002008133, [, DELFI, CHACHA, PEANUT, 40GR, ], 9,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49700.0, :full_parsed_line=>"101012009283, [, YUMMY, RICOTTA, 250GR, ], 49.700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>33488.0,
          :full_parsed_line=>"101021011202, (, AR, SMK, COOKED, HAM, KG, ], 33,488"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25600.0, :full_parsed_line=>"101002005481, (, DELFI, ZAP, CHOC, 421, 25.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>25000.0,
          :full_parsed_line=>"101012009166, (, HEAVENLY, BLUSH, YOG, PEACH, 10, OGR, ], 25.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>25000.0,
          :full_parsed_line=>"101012009165, (, HEAVENLY, BLUSH, YOG, STRAWBE, 100GR, ], 25.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>52900.0,
          :full_parsed_line=>"101012009443, (, BABYBEL, MINI, CHEESE, CHEDDAR, 5, $, 1, 52.900"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39300.0, :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR1, 39,300"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46816.0, :full_parsed_line=>"P, 101023034624, [, BABY, KYURI, KG, ], 49,280 - 2,464"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>26000.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000034572, Counter, :, C2, 16, -, May, -, 2023, 16:07:35, ROSDIANTI, OKTAV, 101006006060, [, NOX, BKNG, PWD, 175G, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72500.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>4900.0,
          :full_parsed_line=>"101006006032, [, KP2U, SODA, KUE, 81GR, ], 4,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7700.0,
          :full_parsed_line=>"101002000018, [, DF, CHACHA, MINIS, HATS, 30GR, ], 7,700"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>179000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5010000022864, Counter, :, C1, 19, -, May, -, 2023, 09:04:32, DEWA, AYU, KADE, S, UARNITI, ASIH, 101011008650, [, HW, HATTEN, SWEET, ALEXANDRIA, 750ML, ), 179,000"},
         {:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>121500.0,
          :full_parsed_line=>"1010340178831SWEETY, PANT, R.GL, LI, 121.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GRI, 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>275643.0,
          :full_parsed_line=>"101022011336, (, SALMON, FILLET, KG, ], 275.643"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>49290.0, :full_parsed_line=>"101016010898, CHICKEN, BROILER, KG, ], 49,290"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, I, 56.500 - 8,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>35500.0,
          :full_parsed_line=>"101023011384, [, GOLDEN, LEAF, WILD, RUCOLLA, PC, 35.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>55094.0,
          :full_parsed_line=>"101024011692, [, SEMANGKA, MERAH, NB, KG, ], 55,094"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18500.0,
          :full_parsed_line=>"101023011375, (, MUSHROOM, CHAMPIGNON, ], 18.500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>29500.0,
          :full_parsed_line=>"101033014588, [, DARLIE, ASH, L.MINT, 140GR, ], 29,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72000.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>16000.0,
          :full_parsed_line=>"101043020770, [, BAGUS, SA, REFFIL, 450, ], 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14850.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 14.850"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>72176.0, :full_parsed_line=>"101023011536, [, RED, RADISH, ], 72,176"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>60452.0, :full_parsed_line=>"101024056317, [, PLUM, RUBY, RED, ], 60,452"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>66500.0,
          :full_parsed_line=>"101024011772, (, BLUEBERRIES, 125GR, ], 66,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>41700.0,
          :full_parsed_line=>"P, 101012009125, (, GREENFIELDS, YOG, STRAW, 125GR, 46,500 - 4,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>27800.0,
          :full_parsed_line=>"P, P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 31,000 - 3,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>28938.0,
          :full_parsed_line=>"101021011225, (, AROMA, STREAKY, BACON, KG, ], 28.938"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>17000.0,
          :full_parsed_line=>"P, 101013053026, [, SO, NICE, SOSIS, PREMIUM, ORIGI, NAL, 60, GR, ], 17,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000022823, Counter, :, C3, 21, -, May, -, 2023, 14:51:10, KSR, PUTRI, AISAH, P, 101010001096, [, HAPPY, DAY, APPLE, 1LT, ], 56.500 - 8,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005410, [, L, INDT, WHOLEALMON1001, 66.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>53000.0,
          :full_parsed_line=>"101002008181, [, LINDT, EXC, CRM, 35GR, ], 53,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010052323, [, HAPPY, DAY, FRUIT, JUICE, MANGO, DRINK, 1, LT, ], 56,500 - 8,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>5900.0,
          :full_parsed_line=>"P, 101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ], 7,700 - 1,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009125, [, GREENFIELDS, YOG, STRAW, 125GR, 15,500 - 1.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>51528.0,
          :full_parsed_line=>"101017010962, [, PRIME, BEEF, TOP, SIDE, ], 51,528"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>48000.0,
          :full_parsed_line=>"101002005401, (, TOBL, CHO, MILK, 100GR, ], 48,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>78600.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 78,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"a, 101012009030, [, GREENFIELDS, YOG, PLAIN, 125GR, 15,500 - 1.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>119800.0,
          :full_parsed_line=>"P, 101012009421, [, LURPAK, SALT, BUTTER, 82, %, 200G, 132,800 - 13.000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16360.0, :full_parsed_line=>"101023011533, [, KENTANG, BABY, ], 16.360"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>31600.0,
          :full_parsed_line=>"P, 101002007974, [, KIT, KAT, CO, 4F, /, 35, ], 42,000 - 10,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>72000.0,
          :full_parsed_line=>"101012054382, [, MILK, UP, COTTAGE, CHEESE, 250G, R, ], 72,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>171700.0, :full_parsed_line=>"101024011780, [, CHERRIES, KG, ], 171.700"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4928.0, :full_parsed_line=>"101023011545, (, BAWANG, PUTIH, KG, ], 4,928"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>33000.0,
          :full_parsed_line=>"101012009323, [, TELUR, AYAM, NEGERI, ORANGE, 10, 33,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18542.0, :full_parsed_line=>"101023011657, [, PARSLEY, ], 18.542"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>48000.0, :full_parsed_line=>"101023011656, (, DAUN, DIIL, ], 48,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72000.0,
          :full_parsed_line=>"101003035550, (, THINS, CHICKEN, 175GR, ], 72,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000040909, Counter, :, C2, 23, -, May, -, 2023, 14:03:36, KSR, DWI, SAPTA, P, 101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, ], 56,500 - 8.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>22500.0,
          :full_parsed_line=>"101043020197, [, PROC, WHT, CRTL, BTL4001, 22,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010052320, [, HAPPY, DAY, FRUIT, JUICE, PINEA, PPLE, COCO, JI, 56,500 - 8,600"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>62000.0,
          :full_parsed_line=>"101044020977, [, KLINPAK, K, SAMPAH, M12, ], 62,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>29000.0,
          :full_parsed_line=>"101043020462, [, LMNPLADGE, LIQ, SPR400, ], 29,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>15666.0,
          :full_parsed_line=>"P, 101016010915, [, CHICKEN, GIZZARD, KG, ], 16,491 - 825"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>20853.0,
          :full_parsed_line=>"P, 101016010903, [, CHICKEN, WING, KG, ], 21,951 - 1,098"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8560.0, :full_parsed_line=>"101023011544, [, BAWANG, BOMBAY, ], 8,560"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72000.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13230.0, :full_parsed_line=>"101023011596, (, SAWI, PUTIH, ], 13,230"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>163000.0,
          :full_parsed_line=>"101012009427, [, PAYSAN, BRETON, EMMENTAL, 250G, R, ], 163,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009125, (, GREENFIELDS, YOG, STRAW, 125GR, 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>64900.0,
          :full_parsed_line=>"101014009948, [, IOF, MIXED, BERRIES, 300GR, ], 64.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>7900.0,
          :full_parsed_line=>"P, 101012043578, [, GREENFIELDS, KDS, PCH, RASP, N, LYCHEE, 110G, ], 9,000 - 1,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>7900.0,
          :full_parsed_line=>"P, 101012034578, [, GREENFIELDS, KDS, PCH, STRAWBE, RRY, 110GR, ], 9,000 - 1,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>7900.0,
          :full_parsed_line=>"P, 101012043577, [, GREENFIELDS, KDS, PCH, MANGO, N, PEACH, 110G, ], 9,000 - 1,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500 - 1.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>30500.0,
          :full_parsed_line=>"101006000223, (, JAYS, BLACK, PAPPER, GI, 30,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>54040.0,
          :full_parsed_line=>"101024011675, (, MANGGA, BUDI, RATA, KG, ], 54,040"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>6734.0, :full_parsed_line=>"101023011591, [, BUNCIS, ], 6,734"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16600.0, :full_parsed_line=>"101023011599, (, KYURI, ], 16.600"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23920.0, :full_parsed_line=>"101023011626, (, BABY, ASPARAGUS, ], 23,920"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>40500.0,
          :full_parsed_line=>"101014009817, [, MISSION, TORTILLA, F.81, 40,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>10000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, PT, Sentral, Retailindo, Dewatal, Item, Sales, Bill, No, :, 5010000023949, Counter, :, C1, 26, -, May, -, 2023, 08:47:56, KSR, DHI, SAPTA, 101051022861, [, PEPITO, BAG, MI, 10,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>9500.0,
          :full_parsed_line=>"101003008010, [, OREO, MINI, VANILA, CUP, ), 9.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>60500.0,
          :full_parsed_line=>"101005045288, (, QUAKER, OAT, WHOLE, ROLLED, 80, OGR, ], 60.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, (, MS, MAYONAISE, 300GR, ), 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>89000.0,
          :full_parsed_line=>"101005003790, TS, HONEY, 350M, ., ), 89.000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>54900.0,
          :full_parsed_line=>"10103401778211, &, J, B.WASH, TIT, 500ML, ., ], 54,900"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>44500.0,
          :full_parsed_line=>"101033016539, [, DETTOL, HH, SENSI, PUMP245M, ], 44.500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>44500.0,
          :full_parsed_line=>"101033016540, (, DETTOL, HW, HENERGIS245M, ., ), 44.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010001096, (, HAPPY, DAY, APPLE, ILTI, 56.500 - 8.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>29900.0,
          :full_parsed_line=>"P, 1010120089791GREENFIELDS, FRESH, MILK, FULL, CREAM, ILT, ], 35.000 - 5,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 1010100523231HAPPY, DAY, FRUIT, JUICE, MANGO, DRINK, 1, LT, ], 56.500 - 8,600"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>18500.0,
          :full_parsed_line=>"101033017507, [, MITU, BABY, WIPES, F, &, C, PINK, CH, ERRY, 40S, ], 18.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>21000.0,
          :full_parsed_line=>"101006036766, [, INDOMILK, SKM, PLAIN, 545GR, 21.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>127000.0,
          :full_parsed_line=>"101015009983, (, MAGNUM, MINI, ALMOND, 6X45ML, ], 127.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>42000.0,
          :full_parsed_line=>"101015009997, (, MAGNUM, WHITE, ALMOND, 80M, ., ), 42.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>39300.0,
          :full_parsed_line=>"1010120092821YUMMY, SOUR, CREAM, 200GR, ], 39,300"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>14900.0,
          :full_parsed_line=>"101012009056, (, YUMMY, YOG, RASPBERRY, 100GRI, 14.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>"101002005406ILINDT, WHITE, CHOC100, ), 60.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>136000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT1001, 136.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>9500.0,
          :full_parsed_line=>"101043020496, (, MAMA, LEMON, DISHASHER, 400MLJ, 9.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>76400.0,
          :full_parsed_line=>"(, TRIPLE, THREE, HONEY, BAKED, HA, M, 100GR, ), 76.400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>34875.0,
          :full_parsed_line=>"101021011224, (, AROMA, BACK, BACON, KG, ), 34.875"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>59900.0,
          :full_parsed_line=>"P, 101012009421, (, LUPPAK, SALT, BUTTER, 82, %, 200G, R, ], 66,400 - 6.500"},
         {:category_name=>nil, :sub_category_name=>nil, :price=>59850.0, :full_parsed_line=>"(, 125GR, ), 66,500 - 6.650"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>20000.0,
          :full_parsed_line=>"101003007431, (, YAVA, ROASTED, CASHEW, 35GR, ], 20.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>31000.0,
          :full_parsed_line=>"1010660122401WHITE, SOUR, DOUGH, BADI, 31.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>28350.0,
          :full_parsed_line=>"P, 101024011715, (, STRAWBERRY, 250GR, ], 31,500 - 3.150"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18000.0,
          :full_parsed_line=>"P, 1010230116430TOMAT, CHERRY, HOR, ], 20.000 - 2.000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>14900.0, :full_parsed_line=>"(, YUMMY, YOG, PEACH, 100GR, ), 14.900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, (, GREENFIELDS, YOG, BLUEBERRY, 1, 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009125, (, GREENFIELDS, YOG, STRAH, 125GR, 15,500 - 1.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"(, GREENFIELDS, YOG, MANGO, 125GR, 15.500 - 1.600"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12969.0, :full_parsed_line=>"P, (, BABY, KYURI, KG, ], 14,410 - 1,441"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>26000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5010000026049, Counter, :, C1, 06, -, Jun, -, 2023, 09:52:08, NENGAH, MURTINI, 101010000803, [, HYDRO, COCO, ORI, 1LTR, ], 26,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>41700.0, :full_parsed_line=>"101024011712INANAS, HONI, MEDIUM, ], 41,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052323, [, HAPPY, DAY, FRUIT, JUICE, MANGO, DRINK, 1, LT, ], 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>32900.0,
          :full_parsed_line=>"P, 101012008979, [, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 35,000 - 2,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>73500.0,
          :full_parsed_line=>"101012054384, [, MILK, UP, SOUR, CREAM, 25, %, 330M, 73,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>40000.0,
          :full_parsed_line=>"101012054387, [, MILK, UP, KEFIR, 350ML, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>12700.0,
          :full_parsed_line=>"101023052101, [, MUSHROOM, KANCING, BELAH, PCS, ], 12,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>66400.0,
          :full_parsed_line=>"101012009421, [, LURPAK, SALT, BUTTER, 82, %, 200G, R, ], 66,400"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33156.0, :full_parsed_line=>"101023011534, [, KENTANG, BESAR, ], 33,156"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>9876.0,
          :full_parsed_line=>"P, 101016010905, [, CHICKEN, LEG, /, PAHA, KG, ], 10.396 - 520"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>54000.0,
          :full_parsed_line=>"101012009434, [, ARLA, KIDS, STICKS, 6X18GR, ], 54,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>163000.0,
          :full_parsed_line=>"101012009427, [, PAYSAN, BRETON, EMMENTAL, 250G, R, ], 163,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>84000.0,
          :full_parsed_line=>"101012033668, [, ARLA, HAVARTI, CHEESE, 150GR, ], 84.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>45089.0,
          :full_parsed_line=>"101023030120, [, PLAGA, F, CELERY, STICK, LOKAL, ], 45.089"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21093.0, :full_parsed_line=>"101023048966IBABY, GHERKIN, KG, ], 21,093"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>71000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, PERERENAN, Jl, ., By, Pass, Munggu, -, Pererenan, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000043279, Counter, :, C2, 11, -, Jun, -, 2023, 17:27:24, MEIRA, SETIADEWI, 101005003928, [, YAVA, GRANOLLA, COCONUT, BANAN, A, 400GR, ], 71,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>88500.0,
          :full_parsed_line=>"101003007411, [, TG, SALTED, PISTAC, 150GR, ], 88,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>13000.0,
          :full_parsed_line=>"101003007689, [, PRINGLES, SOUR, &, CREAM, 42GR, ], 13,000"},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>10000.0, :full_parsed_line=>"101051022861, [, PEPITO, BAG, MI, 10,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>78600.0,
          :full_parsed_line=>"101012009282, [, YUMMY, SOUR, CREAM, 200GR, ], 78,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>85050.0,
          :full_parsed_line=>"101024011742, [, GRAPE, GREEN, SEEDLES, ], 85,050"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>59880.0,
          :full_parsed_line=>"101024011734, [, APEL, GRANY, SMITH, KG, ], 59,880"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>26500.0,
          :full_parsed_line=>"101006003395, (, SUNBELL, CHUNKS, OIL, 1, ], 26,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>13000.0,
          :full_parsed_line=>"101003041480, [, PRINGLES, CHEESY, CHEESE, 42GR, 13,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009030, [, GREENFIELDS, YOG, PLAIN, 125GR, 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>73500.0,
          :full_parsed_line=>"101012054384, [, MILK, UP, SOUR, CREAM, 25, %, 330M, L, ], 73,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>45000.0,
          :full_parsed_line=>"101012009312, TELUR, OMEGA, 3, 10S, AA, ], 45,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009125, [, GREENFIELDS, YOG, STRAW, 125GR, 15.500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009124, [, GREENFIELDS, YOG, BLUEBERRY, 1, 25GR, ], 15.500 - 1.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>14500.0,
          :full_parsed_line=>"101002008151, (, KINDER, JOY, NATOONS, 20GR, ], 14,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>14500.0,
          :full_parsed_line=>"101002008204, [, KINDER, JOY, BOY, 20GR, ], 14,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>72000.0,
          :full_parsed_line=>"101012054382, [, MILK, UP, COTTAGE, CHEESE, 250G, R, ], 72,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>59300.0,
          :full_parsed_line=>"101002034265, [, THE, BELGIAN, WHITE, 100GR, ], 59,300"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000025157, Counter, :, C3, 08, -, Jun, -, 2023, 17:40:24, DEWA, AYU, KADE, S, UARNITI, ASIH, 101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ], 56,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224, [, TRADITIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>32900.0,
          :full_parsed_line=>"P, 101012008979, [, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 35,000 - 2,100"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>36696.0, :full_parsed_line=>"101023011536, [, RED, RADISH, ], 36,696"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72000.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>13000.0,
          :full_parsed_line=>"101003054190, [, NORIGO, NORI, CRISPY, BBQ, 20GR, 13,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>16000.0,
          :full_parsed_line=>"101002005378, [, KINDER, BUENO, CHOCO, T, -, 21, 16,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>31000.0,
          :full_parsed_line=>"101002007975, (, KIT, KAT, C2F, /, 1021, 31,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>64500.0,
          :full_parsed_line=>"101012054381, [, MILK, UP, COCONUT, YOGURT, 330M, L, ], 64,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20240.0, :full_parsed_line=>"101023034624, [, BABY, KYURI, KG, ], 20,240"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>"101002005406, [, LINDT, WHITE, CHOC100, ], 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>19500.0,
          :full_parsed_line=>"101002008384, [, HRB, G, BEARS, 80GR, ], 19,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>27800.0,
          :full_parsed_line=>"P, 101012009125, [, GREENFIELDS, YOG, STRAW, 125GR, 31.000 - 3,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>27800.0,
          :full_parsed_line=>"P, 101012009124, [, GREENFIELDS, YOG, BLUEBERRY, 1, 25GR, ], 31,000 - 3,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500 - 1.600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>66000.0,
          :full_parsed_line=>"101002005779, [, LINDT, MILK, HZNUT100, ], 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>20000.0,
          :full_parsed_line=>"101003007431, [, YAVA, ROASTED, CASHEW, 35GR, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>72000.0,
          :full_parsed_line=>"101012054382, (, MILK, UP, COTTAGE, CHEESE, 250G, R, ], 72,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>21000.0,
          :full_parsed_line=>"101002007974, [, KIT, KAT, CO, 4F, /, 35, ], 21,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>267500.0,
          :full_parsed_line=>"101002053131, [, SNICKERS, CHOCOLATE, 1.86OZ, ], 267,500"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>32900.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C10000012352, Counter, :, C1, 15, -, Jun, -, 2023, 15:55:55, NI, KADEK, DEVI, PITRIYA, P, 101012008979, [, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 35,000 - 2,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>319000.0,
          :full_parsed_line=>"101011008649, [, HW, HATTEN, AGA, WHITE, 2LT, ], 319,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010000608, [, HAPPY, DAY, STRAWBERRY, 1L, ], 56,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>30100.0,
          :full_parsed_line=>"101040019172, [, TUSUK, GIGI, NAOMI, ], 30,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72500.0,
          :full_parsed_line=>"101003035550, [, THINS, CHICKEN, 175GR, ], 72,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011646, [, F, TOMAT, CHERY, RED, PC, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>27800.0,
          :full_parsed_line=>"P, 101012009125, [, GREENFIELDS, YOG, STRAW, 125GR, ], 31,000 - 3,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>27800.0,
          :full_parsed_line=>"P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, ], 31,000 - 3,200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009124, [, GREENFIELDS, YOG, BLUEBERRY, 125GR, ], 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>61000.0,
          :full_parsed_line=>"101002005406, [, LINDT, WHITE, CHOC100, ], 61,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>12000.0,
          :full_parsed_line=>"101044056626, [, SON, LIN, ANGKA, EMAS, 3, ], 12,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7700.0,
          :full_parsed_line=>"101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ], 7,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>2500.0,
          :full_parsed_line=>"101002039798, [, DELFI, BAR, BAR, 18GR, ], 2,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>31500.0,
          :full_parsed_line=>"101002007975, [, KIT, KAT, C2F, /, 102, ], 31,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>2500.0,
          :full_parsed_line=>"101003033325, [, DILAN, CRUNCH, CHOC, CRAL, 24GR, ], 2,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>33000.0,
          :full_parsed_line=>"101043020770, [, BAGUS, SA, REFFIL, 450, ], 33,000"}],
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
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>33000.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000047335, Counter, :, C2, 19, -, Jun, -, 2023, 12:25:06, NENGAH, MURTINI, 101044020918, [, PASEO, SP, ULTRS, 100S, ], 33.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>56500.0,
          :full_parsed_line=>"101010052323, [, HAPPY, DAY, FRUIT, JUICE, MANGO, DRINK, 1, LT, ], 56.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>40000.0,
          :full_parsed_line=>"101006001871, [, MS, MAYONAISE, 300GR, ], 40,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>60500.0,
          :full_parsed_line=>"101002005406, [, LINDT, WHITE, CHOC1001, 60,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>68000.0,
          :full_parsed_line=>"101002000021, [, LINDT, MRAISIN, NUT100, ), 68,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>88500.0,
          :full_parsed_line=>"101003007411, [, TG, SALTED, PISTAC, 150GR, ], 88,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>31280.0,
          :full_parsed_line=>"101021011202, [, AR, SMK, COOKED, HAM, KG, ], 31,280"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>34500.0,
          :full_parsed_line=>"101021011224, [, AROMA, BACK, BACON, KG, ], 34.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>85500.0,
          :full_parsed_line=>"101012033669, (, ARLA, GOUDA, CHEESE, 150GR, ], 85,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>168000.0,
          :full_parsed_line=>"101012033668, [, ARLA, HAVARTI, CHEESE, 150GR, ], 168,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>73500.0,
          :full_parsed_line=>"101012054384IMILK, UP, SOUR, CREAM, 25, %, 330M, L., ], 73,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>23004.0,
          :full_parsed_line=>"P, 101024011692, SEMANGKA, MERAH, NB, KG, ], 24,215 - 1.211"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>9473.0,
          :full_parsed_line=>"P, 101023011596, [, SAWI, PUTIH, ], 9,972 - 499"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>16538.0,
          :full_parsed_line=>"P, 101023011656, [, DAUN, DIIL, ], 17,408 - 870"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20487.0,
          :full_parsed_line=>"P, 101023011657, [, PARSLEY, ], 21,565 - 1.078"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>132800.0,
          :full_parsed_line=>"101012009421, LLURPAK, SALT, BUTTER, 82, %, 2006, R, ], 132,800"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>292000.0,
          :full_parsed_line=>"101002055840, (, SNICKERS, CHOCOLATE, 3.29OZI, 292,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7500.0,
          :full_parsed_line=>"101003033325, (, DILAN, CRUNCH, CHOC, CRAL, 24GR, 7,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>7700.0,
          :full_parsed_line=>"101002005702, [, DF, CHACHA, MINIS, TUBE, 30GR, ], 7,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>13300.0,
          :full_parsed_line=>"P, 101023011497, [, GL, ROCOLA, LETTUCE, ], 14,000 - 700"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>72000.0,
          :full_parsed_line=>"101003035550, (, THINS, CHICKEN, 175GR, ], 72.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>26000.0,
          :full_parsed_line=>"101066012224L, TRADITIONAL, TOAST, ], 26,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>18601.0,
          :full_parsed_line=>"P, 101023048966, [, BABY, GHERKIN, KG, ], 19,580 - 979"}],
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
      expect(result).to eq(
        [[{:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>122000.0,
          :full_parsed_line=>
           "PEPITO, EXPRESS, UMALAS, Jl, ., Dukuh, Indah, 56, Umalas, NPWP, :, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000044361, Counter, :, C2, 28, -, Jun, -, 2023, 08:30:11, NI, KADEK, DEVI, P, 101034017883, [, SWEETY, PANT, R.GL, L, ], 122,000"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>16400.0,
          :full_parsed_line=>"101043053325, [, SUNLIGHT, LIME, ECT, POUCH, 650, ML, ], 16,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>3500.0,
          :full_parsed_line=>"101002008424, [, BIG, BABOL, STK, STRAWB, ], 3,500"}],
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

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Хлеб и др",
          :price=>71700.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, Badung, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C20000050062, Counter, :, C2, 01, -, Jul, -, 2023, 10:39:27, HEROLINA, AGUSTI, 101014009825, (, MISSION, TORTILLA, 101, 71,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>48000.0,
          :full_parsed_line=>"1010020D5401ITOEL, CHO, MILK, TOUGRI, 48.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>19500.0,
          :full_parsed_line=>"101006003317, (, JAYS, BAY, LEAVES, 8GR, ], 19,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>52400.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 52,400"},
         {:category_name=>"Еда",
          :sub_category_name=>"Мясо",
          :price=>51500.0,
          :full_parsed_line=>"101016010898, [, CHICKEN, BROILER, KG, ], 51,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>107000.0,
          :full_parsed_line=>"101002008149, [, M, &, M, MILK, CHOCOLATE, ], 107.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>267500.0,
          :full_parsed_line=>"101002053131, (, SNICKERS, CHOCOLATE, 1.86OZ, ), 267,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>121000.0,
          :full_parsed_line=>"101002005406, [, LINDT, WHITE, CHOC1001, 121,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>19000.0,
          :full_parsed_line=>"101012009187, (, BIOKUL, GREEK, YOGURT, BLUEBER, RY, 80GR, ], 19,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>78600.0,
          :full_parsed_line=>"101012009282, (, YUMMY, SOUR, CREAM, 200GR, ], 78,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>49700.0,
          :full_parsed_line=>"101012009283, (, YUMMY, RICOTTA, 250GR1, 49,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009124, [, GREENFIELDS, YOG, BLUEBERRY, 1, 25GR, ], 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>32900.0,
          :full_parsed_line=>"P, 101012008979, [, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 35,000 - 2,100"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>21000.0,
          :full_parsed_line=>"101013029625, (, MAMAS, DANISH, HAM, SLICE, 100G, R, ], 21,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>49125.0,
          :full_parsed_line=>"101021011224, [, AROMA, BACK, BACON, KG, ], 49,125"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>59900.0,
          :full_parsed_line=>"101012009491, [, LAUGHING, COW, CHEEZ, DIPPERS, 140GR, ], 59,900"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>185000.0,
          :full_parsed_line=>"101012033668, [, ARLA, HAVARTI, CHEESE, 150GR, ), 185,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Вода",
          :price=>47900.0,
          :full_parsed_line=>"P, 101010052322, [, HAPPY, DAY, FRUIT, JUICE, RASPB, ERRY, APPLE, J, 56,500 - 8,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009125, (, GREENFIELDS, YOG, STRAW, 125GR, 15.500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>13900.0,
          :full_parsed_line=>"P, 101012009126, [, GREENFIELDS, YOG, MANGO, 125GR, 15,500 - 1,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>19000.0,
          :full_parsed_line=>"101012009189, (, BIOKUL, GREEK, STRAW, 80GR, ], 19.000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>26500.0,
          :full_parsed_line=>"101006003395, [, SUNBELL, CHUNKS, OIL, 11, 26.500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19936.0, :full_parsed_line=>"1010230489661BABY, GHERKIN, KG, ), 19,936"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>83168.0,
          :full_parsed_line=>"101024011742, (, GRAPE, GREEN, SEEDLES, ], 83,168"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27336.0, :full_parsed_line=>"101023011536, (, RED, RADISH, ], 27,336"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>35500.0,
          :full_parsed_line=>"101023011384, (, GOLDEN, LEAF, WILD, RUCOLLA, PC, 35.500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>20000.0,
          :full_parsed_line=>"101023011646, (, F, TOMAT, CHERY, RED, PC, ], 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>95400.0,
          :full_parsed_line=>"101012009326, (, TELUR, RENDAH, KOLESTEROL, 10S, 95,400"}],
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
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>64500.0,
          :full_parsed_line=>
           "PEPITO, MARKET, SEMER, Banjar, Semer, ,, Kerobokan, -, Badung, NPWP, 02.046.836.9-904.000, PT, Sentral, Retailindo, Dewata, Item, Sales, Bill, No, :, 5C30000029499, Counter, :, C3, 12, -, Jul, -, 2023, 19:03:56, KSR, PUTRI, AISAH, 101012009252, [, E, &, V, BTR, SPRCK, UNLSTD, 200GR, ], 64,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>65800.0,
          :full_parsed_line=>"P, 101012008979, (, GREENFIELDS, FRESH, MILK, FULL, CREAM, 1LT, ], 70,000 - 4.200"},
         {:category_name=>"Еда",
          :sub_category_name=>"Рыба",
          :price=>94050.0,
          :full_parsed_line=>"101022011336, [, SALMON, FILLET, KG, ], 94,050"},
         {:category_name=>"Еда",
          :sub_category_name=>"Яйца",
          :price=>47700.0,
          :full_parsed_line=>"101012009326, [, TELUR, RENDAH, KOLESTEROL, 10S, 47,700"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>87900.0,
          :full_parsed_line=>"P, 101007001881, [, MAZOLA, SUNFLWR, OIL, 900MLJ, 105,500 - 17,600"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>73500.0,
          :full_parsed_line=>"101012054384, [, MILK, UP, SOUR, CREAM, 25, %, 330M, 73,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>93000.0,
          :full_parsed_line=>"101012009430, [, BEGA, MILD, CHEDDAR, 250GR, ], 93,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>75000.0,
          :full_parsed_line=>"101024032325, [, GRAPE, GREEN, MUSCAT, 500, GR, ], 75,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>8184.0,
          :full_parsed_line=>"101024011735, [, LEMON, IMPORT, KG, ], 8,184"}],
        609634.0,
        nil]
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
        [[{:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>15000.0,
          :full_parsed_line=>"22200003, PASEO, ULTRA, SOFT, 100, 15,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>38000.0,
          :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 38,000"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>282500.0, :full_parsed_line=>"23023003, SUNKIST, RSTOPSCH, 454, 282,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>25000.0,
          :full_parsed_line=>"22201002, PASEO, FCL, TISSUE, 200, 25,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0, :full_parsed_line=>"23231017, DELFI, MINI, TOYS, 16,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 48,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 15,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 15,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>100000.0,
          :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 100,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>54000.0,
          :full_parsed_line=>"23246051, MONGGO, MLK, DARK41, %, 80, 54,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>10000.0, :full_parsed_line=>"23152004, OREO, BISC, VNL, CRM137, 10,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>78213.0, :full_parsed_line=>"10031046, MELON, CANTALUOPE, 78,213"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10220.0, :full_parsed_line=>"10300038, PARSLEY, CURLY, LOOSE, 10,220"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8308.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 8,308"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12050.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 12,050"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18000.0, :full_parsed_line=>"10363010, CAPSICUM, GRN, HIDROPO, 18,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40000.0, :full_parsed_line=>"24044044, BELLA, MOZZA, CWN, 100G, 40,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>145500.0,
          :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>115000.0,
          :full_parsed_line=>"20100030, BINTANG, KLG, 320M, CP6, 115,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49000.0, :full_parsed_line=>"24041025, KRAFT, SINGLES, 10X167, 49,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8927.0, :full_parsed_line=>"10000024, APPLE, RYL, GLA, USA, 80, 8,927"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14560.0, :full_parsed_line=>"10310046, POTATO, MINI, 14,560"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>60500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 60,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 132,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>213000.0,
          :full_parsed_line=>"23364022, AL, SHIFA, ACACIA, 400G, 213,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45900.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 45,900"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>101536.0, :full_parsed_line=>"11042001, TUNA, STEAK, 101,536"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>23762.0, :full_parsed_line=>"12301032, CHICKEN, LEG, BONELESS, 23,762"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>86458.0, :full_parsed_line=>"24044010, FRESH, RICOTTA, 86,458"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>15953.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 15,953"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>32500.0, :full_parsed_line=>"24051004, BIOLAND, ORG, EGG, 10'S, 32,500"}],
        1982387.0,
        nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>34500.0, :full_parsed_line=>"24214006, WALLS, CRNT, TRM12X28M, 34,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>50000.0,
           :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 50,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Хлеб и др",
           :price=>22000.0,
           :full_parsed_line=>"13021006, DE, BAKKER, HOT, DOG, LA, 22,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Алкоголь",
           :price=>115000.0,
           :full_parsed_line=>"20100030, BINTANG, KLG, 320M, CP6, 115,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"К пиву",
           :price=>60500.0,
           :full_parsed_line=>"23030195, THINS, CRM, &, CHIVES, 175, 60, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20090.0, :full_parsed_line=>"10312008, CARROT, MEDIUM, IMPORT, 20, ,, 090"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 48,800"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>15500.0, :full_parsed_line=>"23023004, TONG, SNFLWRS, SEED130, 15,500"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29880.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 29, ,, 880"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55000.0, :full_parsed_line=>"23645009, KUHNE, FEINE, CORN370, 55,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>50952.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 50,952"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27500.0, :full_parsed_line=>"23823025, BONDUEL, PEAS, FINE200, 27,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>60500.0,
           :full_parsed_line=>"24042035, YUMMY, CRM, CHESE, 250, 60, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>54016.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 54,016"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33856.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 33, ,, 856"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18116.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 18, ,, 116"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>50000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 50,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>45765.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 45, ,, 765"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>134000.0,
           :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>128000.0,
           :full_parsed_line=>"24033041, ANCHOR, COOK, CREAM, 1L, 128,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 52,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9042.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 9,042"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 132,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>76000.0,
           :full_parsed_line=>"16106004, BERNARDI, HTDG, BF500G, 76,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>66000.0,
           :full_parsed_line=>"16403017, EL, PRIMO, CHN, CHS360G, 66,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 15,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20500.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 20,500"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>28000.0, :full_parsed_line=>"23246040, MONGGO, CHO, PRALINE40, 28,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>28000.0,
           :full_parsed_line=>"23246065, MONGGO, SLTYCRML69, %, 40, 28,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>20000.0, :full_parsed_line=>"24210007, WALLS, MGNM, CHOC095ML, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>48000.0, :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 48,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>44000.0, :full_parsed_line=>"10410101, GARLIC, 500GR, B, FRESH, 44,000"}],
         1615017.0,
         nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>352500.0, :full_parsed_line=>"20202019, HATTEN, ROSE, CASK, BOX, 352,500"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39624.0, :full_parsed_line=>"12301007, CHICKEN, WING, 39, ,, 624"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 48,800"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26,500"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 25,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31635.0, :full_parsed_line=>"12301025, PAHA, ATAS, 31,635"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>36000.0, :full_parsed_line=>"16004803, KAWAN, ROTI, WRPS, 360G, 36,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>119000.0, :full_parsed_line=>"23240011, LINDT, MILK, 100, GR, 119,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>52580.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 52, ,, 580"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>57684.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 57, ,, 684"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35150.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 35, ,, 150"},
         {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>10000.0, :full_parsed_line=>"32315002, DM, KITCHEN, WARE, KW1, 10,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 52,500"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 31,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>60368.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 60, ,, 368"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 132,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32000.0, :full_parsed_line=>"10400162, WILD, RUCOLA, ORG, 200G, 32,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21930.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 21,930"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17673.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 17,673"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13462.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 13,462"}],
        1272406.0,
        nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31857.0, :full_parsed_line=>"12201019, PORK, LOIN, 31,857"},
          {:category_name=>"Еда",
           :sub_category_name=>"Бакалея",
           :price=>49500.0,
           :full_parsed_line=>"23512073, BARILLA, FUSILLI, 500, 49, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>37560.0, :full_parsed_line=>"10031010, MELON, SKY, ROCKET, 37,560"},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>38080.0, :full_parsed_line=>"16200022, COOKED, HAM, 38, ,, 080"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>24583.0, :full_parsed_line=>"12202009, STREAKY, BACON, 24, ,, 583"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Ванные принадлежности",
           :price=>29500.0,
           :full_parsed_line=>"32510006, BAGUS, KLAP, SRBGNT301, 29, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>124533.0, :full_parsed_line=>"15410002, PORK, CHOP, 124, ,, 533"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25382.0, :full_parsed_line=>"12201019, PORK, LOIN, 25, ,, 382"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Кухонные принадлежности",
           :price=>24000.0,
           :full_parsed_line=>"21010003, BAGUS, S., BILAS, T560, 24,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11410.0, :full_parsed_line=>"10352014, CABBAGE, CHINESE, 11,410"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Кухонные принадлежности",
           :price=>61000.0,
           :full_parsed_line=>"22204014, PASEO, WHITE, 8RL, 280S, 61,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13674.0, :full_parsed_line=>"10360040, TOMATO, CHERRY, 13,674"}],
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
        [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26, ,, 500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Новопочта",
           :price=>19000.0,
           :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19, ,, 000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>67913.0, :full_parsed_line=>"12301032, CHICKEN, LEG, BONELESS, 67,913"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15390.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 15, ,, 390"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>73500.0,
           :full_parsed_line=>"16403014, EL, PRIMO, CHC, FRK500G, 73,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>63000.0,
           :full_parsed_line=>"16101024, KANZLER, CS, BRWRT360G, 63,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16264.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 16, ,, 264"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>19000.0,
           :full_parsed_line=>"23150008, DELFI, OR, CHPIE6P, 180, 19, ,, 000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>52500.0,
           :full_parsed_line=>"24041040, PRESIDENT, GOUDA, 200G, 52, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>52500.0,
           :full_parsed_line=>"24044017, BEL, CHESE, DIPPRS140G, 52, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>131596.0, :full_parsed_line=>"11042001, TUNA, STEAK, 131,596"},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>39406.0, :full_parsed_line=>"16200023, DANISH, HAM, 39, ,, 406"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>50840.0,
           :full_parsed_line=>"12202007, SMOKELEGBONELESKINON, 50, ,, 840"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>134000.0,
           :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 5,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 9,000"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66, ,, 500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>202500.0,
           :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 202, ,, 500"}],
         1082409.0,
         nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>320775.0,
          :full_parsed_line=>"20201080, HATTEN, AGA, WHITE, CAS, 320, ,, 775"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>20000.0,
          :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 20,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66, ,, 500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>134000.0,
          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134, ,, 000"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20024001, RAUCH, HD, PINEAPPLE1L, 56, ,, 500"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>56196.0, :full_parsed_line=>"10031015, WATERMELON, RED, 56, ,, 196"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>16000.0,
          :full_parsed_line=>"22203017, MITU, B, REG, BLUE, 2X50, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40680.0, :full_parsed_line=>"12301032, CHICKEN, LEG, BONELESS, 40, ,, 680"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40061.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 40, ,, 061"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>13510.0, :full_parsed_line=>"12302005, CHICKEN, GIZZARD, 13, ,, 510"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>30115.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 30, ,, 115"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>52500.0,
          :full_parsed_line=>"24041040, PRESIDENT, GOUDA, 200G, 52, ,, 500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>66000.0,
          :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 66, ,, 000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42021.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 42, ,, 021"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>39192.0,
          :full_parsed_line=>"10000009, APPLE, RED, DEL, USA125, 39, ,, 192"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26,500"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16985.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 16,985"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24000.0, :full_parsed_line=>"10400051, DILL, 66, FRESH, HERBS, 24,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"23153001, OREO, MINI, STRWBRRY67, 9,000"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>15000.0, :full_parsed_line=>"15101011, MIXED, JUICE, 15,000"}],
        1221535.0,
        nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0, :full_parsed_line=>"23032021, MEIJI, HELLO, PANDA, MI, 8,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Новопочта",
           :price=>19000.0,
           :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21930.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 21,930"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>110500.0,
           :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 110,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 31,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 67,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 25,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>10000.0,
           :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 10,000"}],
         292930.0,
         nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>286500.0,
          :full_parsed_line=>"16100040, EL, PRIMO, BF, CHSE500G, 286,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>49016.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 49,016"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>39836.0,
          :full_parsed_line=>"10000009, APPLE, RED, DEL, USA125, 39, ,, 836"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>35406.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 35, ,, 406"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
         {:category_name=>"Марк",
          :sub_category_name=>"Памперсы",
          :price=>128500.0,
          :full_parsed_line=>"22242012, MAKUKU, SLIM, PTS, L, 34, 128,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33500.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 33,500"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20004004, FANTA, STRAW, PET, 1.5L, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>21156.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 21,156"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>25000.0, :full_parsed_line=>"23030112, PRINGLES, ORIGINAL, 10, 25,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>145500.0,
          :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>25000.0, :full_parsed_line=>"23030114, PRINGLES, CHDR, CHS107, 25,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25000.0, :full_parsed_line=>"23030113, PRINGLES, SOUR, CREAM, 25,000"},
         {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512073, BARILLA, FUSILLI, 500, 49,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>33000.0,
          :full_parsed_line=>"23640012, KEWPIE, MYNAIS, ORI150, 33,000"},
         {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>59150.0, :full_parsed_line=>"12202011, SMOKED, HAM, 59, ,, 150"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>114500.0,
          :full_parsed_line=>"23364009, LDM, SQUEEZY, HNY, 500G, 114,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>35000.0,
          :full_parsed_line=>"16200043, MAMAS, SALAM, MLN0100G, 35,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56672.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 56,672"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>76405.0, :full_parsed_line=>"12201019, PORK, LOIN, 76,405"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>40500.0, :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 40,500"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>79288.0, :full_parsed_line=>"11101006, SHRIMP, FRESH, VANAME, 79, ,, 288"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>15000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 15,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>134000.0,
          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>35500.0,
          :full_parsed_line=>"23150009, DELFI, OR, CHPIE12, 360, 35,500"}],
        1741929.0,
        nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>39879.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 39,879"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39900.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 39, ,, 900"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40455.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 40, ,, 455"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148000.0, :full_parsed_line=>"23362020, NUTELLA, T680, GR, 148,000"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 56, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>59500.0, :full_parsed_line=>"23240011, LINDT, MILK, 100, GR, 59,500"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>58500.0, :full_parsed_line=>"23240047, SCHOGTN, MILKCH0100G, 58, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>9000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 9,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18320.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 18, ,, 320"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 18,000"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>133934.0, :full_parsed_line=>"11042001, TUNA, STEAK, 133, ,, 934"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22145.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 22, ,, 145"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13600013, BGB, BREAD, 22.000, 22,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 25,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5500.0, :full_parsed_line=>"10400113, PARSLEY, ITALIAN, 100G, 5,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14500.0, :full_parsed_line=>"10400158, RUCOLA, BABY, 200, GR, 14,500"}],
         793133.0,
         nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>43425.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 43,425"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39284.0, :full_parsed_line=>"10000009, APPLE, RED, DEL, USA125, 39,284"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>54000.0,
           :full_parsed_line=>"23641001, FRENCH, YLW, SQ, MSTD14, 54,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0, :full_parsed_line=>"23231017, DELFI, MINI, TOYS, 16,500"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16082.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 16,082"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512070, BARILLA, TRTGLIONI500, 49,500"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>37000.0, :full_parsed_line=>"20015038, JUNGLE, JC, PNAPPLE, 1L, 37,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9310.0, :full_parsed_line=>"10366014, EGGPLANT, PURPLE, 9,310"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>108955.0, :full_parsed_line=>"15410002, PORK, CHOP, 108,955"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31500.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 31,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>3773.0, :full_parsed_line=>"10500016, GARLIC, 3,773"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66,500"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16500.0, :full_parsed_line=>"23231017, DELFI, MINI, TOYS, 16,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0, :full_parsed_line=>"23241016, DELFI, ALMOND, 140GR, 31,500"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>12642.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 12,642"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>134000.0,
           :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030191, THINS, ORI, AUS, 175, GR, 66,500"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 25,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0, :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 30,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>30000.0,
           :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 30,000"}],
         957971.0,
         nil]
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
        [[{:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>21500.0,
          :full_parsed_line=>"22202017, PASEO, SOFT, SINGLE250, 21,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>50000.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>59400.0, :full_parsed_line=>"310014, POTATO, GRANOLA, LOOSE, 59,400"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11760.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 11,760"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20004004, FANTA, STRAW, PET, 1.5L, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>23923.0, :full_parsed_line=>"10082044, MANGO, HRMNIS, TKPOHON, 23,923"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>6500.0, :full_parsed_line=>"24020060, GREENFIELDS, YG, S150G, 6,500"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>146292.0, :full_parsed_line=>"11042001, TUNA, STEAK, 146,292"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>31500.0, :full_parsed_line=>"23241016, DELFI, ALMOND, 140GR, 31,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24020136, M00, KEFIR, 300M, 40,500"}],
        474375.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Бакалея",
          :price=>49500.0,
          :full_parsed_line=>"23512075, BARILLA, FARFALLE, 500, 49, ,, 500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>13000.0,
          :full_parsed_line=>"23230020, DELFI, ZAP, CHOC, 42, GR, 13,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>50000.0,
          :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 50, ,, 000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>12000.0, :full_parsed_line=>"24211803, WALLS, CRNT, SLRQN108M, 12,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>147500.0,
          :full_parsed_line=>"24033041, ANCHOR, COOK, CREAM, 1L, 147, ,, 500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13500.0, :full_parsed_line=>"10400106, RUCOLA, 250, GR, 13,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Фрукты",
          :price=>15308.0,
          :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 15, ,, 308"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 31,000"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>33500.0,
          :full_parsed_line=>"16200020, HUNGARISALAM100MAMAS, 33, ,, 500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>8500.0, :full_parsed_line=>"23032020, MEIJI, HLLO, PNDA, STR, 8,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0, :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 32,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14320.0, :full_parsed_line=>"10362003, KYURI, BABY, 14, ,, 320"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 32,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>22790.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 22, ,, 790"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46710.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 46,710"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>32000.0, :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 32,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>16000.0, :full_parsed_line=>"23230005, KINDER, BUENO, T2, 43GR, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>22000.0,
          :full_parsed_line=>"23230030, KIT, KAT, 2F, ALU, 48X17, 22,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>15000.0,
          :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 15, ,, 000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>30000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 30,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>15000.0,
          :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 15,000"}],
        734628.0,
        nil]
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
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>110500.0,
          :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 110,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>19000.0,
          :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45570.0, :full_parsed_line=>"24041001, PERFETTO, MOZARELLA, C, 45,570"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>41535.0, :full_parsed_line=>"10340009, ASPARAGUS, GREEN, B, 41,535"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20640.0, :full_parsed_line=>"10363009, CAPSICUM, YLW, HIDROPO, 20, ,, 640"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>173020.0, :full_parsed_line=>"11041004, BARRAMUNDI, FILLET, ON, 173,020"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45475.0, :full_parsed_line=>"12301025, PAHA, ATAS, 45,475"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>64812.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 64,812"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>35000.0,
          :full_parsed_line=>"16200043, MAMAS, SALAM, MLN0O100G, 35,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 18,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>5000.0, :full_parsed_line=>"23231018, DELFI, CHACHA, PNT, M25, 5,000"}],
        665552.0,
        nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0, :full_parsed_line=>"24042040, YUMMY, CREME, FRCE, 200, 77,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>132000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 132,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>56500.0, :full_parsed_line=>"24044017, BEL, CHESE, DIPPRS140G, 56,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29862.0, :full_parsed_line=>"10363010, CAPSICUM, GRN, HIDROPO, 29,862"},
          {:category_name=>"Еда",
           :sub_category_name=>"Фрукты",
           :price=>18146.0,
           :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 18, ,, 146"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>95500.0,
           :full_parsed_line=>"16100040, EL, PRIMO, BF, CHSE500G, 95,500"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>95500.0, :full_parsed_line=>"16100041, EL, PRIMO, BEEF, FR500G, 95,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>40500.0,
           :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 40, ,, 500"},
          {:category_name=>"Еда",
           :sub_category_name=>"К пиву",
           :price=>23000.0,
           :full_parsed_line=>"23020018, TG, CASHEWNUTS, HNY, 35, 23, ,, 000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>4500.0, :full_parsed_line=>"10400259, PARSLEY, 100, GR, 4,500"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3000.0, :full_parsed_line=>"20081011, NESTLE, WTR, BTL, 600ML, 3,000"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3500.0, :full_parsed_line=>"20081001, AQUA, WATER, BTL, 600ML, 3,500"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40388.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 40,388"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>74640.0, :full_parsed_line=>"10000024, APPLE, RYL, GLA, USA, 80, 74,640"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>148000.0, :full_parsed_line=>"23362020, NUTELLA, T680, GR, 148,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24020136, M00, KEFIR, 300M, 40, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>5934.0, :full_parsed_line=>"10340001, DAUN, BAWANG, BESAR, 5,934"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>25000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 25,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>18980.0, :full_parsed_line=>"10360014, TOMATO, TW, CURAH, 18,980"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29892.0, :full_parsed_line=>"12301800, CHICKEN, MILL, MEAT, 29, ,, 892"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>33630.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 33, ,, 630"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>43977.0, :full_parsed_line=>"12301803, CHICKEN, FILLET, 43,977"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>66822.0, :full_parsed_line=>"12400007, BEEF, TOP, SIDE, 66,822"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9082.0, :full_parsed_line=>"10352014, CABBAGE, CHINESE, 9, ,, 082"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>104000.0,
           :full_parsed_line=>"24042004, BAROS, GOUDA, CS, M250G, 104,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>31000.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 31,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>44500.0, :full_parsed_line=>"24020137, PLAIN, YOGURT, 350G, 44,500"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>19500.0, :full_parsed_line=>"23023019, REBO, KUACI, SPRORI150, 19,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>67000.0,
           :full_parsed_line=>"16200020, HUNGARISALAM100MAMAS, 67,000"}],
         1418353.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 15', freezed_time: '2022-12-25T04:26:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out40.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>59500.0, :full_parsed_line=>"16101068, BERNARDI, BF, BTWT310G, 59,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>53514.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 53,514"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>56905.0, :full_parsed_line=>"12301025, PAHA, ATAS, 56.905"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47399.0, :full_parsed_line=>"12301008, CHICKEN, BREAST, BONEL, 47,399"},
         {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0, :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>45927.0, :full_parsed_line=>"12201001, PORK, LEG, /, EISBEIN, 45,927"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>29779.0, :full_parsed_line=>"10301010, DILL, LOOSE, 29, ,, 779"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>29412.0, :full_parsed_line=>"11042002, SWORDFISH, STEAK, 29,412"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>117902.0, :full_parsed_line=>"TUNA, STEAK, 117,902"}],
        459338.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 16', freezed_time: '2022-12-28T08:49:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out41.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>50000.0,
          :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 50,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>39474.0, :full_parsed_line=>"12301026, PAHA, BAWAH, 39,474"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 34,500"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Кофе, Чай",
          :price=>161500.0,
          :full_parsed_line=>"23314007, NESCAFE, GOLD, DECAFFE, 161,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>105000.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 105,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11748.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 11,748"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>37442.0, :full_parsed_line=>"12301025, PAHA, ATAS, 37,442"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>34191.0, :full_parsed_line=>"10362018, ZUCCHINI, GREEN, 34, ,, 191"},
         {:category_name=>"Еда",
          :sub_category_name=>"Овощи",
          :price=>104850.0,
          :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 104, ,, 850"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>40866.0, :full_parsed_line=>"10313005, RED, RADISH, 40, ,, 866"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>50000.0,
          :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 50,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12560.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,560"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12000.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,000"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 34,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0, :full_parsed_line=>"10400124, RUCOLA, HYDROPNK, 250G, 20,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>18000.0, :full_parsed_line=>"23231013, DELFI, CHACHA, PNTWR40, 18,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>34000.0, :full_parsed_line=>"23241015, DELFI, CHOCOLATEALM50, 34,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>34000.0,
          :full_parsed_line=>"23242004, DELFI, FRUIT, &, NUT, 50, 34,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>134000.0,
          :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"}],
        1026631.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 17', freezed_time: '2022-12-30T07:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out42.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>77778.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 77,778"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3000.0, :full_parsed_line=>"20081014, CHEERS, WATER, 500, ML, 3,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>52500.0,
           :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 52, ,, 500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>40500.0,
           :full_parsed_line=>"13600038, POULE, DE, LUXE, 45.000, 40, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Алкоголь",
           :price=>317590.0,
           :full_parsed_line=>"20200074, HATTEN, AGA, RED, CASK, 317, ,, 590"},
          {:category_name=>"Еда",
           :sub_category_name=>"Фрукты",
           :price=>23134.0,
           :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 23, ,, 134"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>77770.0, :full_parsed_line=>"10000022, APPLE, ROSE, NZ, 80/110, 77,770"},
          {:category_name=>"Еда",
           :sub_category_name=>"Кофе, Чай",
           :price=>145500.0,
           :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>150300.0, :full_parsed_line=>"11042001, TUNA, STEAK, 150, ,, 300"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>131706.0, :full_parsed_line=>"12201002, PORK, NECK, 131, ,, 706"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>38025.0, :full_parsed_line=>"10363008, CAPSICUM, RED, HIDROPO, 38, ,, 025"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>57750.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 57,750"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>70000.0,
           :full_parsed_line=>"16200043, MAMAS, SALAM, MLN0100G, 70,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>147000.0,
           :full_parsed_line=>"16403014, EL, PRIMO, CHC, FRK500G, 147,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>52000.0, :full_parsed_line=>"24050001, EGG, NEGERI, 10'S, 52, ,, 000"}],
         1471053.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 18', freezed_time: '2022-12-31T08:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out43.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>48000.0,
          :full_parsed_line=>"35100003, WOOD, CHARCOAL, 1, KG, 48,000"},
         {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>263900.0, :full_parsed_line=>"20202029, SABABAY, ASCARO, 750M, 263,900"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>66500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 66,500"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>75469.0, :full_parsed_line=>"10367010, RED, ONION, LARGE, 75,469"},
         {:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>66500.0,
          :full_parsed_line=>"23030195, THINS, CRM, &, CHIVES, 175, 66,500"}],
        536369.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 19', freezed_time: '2023-01-09T03:47:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out44.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 66,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54000.0, :full_parsed_line=>"24041027, BEGA, SPER, SLICES250G, 54,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0, :full_parsed_line=>"24214008, WALLS, MGNUM, M., A6X45M, 50,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>29646.0, :full_parsed_line=>"12201001, PORK, LEG, /, EISBEIN, 29,646"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>50000.0, :full_parsed_line=>"WALLS, MGNUM, M., A6X45M, 50,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>19890.0, :full_parsed_line=>"PAHA, BAWAH, 19, ,, 890"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>37636.0, :full_parsed_line=>"PAHA, ATAS, 37,636"}],
         327172.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 20', freezed_time: '2023-01-21T07:09:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out45.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Новопочта",
          :price=>19000.0,
          :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 53,500"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>136694.0,
          :full_parsed_line=>"12201012, SALAMINOSTRACBITALIA, 136,694"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>56908.0, :full_parsed_line=>"12202008, BACK, BACON, 56,908"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 59,400"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>37500.0, :full_parsed_line=>"23230034, NESTLE, KITKAT, CHNK38, 37,500"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>32000.0, :full_parsed_line=>"10400162, WILD, RUCOLA, ORG, 200G, 32,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 14,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>14000.0,
          :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 14,000"}],
        477002.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 21', freezed_time: '2023-01-21T07:15:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out46.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"К пиву",
          :price=>70500.0,
          :full_parsed_line=>"23030195, THINS, CRM, &, CHIVES, 175, 70,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Кухонные принадлежности",
          :price=>61000.0,
          :full_parsed_line=>"22204014, PASEO, WHITE, 8RL, 280S, 61,000"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 48,800"},
         {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>48800.0, :full_parsed_line=>"20021015, RAUCH, HD, ORANGE, 1L, 48,800"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>31000.0, :full_parsed_line=>"23030055, LORENZ, BARBECUE, 100G, 31,000"}],
        260100.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 22', freezed_time: '2023-01-21T07:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out47.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>53500.0, :full_parsed_line=>"10400119, LEAF, DILL, 200, GR, 53,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>8299.0, :full_parsed_line=>"10312008, CARROT, MEDIUM, IMPORT, 8, ,, 299"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>56000.0,
           :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 56,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23400.0, :full_parsed_line=>"10310014, POTATO, GRANOLA, LOOSE, 23, ,, 400"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>25576.0, :full_parsed_line=>"12301025, PAHA, ATAS, 25,576"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>89034.0, :full_parsed_line=>"10070001, CHERRY, 26-28, AUST, 89, ,, 034"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>56000.0,
           :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 56,000"}],
         311809.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 23', freezed_time: '2023-01-27T08:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out48.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>24500.0, :full_parsed_line=>"24010011, GREENFIELDS, F.C, 1L, 24,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>168000.0,
           :full_parsed_line=>"24214007, WALLS, MGNUM, M., C6X45M, 168,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>111000.0,
           :full_parsed_line=>"24210023, WALLS, MAGNUM, ALMD90M, 111,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Кухонные принадлежности",
           :price=>24000.0,
           :full_parsed_line=>"21010003, BAGUS, S., BILAS, T560, 24,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>20500.0, :full_parsed_line=>"23233005, HERSHEY, KS, CKSNCRM36, 20,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>118800.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 118,800"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Кухонные принадлежности",
           :price=>13300.0,
           :full_parsed_line=>"21040043, BIO, +, JRK, NPS, 780ML, 13,300"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>134000.0,
           :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>63000.0, :full_parsed_line=>"23241016, DELFI, ALMOND, 140GR, 63,000"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Ванные принадлежности",
           :price=>9500.0,
           :full_parsed_line=>"21113003, PROCLIN, W, CRYSTAL125, 9,500"}],
         804600.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 24', freezed_time: '2023-01-28T03:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out49.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0, :full_parsed_line=>"23231010, KINDER, JOY, T24, GRL20, 14,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>14000.0, :full_parsed_line=>"23231011, KINDER, JOY, T24, BYS20, 14,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>64000.0,
           :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>28000.0, :full_parsed_line=>"23822003, DAUCY, CRS, SWTCORN300, 28,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>97500.0, :full_parsed_line=>"23246120, SQ, B2G1, PROMO, PACK, 97,500"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>17500.0, :full_parsed_line=>"23802010, BESTANAKU, CHU, OIL, 150, 17,500"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>3500.0, :full_parsed_line=>"20081001, AQUA, WATER, BTL, 600ML, 3,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>191000.0,
           :full_parsed_line=>"16100040, EL, PRIMO, BF, CHSE500G, 191,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>54000.0, :full_parsed_line=>"24041027, BEGA, SPER, SLICES250G, 54,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>21500.0, :full_parsed_line=>"10360001, TOMATO, CHER, RED335, 21,500"}],
         505000.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 25', freezed_time: '2023-01-28T03:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out50.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Кухонные принадлежности",
           :price=>40000.0,
           :full_parsed_line=>"22202018, PASEO, SOFT, MED, 220S, 40,000"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>46000.0, :full_parsed_line=>"23503018, SHUKRIYA, RICE, 1, KG, 46,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>23000.0, :full_parsed_line=>"24010011, GREENFIELDS, F.C, 1L, 23,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>59648.0, :full_parsed_line=>"12201019, PORK, LOIN, 59,648"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>44800.0, :full_parsed_line=>"12201019, PORK, LOIN, 44,800"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>96944.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 96,944"}],
         367892.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 26', freezed_time: '2023-02-03T09:42:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out51.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Новопочта",
           :price=>19000.0,
           :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>25069.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 25,069"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>38000.0, :full_parsed_line=>"20015069, SUNFRSH, PREM, MANGO1L, 38,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>14184.0, :full_parsed_line=>"10031015, WATERMELON, RED, 14, ,, 184"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>157500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 157,500"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>33200.0, :full_parsed_line=>"23240046, VH, DARK, MILKCHO, 140G, 33,200"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>117000.0, :full_parsed_line=>"23240047, SCHOGTN, MILKCH0100G, 117,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78000.0, :full_parsed_line=>"23360034, METZGR, B, CAFE, PRS150, 78,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>104448.0, :full_parsed_line=>"12201019, PORK, LOIN, 104,448"}],
         602401.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 27', freezed_time: '2023-02-12T03:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out52.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>7905.0, :full_parsed_line=>"10352014, CABBAGE, CHINESE, 7,905"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31600.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,600"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>21000.0,
           :full_parsed_line=>"23638061, KIKKOMAN, TRY, LHTM300, 21,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>16950.0, :full_parsed_line=>"10351001, BROCCOLI, LOCAL, 16,950"},
          {:category_name=>"Еда",
           :sub_category_name=>"Алкоголь",
           :price=>21000.0,
           :full_parsed_line=>"20100004, BALI, HAI, CAN330ML24, ', 21,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>50500.0,
           :full_parsed_line=>"24045057, EMINA, SMOK, CHES, 150G, 50, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>14000.0, :full_parsed_line=>"20007004, BINTANG, RDLR, BLCK330, 14,000"}],
         387455.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 28', freezed_time: '2023-02-12T04:44:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out53.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Алкоголь",
          :price=>320775.0,
          :full_parsed_line=>"20201080, HATTEN, AGA, WHITE, CAS, 320, ,, 775"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>36096.0, :full_parsed_line=>"12201019, PORK, LOIN, 36,096"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>40704.0, :full_parsed_line=>"12201019, PORK, LOIN, 40, ,, 704"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>81500.0, :full_parsed_line=>"16202014, SVENSCHOC, PORKPT125G, 81,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27000.0, :full_parsed_line=>"23030163, EL, CHILE, CORN, CHP200, 27,000"},
         {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>31000.0, :full_parsed_line=>"23030055, LORENZ, BARBECUE, 100G, 31,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>54000.0,
          :full_parsed_line=>"23610028, FILIPPO, EX, VR, OIL250, 54,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"}],
        643575.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive not parsed one fake product', freezed_time: '2023-02-12T03:42:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/not_parsed_one_fake_product.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>nil, :sub_category_name=>nil, :price=>30192.0, :full_parsed_line=>"12301026, not, parsed, 1, 30, ,, 192"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31540.0, :full_parsed_line=>"12301007, CHICKEN, WING, 31,540"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>110500.0,
           :full_parsed_line=>"23615002, MAZOLA, SNFLWR, OIL900, 110,500"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>24500.0, :full_parsed_line=>"SPAGHETTI, BOLOGNESE, 24,500"}],
         196732.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 29', freezed_time: '2023-02-12T05:36:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out54.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>89500.0, :full_parsed_line=>"23615005, GOLDEN, SNFLOWER, OIL1, 89,500"},
         {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>17000.0, :full_parsed_line=>"23390018, KUNCI, BIRU, TERIGU1KG, 17,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>42745.0, :full_parsed_line=>"12301025, PAHA, ATAS, 42,745"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>117000.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 117,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>31291.0, :full_parsed_line=>"12301028, CHICKEN, LEG, PARTING, 31, ,, 291"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>63000.0, :full_parsed_line=>"23242005, DELFI, FRUIT, &, NUT140, 63,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17000.0, :full_parsed_line=>"10320091, JAMUR, CHAMPIGNON, FRE, 17,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>28000.0, :full_parsed_line=>"10400119, LEAF, OILL, 200, GR, 28,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>8000.0, :full_parsed_line=>"24010014, GREENFIELDS, F.C, 125, 8,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>8000.0, :full_parsed_line=>"24018006, GREENFIELDS, STR125, 8.000"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>24000.0, :full_parsed_line=>"24203002, WALLS, 3IN1, NPLTN350M, 24,000"}],
        483036.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 30', freezed_time: '2023-02-17T14:19:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out55.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>40000.0, :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 40,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 53,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>19304.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 19,304"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>40500.0, :full_parsed_line=>"24042013, KIRI, CHEESE, CRM, 120G, 40,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24030025, ANCHOR, UNSALTED, 227G, 66,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10000.0, :full_parsed_line=>"10400016, DAUN, BAWANG, 200, SFO, 10,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>88201.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 88,201"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>149380.0, :full_parsed_line=>"15410002, PORK, CHOP, 149,380"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12848.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,848"},
         {:category_name=>"Для дома", :price=>28000.0, :sub_category_name=>"Ванные принадлежности", :full_parsed_line=>"22185002, ORALB, TB, STG2, WINNIE, 28,000"},
         {:category_name=>"Лиля",:sub_category_name=>"Ванные принадлежности",:price=>9000.0,:full_parsed_line=>"22230008, LAURIER, PL, SLV, DE020, 9,000"}],
        603233.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 31', freezed_time: '2023-02-17T14:27:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out56.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>11800.0, :full_parsed_line=>"24011021, GREENFIELDS, CHMLT200, 11,800"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>13500.0, :full_parsed_line=>"23330017, PSM, GULA, 1KG, 13,500"},
          {:category_name=>"Еда", :sub_category_name=>"Кофе, Чай", :price=>145500.0, :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24201006, WALLS, VANILLA, 700ML, 38,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24203003, WALLS, NPLTNA, 700ML, 38,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>153500.0, :full_parsed_line=>"10060800, STRAWBERRY, KOREA, 250, 153,500"}],
         400300.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 32', freezed_time: '2023-02-21T08:22:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out57.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>9000.0, :full_parsed_line=>"10000012, APPLE, RYL, GLA, USA125, 9,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>77400.0, :full_parsed_line=>"10301010, DILL, LOOSE, 77,400"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>107030.0, :full_parsed_line=>"15410002, PORK, CHOP, 107,030"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>156294.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 156,294"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>70713.0, :full_parsed_line=>"12201002, PORK, NECK, 70,713"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>17000.0, :full_parsed_line=>"10320091, JAMUR, CHAMPIGNON, FRE, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39500.0, :full_parsed_line=>"24042014, THE, LAUGHNG, CWCHS8S, 39,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33500.0, :full_parsed_line=>"10400106, RUCOLA, 250, GR, 33,500"}],
         510437.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 33', freezed_time: '2023-02-21T08:34:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out58.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>35000.0, :full_parsed_line=>"13600041, ROTI, BGB, 35000, 35,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>147000.0, :full_parsed_line=>"10063002, BLUEBERRY, 125GR, SPAN, 147,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>42594.0, :full_parsed_line=>"24041003, ANCHOR, CHDDR, COLOURD, 42,594"},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>49980.0, :full_parsed_line=>"16200022, COOKED, HAM, 49,980"},
          {:category_name=>"Еда",
           :sub_category_name=>"Колбаса, сосиски",
           :price=>31000.0,
           :full_parsed_line=>"16200044, MAMAS, FRNCH, SLMI100G, 31,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Кофе, Чай",
           :price=>145500.0,
           :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"}],
         471074.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 34', freezed_time: '2023-02-28T03:00:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out59.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>24983.0, :full_parsed_line=>"10082051, BANANA, CAVD, SUNPRIDE, 24,983"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24684.0, :full_parsed_line=>"10340002, DAUN, BAWANG, CHUNG, 24, ,, 684"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52, ,, 500"},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>47940.0, :full_parsed_line=>"12202013, SMOKED, COOKED, HAM, 47,940"},
          {:category_name=>"Еда", :sub_category_name=>"Колбаса, сосиски", :price=>50711.0, :full_parsed_line=>"16200023, DANISH, HAM, 50,711"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>18500.0, :full_parsed_line=>"23390016, CAKRA, KEMBAR, TERIGU1, 18,500"},
          {:category_name=>"Для дома", :sub_category_name=>"Кухонные принадлежности", :price=>20000.0, :full_parsed_line=>"22202018, PASEO, SOFT, MED, 220S, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>10209.0, :full_parsed_line=>"10363010, CAPSICUM, GRN, HIDROPO, 10, ,, 209"}],
         338027.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 35', freezed_time: '2023-03-02T00:52:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out60.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>16000.0, :full_parsed_line=>"20000005, COCA, COLA, PET, 1500ML, 16,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Кофе, Чай",
           :price=>145500.0,
           :full_parsed_line=>"23314006, NESCAFE, GOLD, BLD100G, 145,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>50500.0,
           :full_parsed_line=>"23621012, PURA, SEA, SLT, FINE300, 50,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>77500.0, :full_parsed_line=>"24042040, YUMMY, CREME, FRCE, 200, 77,500"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Хлеб и др",
           :price=>22500.0,
           :full_parsed_line=>"13020005, RUMAH, ROTI, BROWN, COB, 22,500"}],
         346000.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 36', freezed_time: '2023-03-05T03:06:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out61.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20026039, RAUCH, HD, CRANBERRY1L, 56,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>134000.0,
           :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 134,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>177870.0, :full_parsed_line=>"15410002, PORK, CHOP, 177,870"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>6000.0, :full_parsed_line=>"20000007, COCA, COLA, PET, 390ML, 6,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35894.0, :full_parsed_line=>"12201003, PORK, FILLET, 35,894"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>177000.0,
           :full_parsed_line=>"24213001, HAAGENDAZS, VNLA, 100M, 177,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56000.0, :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 56,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Специи, приправы",
           :price=>20000.0,
           :full_parsed_line=>"23624056, JAYS, BAY, LEAVES, 8, GR, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26450.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 26,450"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>53500.0, :full_parsed_line=>"24000008, GREENFIELDS, FRESH, MI, 53,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>46032.0, :full_parsed_line=>"10360017, BEEF, TOMATO, HYDPONIC, 46,032"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26640.0, :full_parsed_line=>"10000012, APPLE, RYL, GLA, USA125, 26,640"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>26500.0, :full_parsed_line=>"10082012, PINEAPPLE, HN9SUNPRID, 26,500"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>139385.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 139,385"}],
         981771.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 37', freezed_time: '2023-03-17T05:46:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out62.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>64000.0,
          :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>38976.0, :full_parsed_line=>"24043002, EMMENTAL, BLOCK, 38,976"},
         {:category_name=>"Еда",
          :sub_category_name=>"Колбаса, сосиски",
          :price=>9000.0,
          :full_parsed_line=>"16101023, KANZLER, SNGLE, ORI65G, 9,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 59,400"},
         {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>67000.0, :full_parsed_line=>"23803006, SUNVIEW, ANCHVY, FIL48, 67,000"},
         {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>26182.0, :full_parsed_line=>"12301800, CHICKEN, MILL, MEAT, 26,182"}],
        264558.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 38', freezed_time: '2023-03-24T13:25:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out63.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>70500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 70,500"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47000.0, :full_parsed_line=>"20026011, COMPAL, NCT, PEACH, 1L, 47,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>39500.0, :full_parsed_line=>"24042014, THE, LAUGHNG, CWCHS8S, 39,500"},
          {:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>251750.0, :full_parsed_line=>"20201057, ISOLA, WHITE, WINE750M, 251,750"},
          {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>5000.0, :full_parsed_line=>"33301006, SHOPPING, B, FRESTIVE, 5,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11165.0, :full_parsed_line=>"10312008, CARROT, MEDIUM, IMPORT, 11,165"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>84500.0, :full_parsed_line=>"24044050, YUMMY, FETAH, CHESE250, 84,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49000.0, :full_parsed_line=>"24020117, BIOKUL, YGHRT, STRW, 1L, 49,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>9180.0, :full_parsed_line=>"10365005, CORN, SWEET, PEEL, 9,180"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>132073.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 132,073"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>35768.0, :full_parsed_line=>"12201005, PORK, BELLY, 35,768"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12060.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 12,060"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD227G, 59,400"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>67000.0, :full_parsed_line=>"23244008, LINDT, MILK, HZLNT, 100, 67,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>55200.0, :full_parsed_line=>"10301010, DILL, LOOSE, 55,200"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"10800007, PURI, CHEERY, 15K, 15,000"}],
         1089096.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 39', freezed_time: '2023-03-27T06:09:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out64.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>19008.0, :full_parsed_line=>"10031015, WATERME_ON, RED, 19,008"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>41808.0, :full_parsed_line=>"12400007, BEEF, TOP, SIDE, 41,808"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>145783.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 145,783"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>32500.0, :full_parsed_line=>"24051004, BIOLAND, ORG, EGG, 10'S, 32,500"}],
         239099.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 40', freezed_time: '2023-04-09T05:07:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out65.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>104500.0, :full_parsed_line=>"24021072, YUMMY, YOG, STRAW500GR, 104,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>52500.0, :full_parsed_line=>"24044051, YUMMY, RICTA, CHS250, 52,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>59400.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD200G, 59,400"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>153500.0, :full_parsed_line=>"10060800, STRAWBERRY, KOREA, 250, 153,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>30000.0,
           :full_parsed_line=>"23240006, BALI, BONBON, PLAIN, 50, 30,000"}],
         481900.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 41', freezed_time: '2023-04-24T08:31:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out66.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>58500.0, :full_parsed_line=>"23246118, SCHOGTN, STRCITLA100G, 58,500"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>64000.0, :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>140140.0, :full_parsed_line=>"15410002, PORK, CHOP, 140,140"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>22000.0, :full_parsed_line=>"13009017, DE, BAKKER, ROSEMARY, B, 22,000"}],
         366640.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 42', freezed_time: '2023-04-27T11:03:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out67.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Алкоголь", :price=>209000.0, :full_parsed_line=>"20202010, SABABAY, PINK, BLSM750, 209,000"},
          {:category_name=>"Еда", :sub_category_name=>"Новопочта", :price=>19000.0, :full_parsed_line=>"33302001, LINDS, TAS, KAIN, LARGE, 19,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>34155.0, :full_parsed_line=>"10041010, PEAR, HONEY, BELLE, 34,155"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>15000.0, :full_parsed_line=>"23330015, FS, GULA, PUTIH, 1, KG, 15,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>112000.0, :full_parsed_line=>"24214008, WALLS, MGNUM, M.A6X45M, 112,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>56000.0, :full_parsed_line=>"24214007, WALLS, MGNUM, M.C6X45M, 56,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>45500.0, :full_parsed_line=>"24021046, GREENFIELDS, YG, M500M, 45,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>41000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 41,000"},
          {:category_name=>"Лиля", :sub_category_name=>"Ванные принадлежности", :price=>9000.0, :full_parsed_line=>"22230008, LAURIER, PL, SLV, DE020, 9,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>74000.0, :full_parsed_line=>"24021160, MASCARPN, CHSVAN70, 74,000"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Ванные принадлежности",
           :price=>28000.0,
           :full_parsed_line=>"22185001, ORALB, TB, STG3, PRINCE, 28,000"},
          {:category_name=>nil, :sub_category_name=>nil, :price=>105500.0, :full_parsed_line=>"24044084, 8DG, CH, GRK, STFT200GR, 105,500"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>70500.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 70,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>27000.0, :full_parsed_line=>"10400106, RUCOLA, 250, GR, 27,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"}],
         914655.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 43', freezed_time: '2023-05-07T02:28:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out68.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>32500.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 32,500"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>20000.0, :full_parsed_line=>"13600011, BGB, BREAD, 20.000, 20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>10660.0, :full_parsed_line=>"10031011, PEPAYA, CALIFORNIA, 10,660"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>47000.0, :full_parsed_line=>"20026010, COMPAL, NCT, PEAR, 1L, 47,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>64000.0, :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
          {:category_name=>"Еда", :sub_category_name=>"Вода", :price=>56500.0, :full_parsed_line=>"20026038, RAUCH, HD, STRAWBRY, 1L, 56,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>78500.0, :full_parsed_line=>"24044079, COTTAGE, CHEESE, 350G, 78,500"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>37500.0, :full_parsed_line=>"24051006, OMEGA, 3, EGG, 10'S, 37,500"},
          {:category_name=>"Для дома",
           :sub_category_name=>"Кухонные принадлежности",
           :price=>21500.0,
           :full_parsed_line=>"22202023, PASEO, PSOF, BABY, 130S, 21,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>153000.0, :full_parsed_line=>"24043015, PAYSON, BRETON, E, 250, 153,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>23256.0, :full_parsed_line=>"10362001, TIMUN, JEPANG, 23,256"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>14500.0, :full_parsed_line=>"23373057, QUAKER, OAT, INS, R200G, 14,500"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17000.0, :full_parsed_line=>"24021039, GRENFLDS, Y, BLUEBERRY, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021045, GREENFIELD, YG, MG125G, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>109500.0, :full_parsed_line=>"10064005, RASPBERRY, 170, ALLSEA, 109,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021045, GREENFIELD, YG, MG125G, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>136000.0, :full_parsed_line=>"23240012, LINDT, MILK, RSN, NT100, 136,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SALTD200G, 66,000"},
          {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>25000.0, :full_parsed_line=>"23230034, NESTLE, KITKAT, CHNK38, 25,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>74000.0, :full_parsed_line=>"24021160, MASCARPN, CHSVAN70, 74,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66000.0, :full_parsed_line=>"24031027, ANCHOR, PAT, SÄLTD200G, 66,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>12201.0, :full_parsed_line=>"10021002, ANGGUR, BALI, 12,201"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>59500.0, :full_parsed_line=>"16200042, MAMAS, STRKY, BCN, 250G, 59,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>49500.0, :full_parsed_line=>"24040015, MINI, BABYBEL, CHDDR5S, 49,500"}],
         1381617.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 44', freezed_time: '2023-06-01T01:20:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out69.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Для дома",
          :sub_category_name=>"инвентарь",
          :price=>43500.0,
          :full_parsed_line=>"22104050, ANTIS, HS, JRK, NP, 200B, 43,500"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24610.0, :full_parsed_line=>"10362003, KYURI, BABY, 24,610"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>36000.0, :full_parsed_line=>"24020141, MILK, UP, KEFIR, 350, ML, 36,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>44500.0,
          :full_parsed_line=>"23618002, SW, DSTLD, WHT, VNGR16, 44,500"},
         {:category_name=>"Для дома",
          :sub_category_name=>"Ванные принадлежности",
          :price=>7000.0,
          :full_parsed_line=>"21114012, KISPRAY, GOLD, 300, ML, 7,000"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>25500.0, :full_parsed_line=>"24010011, GREENFIELDS, F.C, 1L, 25,500"}],
        181110.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 45', freezed_time: '2023-06-22T05:21:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out70.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>115500.0,
          :full_parsed_line=>"23615002, MAZÜLA, SNFLWR, OIL900, 115,500"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>64000.0,
          :full_parsed_line=>"23640014, MAMASUKA, MAYO, 480, GR, 64,000"},
         {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>34000.0, :full_parsed_line=>"24051028, SUNNY, CHOICE, EGG, 10S, 34,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Специи, приправы",
          :price=>54500.0,
          :full_parsed_line=>"23638117, HEINZ, YEL, MUSTRD, 140, 54,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,000"},
         {:category_name=>"Еда",
          :sub_category_name=>"Молочка",
          :price=>64500.0,
          :full_parsed_line=>"24021156, MILKUP, CTTGCHS9, %, 250G, 64,500"},
         {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>66500.0, :full_parsed_line=>"24021158, MILKUPSOURCRM25, %, 330M, 66,500"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>19951.0, :full_parsed_line=>"10021002, ANGGUR, BALI, 19,951"},
         {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>44880.0, :full_parsed_line=>"10020801, GRAPE, GREEN, SEEDLES, 44,880"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>24288.0, :full_parsed_line=>"10362003, KYURI, BABY, 24,288"},
         {:category_name=>"Еда",
          :sub_category_name=>"Сладости",
          :price=>56000.0,
          :full_parsed_line=>"24214008, WALLS, MGNUM, M., A6X45M, 56,000"},
         {:category_name=>"Еда", :sub_category_name=>"Сладости", :price=>38000.0, :full_parsed_line=>"24203003, WALLS, NPLTNA, 700ML, 38,000"},
         {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>25392.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 25,392"}],
        638511.0,
        nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 46', freezed_time: '2023-06-25T11:30:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out71.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>78336.0, :full_parsed_line=>"10031013, WATERMELON, YELLOW, 78,336"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>39984.0, :full_parsed_line=>"10020009, GRAPE, CALMERIA, USA, 39,984"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>12500.0, :full_parsed_line=>"23030120, PRINGLES, CHEESY, CHEE, 12,500"},
          {:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>5500.0, :full_parsed_line=>"23013007, FINNA, PARS, BARBEQU40, 5,500"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>43218.0, :full_parsed_line=>"10020009, GRAPE, CALMERIA, USA, 43,218"}],
         179538.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 47', freezed_time: '2023-06-26T03:43:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out72.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>42845.0, :full_parsed_line=>"10366002, KABOCHA, RED, 42,845"},
          {:category_name=>"Еда",
           :sub_category_name=>"Полуфабрикаты/морозилка",
           :price=>35000.0,
           :full_parsed_line=>"10701800, GOLDEN, FRAM, G.P, 500G, 35,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>147070.0, :full_parsed_line=>"15410002, PORK, CHOP, 147,070"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>151724.0, :full_parsed_line=>"12201009, PORK, BABY, BACK, RIB, 151,724"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>18656.0, :full_parsed_line=>"10082073, MANGO, BUDI, RAJA, 18,656"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>49500.0, :full_parsed_line=>"23512073, BARILLA, FUSILLI, 500, 49,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>31000.0, :full_parsed_line=>"24000005, GREENFIELDS, FULLCRM1, 31,000"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>37000.0, :full_parsed_line=>"23512135, SAN, REMO, COUSCOUS500, 37,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>82000.0, :full_parsed_line=>"24042041, YUMMY, SOUR, CREAM200G, 82,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>64500.0,
           :full_parsed_line=>"24021156, MILKUP, CTTGCHS9, %, 250G, 64,500"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>11124.0, :full_parsed_line=>"10082075, MANGOSTEEN, 11,124"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>125000.0, :full_parsed_line=>"24031019, LURPAK, DANISH, BUTTER, 125,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>47488.0, :full_parsed_line=>"12021002, BEEF, TENDERLOIN, 47,488"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12496.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,496"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>11616.0, :full_parsed_line=>"10362003, KYURI, BABY, 11,616"},
          {:category_name=>"Еда", :sub_category_name=>"Бакалея", :price=>41000.0, :full_parsed_line=>"23512067, BARILLA, SPGHTTI5, 500, 41,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>17000.0, :full_parsed_line=>"24021039, GRENFLDS, Y, BLUEBERRY, 17,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Хлеб и др",
           :price=>40000.0,
           :full_parsed_line=>"13009014, DE, BAKKER, OLIVE, BREA, 40,000"},
          {:category_name=>"Еда", :sub_category_name=>"Хлеб и др", :price=>15000.0, :full_parsed_line=>"13200001, WAFFLES, ORIGINAL, 70G, 15,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021032, GREENFIELD, YG, OR125M, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021060, GREENFIELD, YG, MY125G, 17,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34000.0, :full_parsed_line=>"24021064, GREENFIELD, YG, RP125G, 34,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>34000.0, :full_parsed_line=>"24021056, GREENFIELDS, YG, M125G, 34,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>17000.0, :full_parsed_line=>"24021045, GREENFIELD, YG, MG125G, 17,000"}],
         1099019.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end

  context 'when receipt frestive 48', freezed_time: '2023-06-29T11:19:00+00:00' do
    let(:get_telegram_image) { File.read("spec/images/frestive/out73.jpeg") }

    it 'return 3 values' do
      result = subject

      sum_of_prices = result[0].sum { |hsh| hsh[:price] }.round(2)
      expect(result).to eq(
        [[{:category_name=>"Еда", :sub_category_name=>"К пиву", :price=>74000.0, :full_parsed_line=>"23030194, THINS, CHICKEN, 175, GR, 74,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Хлеб и др",
           :price=>20500.0,
           :full_parsed_line=>"13010009, RUMAH, ROTI, BREAD, WHI, 20,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Алкоголь",
           :price=>185250.0,
           :full_parsed_line=>"20201081, HATTEN, ALEXZANDRIA, B, 185,250"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12232.0, :full_parsed_line=>"10362003, KYURI, BABY, 12,232"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>23000.0, :full_parsed_line=>"23802009, SUNBELL, TUNA, VEG, 185, 23,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>52302.0, :full_parsed_line=>"10082157, AVOCADO, MENTEGA, 52,302"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>56500.0, :full_parsed_line=>"10410109, ONI, BOM, R500, SUNRISE, 56,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14696.0, :full_parsed_line=>"10362003, KYURI, BABY, 14,696"}],
         438480.0,
         nil]
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
        [[{:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>184500.0, :full_parsed_line=>"Organic, Whole, Chicken, 1, Rp184,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>132500.0,
           :full_parsed_line=>"Little, Smokey, Cheese, Sausage, 1, Rp132,500"},
          {:category_name=>"Еда", :sub_category_name=>"Рыба", :price=>145000.0, :full_parsed_line=>"Gold, Band, Snapper, Fillet, 1, Rp145,000"},
          {:category_name=>"Еда", :sub_category_name=>"Яйца", :price=>48000.0, :full_parsed_line=>"Eggs, 16, Rp48,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>46000.0, :full_parsed_line=>"Goat, Kefir, 1, Rp46,000"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>57500.0, :full_parsed_line=>"Mozzarella, Low, Fat, 1, Rp57,500"},
          {:category_name=>"Еда", :sub_category_name=>"Молочка", :price=>122000.0, :full_parsed_line=>"Cheese, Alpine, 1, Rp122,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>20000.0, :full_parsed_line=>"Lemon, Certified, Organic, 1, Rp20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>16000.0, :full_parsed_line=>"Pineapple, 1, Rp16,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"Cucumber, Local, Organic, 1, Rp15,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>12500.0, :full_parsed_line=>"Green, Onion, Organic, 1, Rp12,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>26000.0, :full_parsed_line=>"Beetroot, Certified, Organic, 1, Rp26,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>20000.0, :full_parsed_line=>"Arugula, Wild, Organic, 1, Rp20,000"},
          {:category_name=>"Еда", :sub_category_name=>"Фрукты", :price=>8000.0, :full_parsed_line=>"Sweet, Corn, 1, Rp8,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>15000.0, :full_parsed_line=>"Potato, 1, Rp15,000"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>13500.0, :full_parsed_line=>"Baby, Carrot, Organic, 1, Rp13,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>33000.0, :full_parsed_line=>"Cabbage, Green, Large, 1, Rp33,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Овощи",
           :price=>18000.0,
           :full_parsed_line=>"Mix, Plum, Cherry, Tomato, Certified, 1, Rp18,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>91500.0, :full_parsed_line=>"Beef, Cubes, Organic, 1, Rp91,500"},
          {:category_name=>"Еда", :sub_category_name=>"Овощи", :price=>14000.0, :full_parsed_line=>"Tomato, 1, Rp14,000"},
          {:category_name=>"Еда", :sub_category_name=>"Специи, приправы", :price=>33500.0, :full_parsed_line=>"Tomato, Puree, 1, Rp33,500"},
          {:category_name=>"Еда",
           :sub_category_name=>"Сладости",
           :price=>40000.0,
           :full_parsed_line=>"Cookonuts, Dulce, de, Leche, Cookies, 1, Rp40,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Полуфабрикаты/морозилка",
           :price=>130000.0,
           :full_parsed_line=>"Syrniki, Classic, 1, Rp130,000"},
          {:category_name=>"Еда",
           :sub_category_name=>"Молочка",
           :price=>75000.0,
           :full_parsed_line=>"Sourdough, Coconut, Milk, Bread, 1, Rp75,000"},
          {:category_name=>"Еда", :sub_category_name=>"Мясо", :price=>64500.0, :full_parsed_line=>"Beef, Pastrami, 1, Rp64,500"}],
         1381000.0,
         nil]
      )
      expect(sum_of_prices).to eq(result[1])
    end
  end
end
