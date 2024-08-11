module DetectCategoryAndSubcategoryFromLine
  class LidlShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def sweets?
      choc_cookies? || ice_cream? || choc_biscuit? || kit_kat? || almond_chocolate? ||
        kinder_milk_slice? || snickers? || milk_chocolate? || whole_nut_chocolate? || shortcrust_biscuits? ||
        cornish_vanilla? || cadbury_wispa? || choc_fingers? || vanilla_cupcake? || fruit_pastille_lolly? ||
        micr_popcorn_sweet? || nutella? || caramel_peanut_bars? || kinder_bueno? || twix? ||
        darkchoc_ginger_bisc? || shortbread_rounds? || custard_creams? || fruit_drop_citrus? || fruitastic_mix? ||
        caramel_squares? || whitecaramel_squares? || milky_way? || mini_milk_cream? || rocket_lollies? ||
        fruit_spiral_lollies? || paw_patrol?
    end

    def choc_cookies?
      @line.include?('choc') && @line.include?('cookies')
    end

    def ice_cream?
      @line.include?('fruit') && @line.include?('tower') && @line.include?('icecream')
    end

    def choc_biscuit?
      @line.include?('choc') && @line.any? { |word| word.include?('bis') }
    end

    def kit_kat?
      @line.include?('kitkat')
    end

    def almond_chocolate?
      @line.include?('almondmilk') && @line.include?('chocolate')
    end

    def kinder_milk_slice?
      @line.include?('kinder') && @line.include?('milk') && @line.include?('slice')
    end

    def snickers?
      @line.include?('snickers')
    end

    def milk_chocolate?
      @line.include?('milk') && @line.include?('chocolate')
    end

    def whole_nut_chocolate?
      @line.include?('wholenutchocolate')
    end

    def shortcrust_biscuits?
      @line.include?('shortcrust') && @line.include?('biscuits')
    end

    def cornish_vanilla?
      @line.include?('cornish') && @line.include?('vanilla')
    end

    def cadbury_wispa?
      @line.include?('cadbury') && @line.include?('wispa')
    end

    def choc_fingers?
      @line.include?('choc') && @line.include?('fingers')
    end

    def vanilla_cupcake?
      @line.include?('vanilla') && @line.include?('cupcake')
    end

    def fruit_pastille_lolly?
      @line.include?('fruit') && @line.include?('pastille') && @line.include?('lolly')
    end

    def micr_popcorn_sweet?
      @line.include?('micr') && @line.include?('popcorn') && @line.include?('sweet')
    end

    def nutella?
      @line.include?('nutella')
    end

    def caramel_peanut_bars?
      @line.include?('caramel') && @line.include?('peanut') && @line.include?('bars')
    end

    def kinder_bueno?
      @line.include?('kinder') && @line.include?('bueno')
    end

    def twix?
      @line.include?('twix')
    end

    def darkchoc_ginger_bisc?
      @line.include?('darkchoc') && @line.include?('ginger') && @line.include?('bisc')
    end

    def shortbread_rounds?
      @line.include?('shortbread') && @line.include?('rounds')
    end

    def custard_creams?
      @line.include?('custard') && @line.include?('creams')
    end

    def fruit_drop_citrus?
      @line.include?('fruit') && @line.include?('drop') && @line.include?('citrus')
    end

    def fruitastic_mix?
      @line.include?('fruitastic') && @line.include?('mix')
    end

    def caramel_squares?
      @line.include?('caramel') && @line.include?('squares')
    end

    def whitecaramel_squares?
      @line.include?('whitecaramel') && @line.include?('squares')
    end

    def milky_way?
      @line.include?('milky') && @line.include?('way')
    end

    def mini_milk_cream?
      @line.include?('mini') && @line.include?('milk') && @line.include?('cream')
    end

    def rocket_lollies?
      @line.include?('rocket') && @line.include?('lollies')
    end

    def fruit_spiral_lollies?
      @line.include?('fruit') && @line.include?('spiral') && @line.include?('lollies')
    end

    def paw_patrol?
      @line.include?('paw') && @line.include?('patrol')
    end

    ####

    def ready_to_eat?
    end

    ####

    def dairy?
      milk? || butter? || maasdam_cheese? || milk_2? || mozzarella_cheese? || maasdam_slices? ||
        petitsfilous_big_pot? || chocolate_pudding? || yogurt? || ricotta? || mascarpone? ||
        pineapple_cheese? || double_cream? || parmigiano_reggiano? || soured_cream? ||
        cottage_cheese? || elmleadoublecreamsub? || cheese_slices?
    end

    def milk?
      @line.include?('milk') && @line.include?('semiskim')
    end

    def butter?
      @line.any? { |word| word.include?('butter') } && @line.any? { |word| word.include?('salted') }
    end

    def maasdam_cheese?
      @line.include?('slices') && @line.include?('1.89')
    end

    def milk_2?
      @line.include?('milk') && @line.include?('whole')
    end

    def mozzarella_cheese?
      @line.include?('mozzarella')
    end

    def maasdam_slices?
      @line.include?('maasdam') && @line.include?('slices')
    end

    def petitsfilous_big_pot?
      @line.include?('petitsfilous') && @line.include?('big') && @line.include?('pot')
    end

    def chocolate_pudding?
      @line.include?('chocolate') && @line.include?('pudding')
    end

    def yogurt?
      @line.include?('yogurt') || @line.include?('yoghurt')
    end

    def ricotta?
      @line.include?('ricotta')
    end

    def mascarpone?
      @line.include?('mascarpone')
    end

    def pineapple_cheese?
      @line.include?('pineapple') && @line.include?('cheese')
    end

    def double_cream?
      @line.include?('double') && @line.include?('cream')
    end

    def parmigiano_reggiano?
      @line.include?('parmigiano') && @line.include?('reggiano')
    end

    def soured_cream?
      @line.include?('soured') && @line.include?('cream')
    end

    def cottage_cheese?
      @line.include?('cottage') && @line.include?('cheese')
    end

    def elmleadoublecreamsub?
      @line.include?('elmleadoublecreamsub')
    end

    def cheese_slices?
      @line.include?('cheese') && @line.include?('slices')
    end

    ####

    def eggs?
      eggs_1?
    end

    def eggs_1?
      @line.include?('eggs')
    end

    ####

    def spices_and_seasonings?
      tomato_sauce? || oil? || sugar? || bicarbonate_soda? || squeezy_honey? || squeezy_real_mayo? ||
        dried_yeast? || lemon_juice?
    end

    def tomato_sauce?
      @line.include?('italian') && @line.include?('passata')
    end

    def oil?
      @line.include?('oil')
    end

    def sugar?
      @line.include?('sugar')
    end

    def bicarbonate_soda?
      @line.include?('bicarbonate') && @line.include?('soda')
    end

    def squeezy_honey?
      @line.include?('squeezy') && @line.include?('honey')
    end

    def squeezy_real_mayo?
      @line.include?('squeezy') && @line.include?('real') && @line.include?('mayo')
    end

    def dried_yeast?
      @line.include?('dried') && @line.include?('yeast')
    end

    def lemon_juice?
      @line.include?('lemon') && @line.include?('juice')
    end

    ####

    def kitchen_stuff?
      salt_shaker? || trash_bag? || trash_bag_2? || fairy? || dishwasher_tablets? || dishwasher_salt? ||
        microfibre_cloths? || white_facial_tissue?
    end

    def salt_shaker?
      @line.include?('saltshakercoursesalt')
    end

    def trash_bag?
      @line.include?('bio') && @line.include?('caddy') && @line.include?('liners')
    end

    def trash_bag_2?
      @line.include?('recrefusesack') && @line.include?('tietop')
    end

    def fairy?
      @line.include?('fairy') && @line.include?('liquidoriginal')
    end

    def dishwasher_tablets?
      @line.include?('dishwasher') && @line.include?('tablets')
    end

    def dishwasher_salt?
      @line.include?('dishwasher') && @line.include?('salt')
    end

    def microfibre_cloths?
      @line.include?('microfibre') && @line.include?('cloths')
    end

    def white_facial_tissue?
      @line.include?('white') && @line.include?('facial') && @line.include?('tissue')
    end

    ####

    def tea_or_coffee?
      indonesia_coffee? || nesquik? || tea? || coffee_pod?
    end

    def indonesia_coffee?
      @line.include?('indonesia') && @line.include?('instant')
    end

    def nesquik?
      @line.include?('nesquik') && @line.include?('chocolate')
    end

    def tea?
      @line.include?('tea')
    end

    def coffee_pod?
      @line.include?('coffee') && @line.include?('pod')
    end

    ####

    def alcohol?
      berries_wine? || south_africa_wine? || french_malbec? || pinot_grigio_terre?
    end

    def berries_wine?
      @line.include?('berries') && @line.include?('wine')
    end

    def south_africa_wine?
      @line.include?('south') && @line.include?('african') && @line.include?('shiraz')
    end

    def french_malbec?
      @line.include?('french') && @line.include?('malbec')
    end

    def pinot_grigio_terre?
      @line.include?('pinot') && @line.include?('grigio') && @line.include?('terre')
    end

    ####

    def food_bag_or_delivery?
      bag?
    end

    def bag?
      @line.include?('carrier')
    end

    ####

    def vegetables?
      red_onion? || potatoes? || carrots? || cucumbers? || dill? ||
        cabbage? || beetroot? || tomatoes? || radish? || mixed_peppers? || fresh_parsley? ||
        spinach_rocket? || garden_salad? || pepper_red_loose? || avocados? ||
        iceberg_lettuce? || italian_salad?
    end

    def red_onion?
      @line.include?('red') && @line.include?('onions')
    end

    def potatoes?
      @line.include?('potatoes')
    end

    def carrots?
      @line.include?('carrots')
    end

    def piccolo_tomatoes?
      @line.include?('piccolo') && @line.include?('tomatoes')
    end

    def cucumbers?
      @line.include?('cucumbers')
    end

    def dill?
      (@line.include?('d111') || @line.include?('dill')) && @line.include?('fresh')
    end

    def cabbage?
      @line.include?('cabbage')
    end

    def beetroot?
      @line.include?('beetroot')
    end

    def tomatoes?
      (@line.include?('scarlet') || @line.include?('vine') || @line.include?('marvellous') || @line.include?('piccolo') || @line.include?('baby')) && @line.include?('tomatoes')
    end

    def radish?
      @line.include?('radish')
    end

    def mixed_peppers?
      @line.include?('mixed') && @line.include?('peppers')
    end

    def fresh_parsley?
      @line.include?('fresh') && @line.include?('parsley')
    end

    def spinach_rocket?
      @line.include?('wcressspinachrocket')
    end

    def garden_salad?
      @line.include?('garden') && @line.include?('salad')
    end

    def pepper_red_loose?
      @line.include?('pepper') && @line.include?('red') && @line.include?('loose')
    end

    def avocados?
      @line.include?('avocados')
    end

    def iceberg_lettuce?
      @line.include?('iceberg') && @line.include?('lettuce')
    end

    def italian_salad?
      @line.include?('italian') && @line.include?('salad')
    end

    ####

    def sausage_and_sausages?
      krakauer_sausage? || silesian_sausage? || garlic_sausage? || chicken_frankfurters? ||
        smoked_salami? || ham_slices? || sliced_sausagewiejska? || pork_sausage? ||
        chicken_frankfurters? || polish_sausage? || smoked_ham?
    end

    def krakauer_sausage?
      @line.include?('krakauer') && @line.include?('sausage')
    end

    def silesian_sausage?
      @line.include?('silesian') && @line.include?('sausages')
    end

    def garlic_sausage?
      @line.include?('garlic') && @line.include?('sausage')
    end

    def chicken_frankfurters?
      @line.include?('chicken') && @line.include?('frankfurters')
    end

    def smoked_salami?
      @line.include?('smoked') && @line.include?('salami')
    end

    def ham_slices?
      @line.include?('ham') && @line.include?('slices')
    end

    def sliced_sausagewiejska?
      @line.include?('sliced') && @line.include?('sausagewiejska')
    end

    def pork_sausage?
      @line.include?('pork') && @line.include?('sausage')
    end

    def chicken_frankfurters?
      @line.include?('chicken') && @line.any? { |word| word.include?('frankfurters') }
    end

    def polish_sausage?
      @line.include?('polish') && @line.include?('sausage')
    end

    def smoked_ham?
      @line.include?('smoked') && @line.include?('ham')
    end

    ####

    def meat?
      beef_steak? || mince? || chicken_wings? || plain_kebabs? || chi_thigh_fillet? || pork_loinsteaks? ||
        beef_steak_2? || pork_shoulder? || chicken_fillets? || corned_beef? || chicken_meatball_gravy?
    end

    def beef_steak?
      @line.include?('frying') && @line.include?('stea')
    end

    def mince?
      @line.include?('mince')
    end

    def chicken_wings?
      @line.include?('chicken') && @line.include?('wings')
    end

    def plain_kebabs?
      @line.include?('plain') && @line.include?('kebabs')
    end

    def chi_thigh_fillet?
      @line.include?('chi') && @line.include?('thighfillet')
    end

    def pork_loinsteaks?
      @line.include?('pork') && @line.include?('loinsteaks')
    end

    def beef_steak_2?
      @line.include?('beef') && @line.include?('steak')
    end

    def pork_shoulder?
      @line.include?('pork') && @line.include?('shoulder')
    end

    def chicken_fillets?
      @line.include?('chicken') && @line.include?('fillets')
    end

    def corned_beef?
      @line.include?('corned') && @line.include?('beef')
    end

    def chicken_meatball_gravy?
      @line.include?('chicken') && @line.include?('meatballgravy')
    end

    ####

    def bread?
      baguette? || sourdoug? || buns? || palmier_puff_pastry? || medium_loaf_white? ||
        chocolate_croissant? || pink_doughnut? || doughunt? || belgian_bun? || croissant? ||
        jam_football_muffin? || sliced_focaccia?
    end

    def baguette?
      @line.include?('baguette')
    end

    def sourdoug?
      @line.include?('sourdoug') && @line.include?('white')
    end

    def buns?
      @line.include?('buns')
    end

    def palmier_puff_pastry?
      @line.include?('palmier') && @line.include?('puff') && @line.include?('pasa')
    end

    def medium_loaf_white?
      @line.include?('medium') && @line.include?('white')
    end

    def chocolate_croissant?
      @line.include?('pain') && @line.include?('chocolat')
    end

    def pink_doughnut?
      @line.any? { |word| word.include?('pink') } && @line.any? { |word| word.include?('doughnut') }
    end

    def doughunt?
      @line.include?('doughnut') && @line.include?('choc')
    end

    def belgian_bun?
      @line.include?('belgian') && @line.include?('bun')
    end

    def croissant?
      @line.any? { |word| word.include?('croissant') }
    end

    def jam_football_muffin?
      @line.include?('jam') && @line.include?('football') && @line.include?('muffin')
    end

    def sliced_focaccia?
      @line.include?('sliced') && @line.include?('focaccia')
    end

    ####

    def bath_stuff?
      luquid_soap? || toilet_paper? || domestos_Bleach_blue? || dental_sticks? || premium_white_toilet? ||
        toilet_tissue? || cotton_buds? || kids_toothbrush?
    end

    def luquid_soap?
      @line.include?('hand') && @line.include?('wash')
    end

    def toilet_paper?
      @line.include?('andrex') && @line.include?('coconut') && @line.include?('fresh')
    end

    def domestos_Bleach_blue?
      @line.include?('domestos') && @line.include?('bleach') && @line.include?('blue')
    end

    def dental_sticks?
      @line.include?('dental') && @line.include?('sticks')
    end

    def premium_white_toilet?
      @line.include?('premium') && @line.include?('white') && @line.include?('toilet')
    end

    def toilet_tissue?
      @line.include?('toilet') && @line.include?('tissue')
    end

    def cotton_buds?
      @line.include?('cotton') && @line.include?('buds')
    end

    def kids_toothbrush?
      @line.include?('kids') && @line.include?('toothbrush')
    end

    ####

    def home_stuff?
      flowers? || houseplant_ceramic? || glasses_wipes? || pot_flower? || sempervivum_mixed? ||
        green_houseplants?
    end

    def flowers?
      @line.include?('quality') && @line.include?('roses')
    end

    def houseplant_ceramic?
      @line.include?('houseplant') && @line.include?('ceramic')
    end

    def glasses_wipes?
      @line.include?('glasses') && @line.include?('wipes')
    end

    def pot_flower?
      @line.include?('hosta')
    end

    def sempervivum_mixed?
      @line.include?('sempervivum') && @line.include?('mixed')
    end

    def green_houseplants?
      @line.include?('green') && @line.include?('houseplants')
    end

    ####

    def water?
      apple_juice? || orange_juice? || mineral_water?
    end

    def apple_juice?
      @line.include?('apple') && @line.include?('juice')
    end

    def orange_juice?
      @line.include?('orange') && @line.include?('juice')
    end

    def mineral_water?
      @line.include?('mineral') && @line.include?('water')
    end

    ####

    def fish?
      salmon? || prawns?
    end

    def salmon?
      @line.any? { |word| word.include?('salmon') }
    end

    def prawns?
      @line.include?('prawns')
    end

    ####

    def for_beer?
      walkers?
    end

    def walkers?
      (@line.include?('walkors') || @line.include?('walkers')) && @line.include?('baked')
    end

    ####

    def fruits?
      plums? || mango? || strawberries? || bananas? || pomegranate? || cherries? || blueberries? ||
        mixed_grapes? || blackberries? || corn_cobettes? || raspberries? || sweet_easy_peelers? ||
        funsize_apples? || white_grapes? || peaches? || galia_melon? || pears? || nectarines?
    end

    def plums?
      @line.include?('plums') && (@line.include?('0080414') || @line.include?('0080417') || @line.include?('0080412'))
    end

    def mango?
      @line.include?('mango')
    end

    def strawberries?
      @line.include?('strawberries')
    end

    def bananas?
      @line.include?('bananas')
    end

    def pomegranate?
      @line.include?('pomegranate')
    end

    def cherries?
      @line.include?('cherries')
    end

    def blueberries?
      @line.include?('blueberries')
    end

    def mixed_grapes?
      @line.include?('mixed') && @line.include?('grapes')
    end

    def blackberries?
      @line.include?('blackberries')
    end

    def corn_cobettes?
      @line.include?('corn') && @line.include?('cobettes')
    end

    def raspberries?
      @line.include?('raspberries')
    end

    def sweet_easy_peelers?
      @line.include?('sweet') && @line.include?('easy') && @line.include?('peelers')
    end

    def funsize_apples?
      @line.include?('funsize') && @line.include?('apples')
    end

    def white_grapes?
      @line.include?('white') && @line.include?('grapes')
    end

    def peaches?
      @line.include?('peaches')
    end

    def galia_melon?
      @line.include?('galia') && @line.include?('melon')
    end

    def pears?
      @line.include?('pears')
    end

    def nectarines?
      @line.include?('nectarines')
    end

    ####

    def pampers?
      jumbo_pants?
    end

    def jumbo_pants?
      @line.include?('jumbo') && @line.include?('pants')
    end

    ####

    def grocery?
      porridge_oats?
    end

    def porridge_oats?
      @line.include?('porridge') && @line.include?('oats')
    end
  end
end
