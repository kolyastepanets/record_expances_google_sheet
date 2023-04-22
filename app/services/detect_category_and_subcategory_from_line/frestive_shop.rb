module DetectCategoryAndSubcategoryFromLine
  class FrestiveShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine? || champagne? || beer_2? || wine_2?
    end

    def beer?
      @line.any? { |word| word.include?('bintang') }
    end

    def wine?
      @line.any? { |word| word.include?('hatten') }
    end

    def champagne?
      @line.any? { |word| word.include?('sababay') } && @line.any? { |word| word.include?('ascaro') }
    end

    def beer_2?
      @line.any? { |word| word.include?('bali') } && @line.any? { |word| word.include?('hai') } && @line.any? { |word| word.include?('can') }
    end

    def wine_2?
      @line.any? { |word| word.include?('wine') }
    end

    ####

    def eggs?
      @line.any? { |word| word.include?('egg') }
    end

    ####

    def water?
      coca_cola? || rauch_juice? || mixed_juice? || fanta? || jungle_juice? || nestle_water? ||
        aqua_water? || cheers_water? || mango_juice? || peach_juice?
    end

    def coca_cola?
      @line.any? { |word| word.include?('coca') } && @line.any? { |word| word.include?('cola') }
    end

    def rauch_juice?
      @line.any? { |word| word.include?('rauch') }
    end

    def mixed_juice?
      @line.any? { |word| word.include?('mixed') } && @line.any? { |word| word.include?('juice') }
    end

    def fanta?
      @line.any? { |word| word.include?('fanta') }
    end

    def jungle_juice?
      @line.any? { |word| word.include?('jungle') } && @line.any? { |word| word.include?('jc') }
    end

    def nestle_water?
      @line.any? { |word| word.include?('nestle') } && @line.any? { |word| word.include?('600ml') }
    end

    def aqua_water?
      @line.any? { |word| word.include?('aqua') } && @line.any? { |word| word.include?('water') }
    end

    def cheers_water?
      @line.any? { |word| word.include?('cheers') } && @line.any? { |word| word.include?('water') }
    end

    def mango_juice?
      @line.any? { |word| word.include?('sunfrsh') } && @line.any? { |word| word.include?('mango') }
    end

    def peach_juice?
      @line.any? { |word| word.include?('compal') } && @line.any? { |word| word.include?('peach') }
    end

    ####

    def spices_and_seasonings?
      cook_cream? || sunflower_oil? || mayonaise? || mustard? || mayonaise_2? || soy_souce? ||
        oil? || sunflower_oil_2? || sugar? || salt? || leaves?
    end

    def cook_cream?
      @line.any? { |word| word.include?('cook') } && @line.any? { |word| word.include?('cream') }
    end

    def sunflower_oil?
      @line.any? { |word| word.include?('mazola') } && @line.any? { |word| word.include?('snflwr') }
    end

    def mayonaise?
      @line.any? { |word| word.include?('mynais') } && @line.any? { |word| word.include?('kewpie') }
    end

    def mustard?
      @line.any? { |word| word.include?('french') } && @line.any? { |word| word.include?('mstd') }
    end

    def mayonaise_2?
      @line.any? { |word| word.include?('mayo') } && @line.any? { |word| word.include?('mamasuka') }
    end

    def soy_souce?
      @line.any? { |word| word.include?('kikkoman') }
    end

    def oil?
      @line.any? { |word| word.include?('filippo') } && @line.any? { |word| word.include?('oil') }
    end

    def sunflower_oil_2?
      @line.any? { |word| word.include?('snflower') } && @line.any? { |word| word.include?('oil') }
    end

    def sugar?
      @line.any? { |word| word.include?('gula') }
    end

    def salt?
      @line.any? { |word| word.include?('pura') } && @line.any? { |word| word.include?('sea') } && @line.any? { |word| word.include?('slt') }
    end

    def leaves?
      @line.any? { |word| word.include?('jays') } && @line.any? { |word| word.include?('bay') } && @line.any? { |word| word.include?('leaves') }
    end

    ####

    def sweets?
      honey? || oreo? || monggo_chocolate? || icecream? || kinder_joy? || kinder_bueno? ||
        like_m_and_ms? || lindt? || chacha? || poule_de_luxe? || hello_panda? || honey_2? ||
        nutella? || schogetten? || cookies? || kit_kat? || kitkat? || hershey? || promo_pack? ||
        dark_chocolate? || haribo? || icecream_2? || excellence_chocolate? || bon_bon?
    end

    def honey?
      @line.any? { |word| word.include?('shifa') } && @line.any? { |word| word.include?('acacia') }
    end

    def oreo?
      @line.any? { |word| word.include?('oreo') }
    end

    def monggo_chocolate?
      @line.any? { |word| word.include?('monggo') }
    end

    def icecream?
      @line.any? { |word| word.include?('walls') }
    end

    def kinder_joy?
      @line.any? { |word| word.include?('kinder') } && @line.any? { |word| word.include?('joy') }
    end

    def kinder_bueno?
      @line.any? { |word| word.include?('kinder') } && @line.any? { |word| word.include?('bueno') }
    end

    def like_m_and_ms?
      @line.any? { |word| word.include?('delfi') }
    end

    def lindt?
      @line.any? { |word| word.include?('lindt') }
    end

    def chacha?
      @line.any? { |word| word.include?('chacha') }
    end

    def poule_de_luxe?
      @line.any? { |word| word.include?('poule') } && @line.any? { |word| word.include?('de') }
    end

    def hello_panda?
      @line.any? { |word| word.include?('hello') } && @line.any? { |word| word.include?('panda') }
    end

    def honey_2?
      @line.any? { |word| word.include?('ldm') } && @line.any? { |word| word.include?('squeezy') }
    end

    def nutella?
      @line.any? { |word| word.include?('nutella') }
    end

    def schogetten?
      @line.any? { |word| word.include?('schogtn') }
    end

    def cookies?
      @line.any? { |word| word.include?('hllo') } && @line.any? { |word| word.include?('pnda') }
    end

    def kit_kat?
      @line.any? { |word| word.include?('kit') } && @line.any? { |word| word.include?('kat') }
    end

    def kitkat?
      @line.any? { |word| word.include?('kitkat') }
    end

    def hershey?
      @line.any? { |word| word.include?('hershey') } && @line.any? { |word| word.include?('crm') }
    end

    def promo_pack?
      @line.any? { |word| word.include?('promo') } && @line.any? { |word| word.include?('pack') }
    end

    def dark_chocolate?
      @line.any? { |word| word.include?('dark') } && @line.any? { |word| word.include?('milkcho') }
    end

    def haribo?
      @line.any? { |word| word.include?('haribo') }
    end

    def icecream_2?
      @line.any? { |word| word.include?('haagendazs') }
    end

    def excellence_chocolate?
      @line.any? { |word| word.include?('excellence') } && @line.any? { |word| word.include?('ex') }
    end

    def bon_bon?
      @line.any? { |word| word.include?('bonbon') }
    end

    ####

    def tea_or_coffee?
      coffee?
    end

    def coffee?
      @line.any? { |word| word.include?('nescafe') }
    end

    ####

    def fruits?
      banana? || apple? || melon? || pineapple? || watermelon? || mango? || cherry? ||
        strawberry? || blueberry?
    end

    def banana?
      @line.any? { |word| word.include?('banana') } && @line.any? { |word| word.include?('sunpride') }
    end

    def apple?
      @line.any? { |word| word.include?('apple') }
    end

    def melon?
      @line.any? { |word| word.include?('melon') }
    end

    def pineapple?
      @line.any? { |word| word.include?('pineapple') }
    end

    def watermelon?
      @line.any? { |word| word.include?('watermelon') } || @line.any? { |word| word.include?('waterme_on') }
    end

    def mango?
      @line.any? { |word| word.include?('mango') }
    end

    def cherry?
      @line.any? { |word| word.include?('cherry') } && !@line.any? { |word| word.include?('tomato') }
    end

    def strawberry?
      @line.any? { |word| word.include?('strawberry') }
    end

    def blueberry?
      @line.any? { |word| word.include?('blueberry') }
    end

    ####

    def vegetables?
      potato? || pepper? || zucchini? || tomato? || parsley? || carrot? || sault_cucumbers? ||
        bonduel_peas? || avocado? || garlic? || rucola? || cabbage_chinese? || herb? ||
        eggplant_purple? || cucumber? || asparagus? || green_onion? || zucchini_2? || radish? ||
        red_onion? || corn? || broccoli? || corn_2? || champignon? || herb_2? || corn_3? ||
        parsley_2?
    end

    def potato?
      @line.any? { |word| word.include?('potato') }
    end

    def pepper?
      @line.any? { |word| word.include?('capsicum') } && @line.any? { |word| word.include?('hidropo') }
    end

    def zucchini?
      @line.any? { |word| word.include?('timun') } && @line.any? { |word| word.include?('jepang') }
    end

    def tomato?
      @line.any? { |word| word.include?('tomato') }
    end

    def parsley?
      @line.any? { |word| word.include?('parsley') }
    end

    def carrot?
      @line.any? { |word| word.include?('carrot') }
    end

    def sault_cucumbers?
      @line.any? { |word| word.include?('kuhne') } && @line.any? { |word| word.include?('feine') }
    end

    def bonduel_peas?
      @line.any? { |word| word.include?('bonduel') } && @line.any? { |word| word.include?('peas') }
    end

    def avocado?
      @line.any? { |word| word.include?('avocado') }
    end

    def garlic?
      @line.any? { |word| word.include?('garlic') }
    end

    def rucola?
      @line.any? { |word| word.include?('rucola') }
    end

    def cabbage_chinese?
      @line.any? { |word| word.include?('cabbage') } && @line.any? { |word| word.include?('chinese') }
    end

    def herb?
      @line.any? { |word| word.include?('dill') }
    end

    def eggplant_purple?
      @line.any? { |word| word.include?('eggplant') } && @line.any? { |word| word.include?('purple') }
    end

    def cucumber?
      @line.any? { |word| word.include?('kyuri') }
    end

    def asparagus?
      @line.any? { |word| word.include?('asparagus') }
    end

    def green_onion?
      @line.any? { |word| word.include?('daun') } && @line.any? { |word| word.include?('bawang') }
    end

    def zucchini_2?
      @line.any? { |word| word.include?('zucchini') } && @line.any? { |word| word.include?('green') }
    end

    def radish?
      @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('radish') }
    end

    def red_onion?
      @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('onion') }
    end

    def corn?
      @line.any? { |word| word.include?('daucy') } && @line.any? { |word| word.include?('swtcorn') }
    end

    def broccoli?
      @line.any? { |word| word.include?('broccoli') }
    end

    def corn_2?
      @line.any? { |word| word.include?('chile') } && @line.any? { |word| word.include?('corn') }
    end

    def champignon?
      @line.any? { |word| word.include?('champignon') }
    end

    def herb_2?
      # but should recognize as dill, not oill
      @line.any? { |word| word.include?('leaf') } && @line.any? { |word| word.include?('oill') }
    end

    def corn_3?
      @line.any? { |word| word.include?('corn') } && @line.any? { |word| word.include?('sweet') }
    end

    def parsley_2?
      @line.any? { |word| word.include?('puri') } && @line.any? { |word| word.include?('cheery') }
    end

    ####

    def dairy?
      cheese? || butter? || milk? || sour_cream? || kefir? || sour_cream_2? ||
        plain_yogurt? || sour_cream_3? || butter_2? || biokul_yogurt? || yummy_yogurt?
    end

    def cheese?
      ricotta? || slices? || mozarella? || yummy_chese? || block? || president_gouda? ||
        bel_cheese? || baros_gouda? || ricta? || bega? || smoked_cheese? || kiri? ||
        laughing_cow_cheese? || cottage_cheese?
    end

    def ricotta?
      @line.any? { |word| word.include?('fresh') } && @line.any? { |word| word.include?('ricotta') }
    end

    def slices?
      @line.any? { |word| word.include?('kraft') } && @line.any? { |word| word.include?('singles') }
    end

    def mozarella?
      (@line.any? { |word| word.include?('bella') } && @line.any? { |word| word.include?('mozza') }) || @line.any? { |word| word.include?('mozarella') }
    end

    def yummy_chese?
      @line.any? { |word| word.include?('yummy') } && @line.any? { |word| word.include?('chese') }
    end

    def block?
      @line.any? { |word| word.include?('emmental') } && @line.any? { |word| word.include?('block') }
    end

    def president_gouda?
      @line.any? { |word| word.include?('president') } && @line.any? { |word| word.include?('gouda') }
    end

    def bel_cheese?
      @line.any? { |word| word.include?('bel') } && @line.any? { |word| word.include?('chese') }
    end

    def baros_gouda?
      @line.any? { |word| word.include?('baros') } && @line.any? { |word| word.include?('gouda') }
    end

    def ricta?
      @line.any? { |word| word.include?('yummy') } && @line.any? { |word| word.include?('ricta') }
    end

    def bega?
      @line.any? { |word| word.include?('bega') } && @line.any? { |word| word.include?('slices') }
    end

    def smoked_cheese?
      @line.any? { |word| word.include?('emina') } && @line.any? { |word| word.include?('smok') } && @line.any? { |word| word.include?('ches') }
    end

    def kiri?
      @line.any? { |word| word.include?('kiri') } && @line.any? { |word| word.include?('cheese') }
    end

    def laughing_cow_cheese?
      @line.any? { |word| word.include?('laughng') } && @line.any? { |word| word.include?('cw') }
    end

    def cottage_cheese?
      @line.any? { |word| word.include?('cottage') } && @line.any? { |word| word.include?('cheese') }
    end

    def butter?
      @line.any? { |word| word.include?('anchor') }
    end

    def milk?
      @line.any? { |word| word.include?('greenfields') }
    end

    def sour_cream?
      @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('cream') }
    end

    def kefir?
      @line.any? { |word| word.include?('kefir') }
    end

    def sour_cream_2?
      @line.any? { |word| word.include?('yummy') } && @line.any? { |word| word.include?('creme') }
    end

    def plain_yogurt?
      @line.any? { |word| word.include?('plain') } && @line.any? { |word| word.include?('yogurt') }
    end

    def sour_cream_3?
      @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('milk') }
    end

    def butter_2?
      @line.any? { |word| word.include?('metzgr') } && @line.any? { |word| word.include?('cafe') }
    end

    def biokul_yogurt?
      @line.any? { |word| word.include?('biokul') } && @line.any? { |word| word.include?('yghrt') }
    end

    def yummy_yogurt?
      @line.any? { |word| word.include?('yummy') } && @line.any? { |word| word.include?('yog') }
    end

    ####

    def bread?
      just_bread? || bread_for_hot_dog? || for_wrap? || flour? || some_bread? || flour_2? ||
        bread_2?
    end

    def just_bread?
      @line.any? { |word| word.include?('bread') }
    end

    def bread_for_hot_dog?
      @line.any? { |word| word.include?('dog') } && @line.any? { |word| word.include?('hot') }
    end

    def for_wrap?
      @line.any? { |word| word.include?('kawan') } && @line.any? { |word| word.include?('roti') }
    end

    def flour?
      @line.any? { |word| word.include?('kunci') } && @line.any? { |word| word.include?('biru') }
    end

    def some_bread?
      @line.any? { |word| word.include?('roti') } && @line.any? { |word| word.include?('bgb') }
    end

    def flour_2?
      @line.any? { |word| word.include?('cakra') } && @line.any? { |word| word.include?('kembar') } && @line.any? { |word| word.include?('terigu') }
    end

    def bread_2?
      @line.any? { |word| word.include?('rumah') } && @line.any? { |word| word.include?('roti') } && @line.any? { |word| word.include?('brown') }
    end

    ####

    def meat?
      chicken? || chicken_leg? || chicken_2? || pork? || bacon? || beef? ||
        pork_slices?
    end

    def chicken?
      @line.any? { |word| word.include?('chicken') }
    end

    def chicken_leg?
      @line.any? { |word| word.include?('paha') } && @line.any? { |word| word.include?('bawa') }
    end

    def chicken_2?
      @line.any? { |word| word.include?('paha') } && @line.any? { |word| word.include?('atas') }
    end

    def pork?
      @line.any? { |word| word.include?('pork') }
    end

    def bacon?
      @line.any? { |word| word.include?('bacon') }
    end

    def beef?
      @line.any? { |word| word.include?('beef') }
    end

    def pork_slices?
      @line.any? { |word| word.include?('svenschoc') } && @line.any? { |word| word.include?('pork') }
    end

    ####

    def fish?
      tuna? || shrimp? || barramundi? || fish_steak? || canned_fish? || canned_fish_2?
    end

    def tuna?
      @line.any? { |word| word.include?('tuna') } && @line.any? { |word| word.include?('steak') }
    end

    def shrimp?
      @line.any? { |word| word.include?('shrimp') } && @line.any? { |word| word.include?('fresh') }
    end

    def barramundi?
      @line.any? { |word| word.include?('barramundi') }
    end

    def fish_steak?
      @line.any? { |word| word.include?('fish') } && @line.any? { |word| word.include?('steak') }
    end

    def canned_fish?
      @line.any? { |word| word.include?('bestanaku') } && @line.any? { |word| word.include?('oil') }
    end

    def canned_fish_2?
      @line.any? { |word| word.include?('sunview') } && @line.any? { |word| word.include?('anchvy') }
    end

    ####

    def sausage_and_sausages?
      bernardi? || el_primo? || ham? || kanzler? || smoke_leg? || salami? || salami_2?
    end

    def bernardi?
      @line.any? { |word| word.include?('bernardi') }
    end

    def el_primo?
      @line.any? { |word| word.include?('el') } && @line.any? { |word| word.include?('primo') }
    end

    def ham?
      @line.any? { |word| word.include?('ham') }
    end

    def kanzler?
      @line.any? { |word| word.include?('kanzler') }
    end

    def smoke_leg?
      @line.any? { |word| word.include?('smoke') } && @line.any? { |word| word.include?('leg') }
    end

    def salami?
      @line.any? { |word| word.include?('mamas') } && (@line.any? { |word| word.include?('salam') } || @line.any? { |word| word.include?('slm') })
    end

    def salami_2?
      @line.any? { |word| word.include?('salami') } && @line.any? { |word| word.include?('italia') }
    end

    ####

    def for_beer?
      pistachios? || thins? || sunflower_seeds? || pringles? || cashewnuts? || some_seeds? ||
        crisps?
    end

    def pistachios?
      @line.any? { |word| word.include?('sunkist') } && @line.any? { |word| word.include?('rst') }
    end

    def thins?
      @line.any? { |word| word.include?('thins') }
    end

    def sunflower_seeds?
      @line.any? { |word| word.include?('snflwrs') } && @line.any? { |word| word.include?('seed') }
    end

    def pringles?
      @line.any? { |word| word.include?('pringles') }
    end

    def cashewnuts?
      @line.any? { |word| word.include?('cashewnuts') }
    end

    def some_seeds?
      @line.any? { |word| word.include?('rebo') } && @line.any? { |word| word.include?('kuaci') }
    end

    def crisps?
      @line.any? { |word| word.include?('lorenz') } && @line.any? { |word| word.include?('barbecue') }
    end

    ####

    def grocery?
      barilla? || rice? || spaghetti?
    end

    def barilla?
      @line.any? { |word| word.include?('barilla') }
    end

    def rice?
      @line.any? { |word| word.include?('rice') }
    end

    def spaghetti?
      @line.any? { |word| word.include?('spaghetti') }
    end

    ####

    def kitchen_stuff?
      tissue? || kitchen_ware? || sponge? || mitu_blue? || bio?
    end

    def tissue?
      @line.any? { |word| word.include?('paseo') }
    end

    def kitchen_ware?
      @line.any? { |word| word.include?('kitchen') } && @line.any? { |word| word.include?('ware') }
    end

    def sponge?
      @line.any? { |word| word.include?('bagus') } && @line.any? { |word| word.include?('bilas') }
    end

    def mitu_blue?
      @line.any? { |word| word.include?('mitu') } && @line.any? { |word| word.include?('blue') }
    end

    def bio?
      @line.any? { |word| word.include?('bio') } && @line.any? { |word| word.include?('jrk') }
    end

    ####

    def food_bag_or_delivery?
      bag? || bag_2?
    end

    def bag?
      @line.any? { |word| word.include?('linds') } && @line.any? { |word| word.include?('tas') } && @line.any? { |word| word.include?('kain') }
    end

    def bag_2?
      @line.any? { |word| word.include?('shopping') } && @line.any? { |word| word.include?('frestive') }
    end

    ####

    def bath_stuff?
      toilet_paper? || crystal? || oralb?
    end

    def toilet_paper?
      @line.any? { |word| word.include?('bagus') } && @line.any? { |word| word.include?('klap') }
    end

    def crystal?
      @line.any? { |word| word.include?('crystal') } && @line.any? { |word| word.include?('proclin') }
    end

    def oralb?
      @line.any? { |word| word.include?('oralb') } && @line.any? { |word| word.include?('winnie') }
    end

    ####

    def pampers?
      @line.any? { |word| word.include?('makuku') } && @line.any? { |word| word.include?('slim') }
    end

    ####

    def home_stuff?
      coal?
    end

    def coal?
      @line.any? { |word| word.include?('wood') } && @line.any? { |word| word.include?('charcoal') }
    end

    ####

    def liliia_bath_stuff?
      laurier?
    end

    def laurier?
      @line.any? { |word| word.include?('laurier') }
    end
  end
end
