module DetectCategoryAndSubcategoryFromLine
  class TescoShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def sweets?
      tiramisu? || milk_biscuit? || milka_chocolate? || choco_milk? || kinder? ||
        chocolate_bar? || bounty? || snickers? || milk_chocolate_cookie? || sponge_fingers? ||
        white_chocolate? || nutella_chocolate? || oreo? || caramel_cookies? || haribo_marshmallows? ||
        chocolate_tube? || chocolate_cake? || chocolate_milk? || raspberry_jam? || honey?
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

    def milk_chocolate_cookie?
      @line.include?('milk') && @line.include?('chocolate') && @line.include?('cookie')
    end

    def sponge_fingers?
      @line.include?('sponge') && @line.include?('fingers')
    end

    def white_chocolate?
      @line.include?('white') && @line.include?('chocolate')
    end

    def nutella_chocolate?
      @line.include?('nutella') && @line.include?('chocolate')
    end

    def oreo?
      @line.include?('oreo')
    end

    def caramel_cookies?
      @line.include?('caramel') && @line.include?('cookies')
    end

    def haribo_marshmallows?
      @line.include?('haribo') && @line.include?('marshmallows')
    end

    def chocolate_tube?
      @line.include?('chocolate') && @line.include?('tube')
    end

    def chocolate_cake?
      @line.include?('chocolate') && @line.include?('cake')
    end

    def chocolate_milk?
      @line.include?('chocolate') && @line.include?('milk')
    end

    def raspberry_jam?
      @line.include?('raspberry') && (@line.include?('conserve') || @line.include?('jam'))
    end

    def honey?
      @line.include?('honey') && @line.include?('organic')
    end

    ####

    def ready_to_eat?
      beef_bolognese? || liver_bacon? || mushroom_soup? || pizza_base?
    end

    def beef_bolognese?
      @line.include?('beef') && @line.include?('bolognese')
    end

    def liver_bacon?
      @line.include?('liver') && @line.include?('bacon')
    end

    def mushroom_soup?
      @line.include?('mushroom') && @line.include?('soup')
    end

    def pizza_base?
      @line.include?('pizza') && @line.include?('base')
    end

    ####

    def dairy?
      salt_butter? || philadelphia_cheese? || soured_cream? || cravendale_milk? || cheese_slices? ||
        butter? || double_cream? || mozzarella? || ricotta_cheese? || yeo_valley? ||
        cream_double? || mascarpone_cheese? || coconut_milk? || camembert? || cottage_cheese? ||
        reggiano_cheese? || biotiful_kefir? || soft_cheese?
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

    def yeo_valley?
      @line.include?('yeo') && @line.include?('valley')
    end

    def cream_double?
      @line.include?('double') && @line.include?('cream')
    end

    def mascarpone_cheese?
      @line.include?('mascarpone') && @line.include?('cheese')
    end

    def coconut_milk?
      @line.include?('coconut') && @line.include?('milk')
    end

    def camembert?
      @line.include?('camembert')
    end

    def cottage_cheese?
      @line.include?('cottage') && @line.include?('cheese')
    end

    def reggiano_cheese?
      @line.include?('reggiano') && @line.include?('cheese')
    end

    def biotiful_kefir?
      @line.include?('biotiful') && @line.include?('kefir')
    end

    def soft_cheese?
      @line.include?('soft') && @line.include?('cheese')
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
        sesame_oil? || ground_turmeric? || schwartz_sesame_seeds? || garam_masala_spice? ||
        growing_mint_pot? || fish_sauce? || lemongrass? || nori_sushi? || chilli_paste? || lime_leaves? ||
        dark_cocoa_powder? || tomato_ketchup? || white_breadcrumbs? || mustard? ||
        ground_nutmeg? || black_pepper? || cream_tartar? || sugar?
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

    def growing_mint_pot?
      @line.include?('growing') && @line.include?('mint') && @line.include?('pot')
    end

    def fish_sauce?
      @line.include?('fish') && @line.include?('sauce')
    end

    def lemongrass?
      @line.include?('lemongrass')
    end

    def nori_sushi?
      @line.include?('nori') && @line.include?('sushi')
    end

    def chilli_paste?
      @line.include?('chilli') && @line.include?('paste')
    end

    def lime_leaves?
      @line.include?('lime') && @line.include?('leaves')
    end

    def dark_cocoa_powder?
      @line.include?('dark') && @line.include?('cocoa') && @line.include?('powder')
    end

    def tomato_ketchup?
      @line.include?('tomato') && @line.include?('ketchup')
    end

    def white_breadcrumbs?
      @line.include?('white') && @line.include?('breadcrumbs')
    end

    def mustard?
      @line.include?('mustard')
    end

    def ground_nutmeg?
      @line.include?('ground') && @line.include?('nutmeg')
    end

    def black_pepper?
      @line.include?('black') && @line.include?('pepper')
    end

    def cream_tartar?
      @line.include?('cream') && @line.include?('tartar')
    end

    def sugar?
      @line.include?('sugar') && @line.include?('granulated')
    end

    ####

    def kitchen_stuff?
      washing_capsules? || platter? || kitchen_foil? || baking_paper_sheets? || glass_bowl? ||
        for_dishwasher? || plastic_bowl? || pvc_free_cling? || pyramid_grater? || surface_cleaning_wipes? ||
        tissues? || caddy_liners? || sponge?
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

    def for_dishwasher?
      @line.include?('dishwasher')
    end

    def plastic_bowl?
      @line.include?('plastic') && @line.include?('bowl')
    end

    def pvc_free_cling?
      @line.include?('pvc') && @line.include?('free') && @line.include?('cling')
    end

    def pyramid_grater?
      @line.include?('pyramid') && @line.include?('grater')
    end

    def surface_cleaning_wipes?
      @line.include?('surface') && @line.include?('cleaning') && @line.include?('wipes')
    end

    def tissues?
      @line.include?('tissues')
    end

    def caddy_liners?
      @line.include?('caddy') && @line.include?('liners')
    end

    def sponge?
      @line.include?('sponge')
    end

    ####

    def tea_or_coffee?
      coffee_pods? || coffee_capsules? || twinings_teabags? || twinings_camomile? || tea_bags?
    end

    def coffee_pods?
      @line.include?('coffee') && @line.include?('pods')
    end

    def coffee_capsules?
      @line.include?('coffee') && @line.include?('capsules')
    end

    def twinings_teabags?
      @line.include?('twinings') && @line.include?('teabags')
    end

    def twinings_camomile?
      @line.include?('twinings') && @line.include?('camomile')
    end

    def tea_bags?
      @line.include?('tea') && @line.include?('bags')
    end

    ####

    def alcohol?
      italian_wine? || australian_shiraz? || chardonnay? || sauvignon_blanc?
    end

    def italian_wine?
      @line.include?('italian') && @line.include?('wine')
    end

    def australian_shiraz?
      @line.include?('australian') && @line.include?('shiraz')
    end

    def chardonnay?
      @line.include?('chardonnay')
    end

    def sauvignon_blanc?
      @line.include?('sauvignon') && @line.include?('blanc')
    end

    ####

    def food_bag_or_delivery?
    end

    ####

    def vegetables?
      asparagus? || avocado? || radish? || frozen_onions? || carrots? || garden_peas? ||
        potatoes? || cucumbers? || peppers? || garlic? || finest_piccobella? || broccoli? ||
        baby_spinach? || rocket_salad? || white_cabbage? || parsley? || courgettes_loose? ||
        avocados? || cherry_tomatoes? || romaine_lettuce_hearts? || onions? || fresh_coriander? ||
        savoy_cabbage? || classic_tomatoes? || celeriac? || dill? || coriander? || red_chillies? ||
        root_ginger? || beetroot? || mushrooms? || basil_pot? || pot_rosemary? || mushroom_cluster? ||
        thyme_pot? || butternut_squash? || diced_onion? || fine_beans? || red_cabbage? || aubergine? ||
        mixed_vegetables? || baby_beans? || cannellini_beans? || spinach?
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
      @line.any? { |word| word.include?('carrot') }
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

    def rocket_salad?
      ((@line.include?('fresh') && @line.include?('wild')) || @line.include?('salads')) && @line.include?('rocket')
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

    def beetroot?
      @line.include?('beetroot')
    end

    def mushrooms?
      @line.include?('mushrooms')
    end

    def basil_pot?
      @line.include?('basil') && @line.include?('pot')
    end

    def pot_rosemary?
      @line.include?('pot') && @line.include?('rosemary')
    end

    def mushroom_cluster?
      @line.include?('mushroom') && @line.include?('cluster')
    end

    def thyme_pot?
      @line.include?('thyme') && @line.include?('pot')
    end

    def butternut_squash?
      @line.include?('butternut') && @line.include?('squash')
    end

    def diced_onion?
      @line.include?('diced') && @line.include?('onion')
    end

    def fine_beans?
      @line.include?('fine') && @line.include?('beans')
    end

    def red_cabbage?
      @line.include?('red') && @line.include?('cabbage')
    end

    def aubergine?
      @line.include?('aubergine')
    end

    def mixed_vegetables?
      @line.include?('mixed') && @line.include?('vegetables')
    end

    def baby_beans?
      @line.include?('baby') && @line.include?('beans')
    end

    def cannellini_beans?
      @line.include?('cannellini') && @line.include?('beans')
    end

    def spinach?
      @line.include?('spinach')
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
        chicken_wings? || lamb_chops? || farms_pork_chops? || pork_steak? || duck_fillets? ||
        pork_liver? || pork_belly? || turkey_breast? || lambs_hearts? || lamb_liver?
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
      @line.include?('pork') && @line.include?('chops')
    end

    def pork_steak?
      @line.include?('pork') && @line.any? { |word| word.include?('steak') }
    end

    def duck_fillets?
      @line.include?('duck') && @line.include?('fillets')
    end

    def pork_liver?
      @line.include?('pork') && @line.include?('liver')
    end

    def pork_belly?
      @line.include?('pork') && @line.include?('belly')
    end

    def turkey_breast?
      @line.include?('turkey') && @line.include?('breast')
    end

    def lambs_hearts?
      @line.include?('lambs') && @line.include?('hearts')
    end

    def lamb_liver?
      @line.include?('lamb') && @line.include?('liver')
    end

    ####

    def bread?
      wraps? || sliced_bread? || flour? || bread_1? || bake_home_petit? || white_sourdough? ||
        baking_powder? || grains_seeds? || sunflower_seeded_protein? || hot_dog_rolls? ||
        dried_yeast? || hearty_puddings? || chocolate_croissants?
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

    def white_sourdough?
      @line.include?('white') && @line.include?('sourdough')
    end

    def baking_powder?
      @line.include?('baking') && @line.include?('powder')
    end

    def grains_seeds?
      @line.include?('grains') && @line.include?('seeds')
    end

    def sunflower_seeded_protein?
      @line.include?('sunflower') && @line.include?('seeded') && @line.include?('protein')
    end

    def hot_dog_rolls?
      @line.include?('hot') && @line.include?('dog') && @line.include?('rolls')
    end

    def dried_yeast?
      @line.include?('dried') && @line.include?('yeast')
    end

    def hearty_puddings?
      @line.include?('hearty') && @line.include?('puddings')
    end

    def chocolate_croissants?
      @line.include?('chocolate') && @line.include?('croissants')
    end

    ####

    def bath_stuff?
      shower_gel? || shaving_foam? || oxi_powder_whites? || bathroom_cleaner_cif? || vanish_oxi? ||
        washing_machine_cleaner? || white_toilet_tissue? || colour_catcher_protection? ||
        away_foamspray?
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

    def vanish_oxi?
      @line.include?('vanish') && @line.include?('oxi')
    end

    def washing_machine_cleaner?
      @line.include?('washing') && @line.include?('machine') && @line.include?('cleaner')
    end

    def white_toilet_tissue?
      @line.include?('white') && @line.include?('toilet') && @line.include?('tissue')
    end

    def colour_catcher_protection?
      @line.include?('colour') && @line.include?('catcher') && @line.include?('protection')
    end

    def away_foamspray?
      @line.include?('away') && @line.include?('foamspray')
    end

    ####

    def home_stuff?
      cleaning_spray? || peonies? || dust_magnet_duster?
    end

    def cleaning_spray?
      @line.include?('cleaning') && @line.include?('spray')
    end

    def peonies?
      @line.include?('peonies')
    end

    def dust_magnet_duster?
      @line.include?('dust') && @line.include?('magnet') && @line.include?('duster')
    end

    ####

    def fish?
      prawns? || smoked_salmon? || sea_food_stick? || cooked_mussels? ||
        graal_sprats_in_tomato_sauce? || tuna_chunks? || sea_bass_fillets? || boneless_fillets? ||
        raw_scallops? || tuna_steaks? || seafood_selection? || salmon_fillets? ||
        boneless_cod_loins? || albacore_tuna?
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

    def tuna_steaks?
      @line.include?('tuna') && @line.include?('steaks')
    end

    def seafood_selection?
      @line.include?('seafood') && @line.include?('selection')
    end

    def salmon_fillets?
      @line.include?('salmon') && @line.include?('fillets')
    end

    def boneless_cod_loins?
      @line.include?('boneless') && @line.include?('cod') && @line.include?('loins')
    end

    def albacore_tuna?
      @line.include?('albacore') && @line.include?('tuna')
    end

    ####

    def grocery?
      basmati_rice? || spaghetti_pasta? || tagliatelle_pasta? || cous_cous? ||
        lubella_pasta? || sushi_rice? || spaghetti? || cecco? || rice_nnoodles?
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

    def cecco?
      @line.include?('cecco')
    end

    def lubella_pasta?
      @line.include?('lubella') && @line.include?('pasta')
    end

    def sushi_rice?
      @line.include?('sushi') && @line.include?('rice')
    end

    def spaghetti?
      @line.include?('spaghetti')
    end

    def rice_nnoodles?
      @line.include?('rice') && @line.include?('noodles')
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
      crisps? || mixed_nuts? || hula_hoops? || cashew? || brazil_nuts? || cashews?
    end

    def crisps?
      @line.include?('crisps')
    end

    def mixed_nuts?
      @line.include?('mixed') && @line.include?('nuts')
    end

    def hula_hoops?
      @line.include?('hula') && @line.include?('hoops')
    end

    def cashew?
      @line.include?('peanuts') && @line.include?('cashews')
    end

    def brazil_nuts?
      @line.include?('brazil') && @line.include?('nuts')
    end

    def cashews?
      @line.include?('cashews')
    end

    ####

    def fruits?
      blackberries? || strawberries? || pears? || bananas? || apples? || nectarines? || sweetcorn? ||
        sugarsnap_peas? || blueberries? || raspberries? || large_kiwi? || cherries? || limes? ||
        melon? || kiwi? || watermelon? || grapefruit? || plums? || jaffa_orange_pack? || grapes? ||
        figs? || sweet_peeler? || lemons? || persimmons? || pack_mango? || citrus_box? ||
        emperor_oranges? || seasonal_apples? || ripen_home_plum? || pomegranates_each?
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
      @line.include?('apple') && (@line.include?('golden') || @line.include?('pink'))
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

    def kiwi?
      @line.include?('kiwi')
    end

    def watermelon?
      @line.include?('watermelon')
    end

    def grapefruit?
      @line.include?('grapefruit')
    end

    def plums?
      @line.include?('plums')
    end

    def jaffa_orange_pack?
      @line.include?('jaffa') && @line.include?('orange') && @line.include?('pack')
    end

    def grapes?
      @line.include?('grapes')
    end

    def figs?
      @line.include?('figs')
    end

    def sweet_peeler?
      @line.include?('sweet') && @line.include?('peeler')
    end

    def lemons?
      @line.include?('lemons')
    end

    def persimmons?
      @line.include?('persimmons')
    end

    def pack_mango?
      @line.include?('pack') && @line.include?('mango')
    end

    def citrus_box?
      @line.include?('citrus') && @line.include?('box')
    end

    def emperor_oranges?
      @line.include?('emperor') && @line.include?('oranges')
    end

    def seasonal_apples?
      @line.include?('seasonal') && @line.include?('apples')
    end

    def ripen_home_plum?
      @line.include?('ripen') && @line.include?('home') && @line.include?('plum')
    end

    def pomegranates_each?
      @line.include?('pomegranates') && @line.include?('each')
    end

    ####

    def water?
      apple_juice? || orange_mango_juice? || coconut_water? || mineral_water? ||
        still_water?
    end

    def apple_juice?
      @line.include?('apple') && @line.include?('juice')
    end

    def orange_mango_juice?
      @line.include?('orange') && @line.include?('mango') && @line.include?('juice')
    end

    def coconut_water?
      @line.include?('coconut') && @line.include?('water')
    end

    def mineral_water?
      @line.include?('mineral') && @line.include?('water')
    end

    def still_water?
      @line.include?('still') && @line.include?('water')
    end
  end
end
