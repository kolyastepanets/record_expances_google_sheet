module DetectCategoryAndSubcategoryFromLine
  class TescoShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def sweets?
      tiramisu? || milk_biscuit? || milka_chocolate? || choco_milk? || kinder? ||
        chocolate_bar? || bounty? || snickers?
    end

    def tiramisu?
      @line.include?('tiramisu')
    end

    def milk_biscuit?
      @line.include?('milk') && @line.include?('biscuit')
    end

    def milka_chocolate?
      @line.include?('milka') && @line.include?('chocolate')
    end

    def choco_milk?
      @line.include?('choco') && @line.include?('milk')
    end

    def kinder?
      @line.include?('kinder')
    end

    def chocolate_bar?
      @line.include?('chocolate') && @line.include?('bar')
    end

    def bounty?
      @line.include?('bounty')
    end

    def snickers?
      @line.include?('snickers')
    end

    ####

    def ready_to_eat?
      beef_bolognese?
    end

    def beef_bolognese?
      @line.include?('beef') && @line.include?('bolognese')
    end

    ####

    def dairy?
      salt_butter? || philadelphia_cheese? || soured_cream? || cravendale_milk? || cheese_slices? ||
        butter? || double_cream? || mozzarella? || ricotta_cheese? || yeo_valley_organic? ||
        cream_double?
    end

    def salt_butter?
      @line.include?('salted') && @line.include?('butter')
    end

    def philadelphia_cheese?
      @line.include?('philadelphia') && @line.include?('cheese')
    end

    def soured_cream?
      @line.include?('soured') && @line.include?('cream')
    end

    def cravendale_milk?
      @line.include?('cravendale') && @line.include?('milk')
    end

    def cheese_slices?
      @line.include?('cheese') && @line.include?('slices')
    end

    def butter?
      @line.include?('butter')
    end

    def double_cream?
      @line.include?('thick') && @line.include?('dbl') && @line.include?('crm')
    end

    def mozzarella?
      @line.include?('mozzarella')
    end

    def ricotta_cheese?
      @line.include?('ricotta') && @line.include?('cheese')
    end

    def yeo_valley_organic?
      @line.include?('yeo') && @line.include?('valley') && @line.include?('organic')
    end

    def cream_double?
      @line.include?('double') && @line.include?('cream')
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
      mayonnaise? || lime_juice? || sunflower_oil? || olive_oil? || bay_leaves? || soy_sauce? ||
        distilled_vinegar? || sea_salt? || bicarbonate_soda? || oetker_vanilla_extract? ||
        sesame_oil? || ground_turmeric? || schwartz_sesame_seeds? || garam_masala_spice?
    end

    def mayonnaise?
      @line.include?('mayonnaise')
    end

    def lime_juice?
      @line.include?('lime') && @line.include?('juice')
    end

    def sunflower_oil?
      @line.include?('sunflower') && @line.include?('oil')
    end

    def olive_oil?
      @line.include?('olive') && @line.include?('oil')
    end

    def bay_leaves?
      @line.include?('bay') && @line.include?('leaves')
    end

    def soy_sauce?
      @line.include?('soy') && @line.include?('sauce')
    end

    def distilled_vinegar?
      @line.include?('distilled') && @line.include?('vinegar')
    end

    def sea_salt?
      @line.include?('sea') && @line.include?('salt')
    end

    def bicarbonate_soda?
      @line.include?('bicarbonate') && @line.include?('soda')
    end

    def oetker_vanilla_extract?
      @line.include?('oetker') && @line.include?('vanilla') && @line.include?('extract')
    end

    def sesame_oil?
      @line.include?('sesame') && @line.include?('oil')
    end

    def ground_turmeric?
      @line.include?('ground') && @line.include?('turmeric')
    end

    def schwartz_sesame_seeds?
      @line.include?('schwartz') && @line.include?('sesame') && @line.include?('seeds')
    end

    def garam_masala_spice?
      @line.include?('garam') && @line.include?('masala') && @line.include?('spice')
    end

    ####

    def kitchen_stuff?
      washing_capsules? || platter? || kitchen_foil? || baking_paper_sheets? || glass_bowl? ||
        dishwasher_salt? || plastic_bowl?
    end

    def washing_capsules?
      @line.include?('washing') && @line.include?('capsules')
    end

    def platter?
      @line.include?('platter')
    end

    def kitchen_foil?
      @line.include?('kitchen') && @line.include?('foil')
    end

    def baking_paper_sheets?
      @line.include?('baking') && @line.include?('paper') && @line.include?('sheets')
    end

    def glass_bowl?
      @line.include?('glass') && @line.include?('bowl')
    end

    def dishwasher_salt?
      @line.include?('dishwasher') && @line.include?('salt')
    end

    def plastic_bowl?
      @line.include?('plastic') && @line.include?('bowl')
    end

    ####

    def tea_or_coffee?
    end

    ####

    def alcohol?
      italian_wine? || australian_shiraz?
    end

    def italian_wine?
      @line.include?('italian') && @line.include?('wine')
    end

    def australian_shiraz?
      @line.include?('australian') && @line.include?('shiraz')
    end

    ####

    def food_bag_or_delivery?
    end

    ####

    def vegetables?
      asparagus? || avocado? || radish? || frozen_onions? || carrots? || garden_peas? ||
        potatoes? || cucumbers? || peppers? || garlic? || finest_piccobella? || broccoli? ||
        baby_spinach? || fresh_wild_rocket? || white_cabbage? || parsley? || courgettes_loose? ||
        avocados? || cherry_tomatoes? || romaine_lettuce_hearts? || onions? || fresh_coriander? ||
        savoy_cabbage? || classic_tomatoes? || celeriac? || dill? || coriander? || red_chillies? ||
        root_ginger?
    end

    def asparagus?
      @line.include?('asparagus')
    end

    def avocado?
      @line.include?('avocado')
    end

    def radish?
      @line.include?('radish')
    end

    def frozen_onions?
      @line.include?('frozen') && @line.include?('onions')
    end

    def carrots?
      @line.include?('carrots')
    end

    def garden_peas?
      @line.include?('garden') && @line.include?('peas')
    end

    def potatoes?
      @line.include?('potatoes')
    end

    def cucumbers?
      @line.any? { |word| word.include?('cucumber') }
    end

    def peppers?
      @line.include?('peppers')
    end

    def garlic?
      @line.include?('garlic')
    end

    def finest_piccobella?
      @line.include?('finest') && @line.include?('piccobella')
    end

    def broccoli?
      @line.include?('broccoli')
    end

    def baby_spinach?
      @line.include?('baby') && @line.include?('spinach')
    end

    def fresh_wild_rocket?
      @line.include?('fresh') && @line.include?('wild') && @line.include?('rocket')
    end

    def white_cabbage?
      @line.include?('white') && @line.include?('cabbage')
    end

    def parsley?
      @line.include?('parsley')
    end

    def courgettes_loose?
      @line.include?('courgettes') && @line.include?('loose')
    end

    def avocados?
      @line.include?('avocados')
    end

    def cherry_tomatoes?
      @line.include?('cherry') && @line.include?('tomatoes')
    end

    def romaine_lettuce_hearts?
      @line.include?('romaine') && @line.include?('lettuce') && @line.include?('hearts')
    end

    def onions?
      @line.include?('onions')
    end

    def fresh_coriander?
      @line.include?('fresh') && @line.include?('coriander')
    end

    def savoy_cabbage?
      @line.include?('savoy') && @line.include?('cabbage')
    end

    def classic_tomatoes?
      @line.include?('tomatoes')
    end

    def celeriac?
      @line.include?('celeriac')
    end

    def dill?
      @line.include?('dill')
    end

    def coriander?
      @line.include?('coriander') && @line.include?('pot')
    end

    def red_chillies?
      @line.include?('red') && @line.include?('chillies')
    end

    def root_ginger?
      @line.include?('root') && @line.include?('ginger')
    end

    ####

    def sausage_and_sausages?
      paw_patrol? || unsmoked_bacon? || roast_ham? || cooked_ham? || morliny_wiejska_slices? ||
        sopocka_pork_slice? || frankfurter_hot_dogs? || chopped_pork_ham?
    end

    def paw_patrol?
      @line.include?('paw') && @line.include?('patrol') && @line.include?('slices')
    end

    def unsmoked_bacon?
      @line.include?('unsmoked') && @line.include?('bacon')
    end

    def roast_ham?
      @line.include?('roast') && @line.include?('ham')
    end

    def cooked_ham?
      @line.include?('cooked') && @line.include?('ham')
    end

    def morliny_wiejska_slices?
      @line.include?('morliny') && @line.include?('wiejska') && @line.include?('slices')
    end

    def sopocka_pork_slice?
      @line.include?('sopocka') && @line.include?('pork') && @line.include?('slice')
    end

    def frankfurter_hot_dogs?
      @line.include?('frankfurter') && @line.include?('hot') && @line.include?('dogs')
    end

    def chopped_pork_ham?
      @line.include?('chopped') && @line.include?('pork') && @line.include?('ham')
    end

    ####

    def meat?
      chicken? || meatballs? || chicken_fillet? || chicken_drumsticks_2? || lean_diced_beef? ||
        chicken_breast_portions? || pork_ribs? || chicken_legs? || turkey_drumsticks? ||
        chicken_wings? || lamb_chops? || farms_pork_chops?
    end

    def chicken?
      @line.include?('chicken')
    end

    def meatballs?
      @line.include?('meatballs')
    end

    def chicken_fillet?
      @line.include?('chicken') && @line.include?('fillet')
    end

    def chicken_drumsticks_2?
      @line.include?('tesco') && @line.include?('room') && @line.include?('to') && @line.include?('roam') && @line.include?('british')
    end

    def lean_diced_beef?
      @line.include?('diced') && @line.include?('beef')
    end

    def chicken_breast_portions?
      @line.include?('chicken') && @line.include?('breast') && @line.include?('portions')
    end

    def pork_ribs?
      @line.include?('pork') && @line.include?('ribs')
    end

    def chicken_legs?
      @line.include?('chicken') && @line.include?('legs')
    end

    def turkey_drumsticks?
      @line.include?('turkey') && @line.include?('drumsticks')
    end

    def chicken_wings?
      @line.include?('chicken') && @line.include?('wings')
    end

    def lamb_chops?
      @line.include?('lamb') && @line.include?('chops')
    end

    def farms_pork_chops?
      @line.include?('farms') && @line.include?('pork') && @line.include?('chops')
    end

    ####

    def bread?
      wraps? || sliced_bread? || flour? || bread_1? || bake_home_petit? || white_ciabattin_sourdough? ||
        baking_powder? || grains_seeds?
    end

    def wraps?
      @line.include?('wraps') && @line.include?('tortilla')
    end

    def sliced_bread?
      @line.include?('sliced') && @line.include?('white') && @line.include?('loaf')
    end

    def flour?
      @line.include?('flour')
    end

    def bread_1?
      @line.include?('bread')
    end

    def bake_home_petit?
      @line.include?('bake') && @line.include?('home') && @line.include?('petit')
    end

    def white_ciabattin_sourdough?
      @line.include?('white') && @line.include?('ciabattin') && @line.include?('sourdough')
    end

    def baking_powder?
      @line.include?('baking') && @line.include?('powder')
    end

    def grains_seeds?
      @line.include?('grains') && @line.include?('seeds')
    end

    ####

    def bath_stuff?
      shower_gel? || shaving_foam? || oxi_powder_whites? || bathroom_cleaner_cif?
    end

    def shower_gel?
      @line.include?('shower') && @line.include?('gel')
    end

    def shaving_foam?
      @line.include?('shaving') && @line.include?('foam')
    end

    def oxi_powder_whites?
      @line.include?('oxi') && @line.include?('powder') && @line.include?('whites')
    end

    def bathroom_cleaner_cif?
      @line.include?('bathroom') && @line.include?('cleaner') && @line.include?('cif')
    end

    ####

    def home_stuff?
      cleaning_spray? || peonies?
    end

    def cleaning_spray?
      @line.include?('cleaning') && @line.include?('spray')
    end

    def peonies?
      @line.include?('peonies')
    end

    ####

    def fish?
      prawns? || smoked_salmon? || sea_food_stick? || cooked_mussels? ||
        graal_sprats_in_tomato_sauce? || tuna_chunks? || sea_bass_fillets? || boneless_fillets? ||
        raw_scallops?
    end

    def prawns?
      @line.include?('prawns')
    end

    def smoked_salmon?
      @line.include?('smoked') && @line.any? { |word| word.include?('salmo') }
    end

    def sea_food_stick?
      @line.include?('seafood') && @line.include?('stick')
    end

    def cooked_mussels?
      @line.include?('cooked') && @line.include?('mussels')
    end

    def graal_sprats_in_tomato_sauce?
      @line.include?('graal') && @line.include?('sprats') && @line.include?('tomato') && @line.include?('sauce')
    end

    def tuna_chunks?
      @line.include?('tuna') && @line.include?('chunks')
    end

    def sea_bass_fillets?
      @line.include?('sea') && @line.include?('bass') && @line.include?('fillets')
    end

    def boneless_fillets?
      @line.include?('boneless') && @line.include?('fillets')
    end

    def raw_scallops?
      @line.include?('raw') && @line.include?('scallops')
    end

    ####

    def grocery?
      basmati_rice? || spaghetti_pasta? || tagliatelle_pasta? || cous_cous? || cecco_fusilli? ||
        lubella_pasta?
    end

    def basmati_rice?
      @line.include?('basmati') && @line.include?('rice')
    end

    def spaghetti_pasta?
      @line.include?('spaghetti') && @line.include?('pasta')
    end

    def tagliatelle_pasta?
      @line.include?('tagliatelle') && @line.include?('pasta')
    end

    def cous_cous?
      @line.include?('cous') && @line.include?('cous')
    end

    def cecco_fusilli?
      @line.include?('cecco') && @line.include?('fusilli')
    end

    def lubella_pasta?
      @line.include?('lubella') && @line.include?('pasta')
    end

    ####

    def ready_to_cook?
      baked_beans? || french_fries? || panini_pack?
    end

    def baked_beans?
      @line.include?('baked') && @line.include?('beans')
    end

    def french_fries?
      @line.include?('french') && @line.include?('fries')
    end

    def panini_pack?
      @line.include?('panini') && @line.include?('pack')
    end

    ####

    def food_bag_or_delivery?
      pack_and_delivery? || bag?
    end

    def pack_and_delivery?
      @line.include?('pack') && @line.any? { |word| word.include?('deliver') }
    end

    def bag?
      @line.include?('bag')
    end

    ####

    def for_beer?
      crisps?
    end

    def crisps?
      @line.include?('crisps')
    end

    ####

    def fruits?
      blackberries? || strawberries? || pears? || bananas? || apples? || nectarines? || sweetcorn? ||
        sugarsnap_peas? || blueberries? || raspberries? || large_kiwi? || cherries? || limes? ||
        melon?
    end

    def blackberries?
      @line.include?('blackberries')
    end

    def strawberries?
      @line.include?('strawberries')
    end

    def pears?
      @line.include?('pears')
    end

    def bananas?
      @line.include?('bananas')
    end

    def apples?
      @line.include?('apple') && @line.include?('golden')
    end

    def nectarines?
      @line.include?('nectarines')
    end

    def sweetcorn?
      @line.include?('sweetcorn')
    end

    def sugarsnap_peas?
      @line.include?('sugarsnap') && @line.include?('peas')
    end

    def blueberries?
      @line.include?('blueberries')
    end

    def raspberries?
      @line.include?('raspberries')
    end

    def large_kiwi?
      @line.include?('large') && @line.include?('kiwi')
    end

    def cherries?
      @line.include?('cherries')
    end

    def limes?
      @line.include?('limes')
    end

    def melon?
      @line.include?('melon')
    end

    ####

    def water?
      apple_juice? || orange_mango_juice?
    end

    def apple_juice?
      @line.include?('apple') && @line.include?('juice')
    end

    def orange_mango_juice?
      @line.include?('orange') && @line.include?('mango') && @line.include?('juice')
    end
  end
end
