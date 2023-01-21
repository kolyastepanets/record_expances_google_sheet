module DetectCategoryAndSubcategoryFromLine
  class FrestiveShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine? || champagne?
    end

    def beer?
      @line.include?('bintang')
    end

    def wine?
      @line.include?('hatten')
    end

    def champagne?
      @line.include?('sababay') && @line.include?('ascaro')
    end

    ####

    def eggs?
      @line.include?('egg')
    end

    ####

    def water?
      coca_cola? || rauch_juice? || mixed_juice? || fanta? || jungle_juice? || nestle_water? ||
        aqua_water? || cheers_water?
    end

    def coca_cola?
      @line.include?('coca') && @line.include?('cola')
    end

    def rauch_juice?
      @line.include?('rauch')
    end

    def mixed_juice?
      @line.include?('mixed') && @line.include?('juice')
    end

    def fanta?
      @line.include?('fanta')
    end

    def jungle_juice?
      @line.include?('jungle') && @line.include?('jc')
    end

    def nestle_water?
      @line.include?('nestle') && @line.include?('600ml')
    end

    def aqua_water?
      @line.include?('aqua') && @line.include?('water')
    end

    def cheers_water?
      @line.include?('cheers') && @line.include?('water')
    end

    ####

    def spices_and_seasonings?
      cook_cream? || sunflower_oil? || mayonaise? || mustard?
    end

    def cook_cream?
      @line.include?('cook') && @line.include?('cream')
    end

    def sunflower_oil?
      @line.include?('mazola') && @line.include?('snflwr')
    end

    def mayonaise?
      @line.include?('mynais') && @line.include?('kewpie')
    end

    def mustard?
      @line.include?('french') && @line.any? { |word| word.include?('mstd') }
    end

    ####

    def sweets?
      honey? || oreo? || monggo_chocolate? || icecream? || kinder_joy? || kinder_bueno? ||
        like_m_and_ms? || lindt? || chacha? || poule_de_luxe? || hello_panda? || honey_2? ||
        nutella? || schogetten? || cookies? || kit_kat? || kitkat?
    end

    def honey?
      @line.include?('shifa') && @line.include?('acacia')
    end

    def oreo?
      @line.include?('oreo')
    end

    def monggo_chocolate?
      @line.include?('monggo')
    end

    def icecream?
      @line.include?('walls')
    end

    def kinder_joy?
      @line.include?('kinder') && @line.include?('joy')
    end

    def kinder_bueno?
      @line.include?('kinder') && @line.include?('bueno')
    end

    def like_m_and_ms?
      @line.include?('delfi')
    end

    def lindt?
      @line.include?('lindt')
    end

    def chacha?
      @line.include?('chacha')
    end

    def poule_de_luxe?
      @line.include?('poule') && @line.include?('de')
    end

    def hello_panda?
      @line.include?('hello') && @line.include?('panda')
    end

    def honey_2?
      @line.include?('ldm') && @line.include?('squeezy')
    end

    def nutella?
      @line.include?('nutella')
    end

    def schogetten?
      @line.include?('schogtn')
    end

    def cookies?
      @line.include?('hllo') && @line.include?('pnda')
    end

    def kit_kat?
      @line.include?('kit') && @line.include?('kat')
    end

    def kitkat?
      @line.include?('kitkat')
    end

    ####

    def tea_or_coffee?
      coffee?
    end

    def coffee?
      @line.include?('nescafe')
    end

    ####

    def fruits?
      banana? || apple? || melon? || pineapple? || watermelon? || mango?
    end

    def banana?
      @line.include?('banana') && @line.include?('sunpride')
    end

    def apple?
      @line.include?('apple')
    end

    def melon?
      @line.include?('melon')
    end

    def pineapple?
      @line.include?('pineapple')
    end

    def watermelon?
      @line.include?('watermelon')
    end

    def mango?
      @line.include?('mango')
    end

    ####

    def vegetables?
      potato? || pepper? || zucchini? || tomato? || parsley? || carrot? || sault_cucumbers? ||
        bonduel_peas? || avocado? || garlic? || rucola? || cabbage_chinese? || herb? ||
        eggplant_purple? || cucumber? || asparagus? || green_onion? || zucchini_2? || radish? ||
        red_onion?
    end

    def potato?
      @line.include?('potato')
    end

    def pepper?
      @line.include?('capsicum') && @line.include?('hidropo')
    end

    def zucchini?
      @line.include?('timun') && @line.include?('jepang')
    end

    def tomato?
      @line.include?('tomato')
    end

    def parsley?
      @line.include?('parsley')
    end

    def carrot?
      @line.include?('carrot')
    end

    def sault_cucumbers?
      @line.include?('kuhne') && @line.include?('feine')
    end

    def bonduel_peas?
      @line.include?('bonduel') && @line.include?('peas')
    end

    def avocado?
      @line.include?('avocado')
    end

    def garlic?
      @line.include?('garlic')
    end

    def rucola?
      @line.include?('rucola')
    end

    def cabbage_chinese?
      @line.include?('cabbage') && @line.include?('chinese')
    end

    def herb?
      @line.any? { |word| word.include?('dill') }
    end

    def eggplant_purple?
      @line.include?('eggplant') && @line.include?('purple')
    end

    def cucumber?
      @line.include?('kyuri')
    end

    def asparagus?
      @line.include?('asparagus')
    end

    def green_onion?
      @line.include?('daun') && @line.include?('bawang') && @line.include?('besar')
    end

    def zucchini_2?
      @line.include?('zucchini') && @line.include?('green')
    end

    def radish?
      @line.include?('red') && @line.include?('radish')
    end

    def red_onion?
      @line.include?('red') && @line.include?('onion')
    end

    ####

    def dairy?
      cheese? || butter? || milk? || sour_cream? || kefir? || sour_cream_2? ||
        plain_yogurt? || sour_cream_3?
    end

    def cheese?
      ricotta? || slices? || mozarella? || yummy_chese? || block? || president_gouda? ||
        bel_cheese? || baros_gouda? || ricta? || bega?
    end

    def ricotta?
      @line.include?('fresh') && @line.include?('ricotta')
    end

    def slices?
      @line.include?('kraft') && @line.include?('singles')
    end

    def mozarella?
      (@line.include?('bella') && @line.include?('mozza')) || @line.include?('mozarella')
    end

    def yummy_chese?
      @line.include?('yummy') && @line.include?('chese')
    end

    def block?
      @line.include?('emmental') && @line.include?('block')
    end

    def president_gouda?
      @line.include?('president') && @line.include?('gouda')
    end

    def bel_cheese?
      @line.include?('bel') && @line.include?('chese')
    end

    def baros_gouda?
      @line.include?('baros') && @line.include?('gouda')
    end

    def ricta?
      @line.include?('yummy') && @line.include?('ricta')
    end

    def bega?
      @line.include?('bega') && @line.any? { |word| word.include?('slices') }
    end

    def butter?
      @line.include?('anchor')
    end

    def milk?
      @line.include?('greenfields')
    end

    def sour_cream?
      @line.include?('sour') && @line.any? { |word| word.include?('cream') }
    end

    def kefir?
      @line.include?('kefir')
    end

    def sour_cream_2?
      @line.include?('yummy') && @line.include?('creme')
    end

    def plain_yogurt?
      @line.include?('plain') && @line.include?('yogurt')
    end

    def sour_cream_3?
      @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('milk') }
    end

    ####

    def bread?
      just_bread? || bread_for_hot_dog? || for_wrap? || flour?
    end

    def just_bread?
      @line.include?('bread')
    end

    def bread_for_hot_dog?
      @line.include?('dog') && @line.include?('hot')
    end

    def for_wrap?
      @line.include?('kawan') && @line.include?('roti')
    end

    def flour?
      @line.include?('kunci') && @line.include?('biru')
    end

    ####

    def meat?
      chicken? || chicken_leg? || chicken_2? || pork? || bacon? || beef?
    end

    def chicken?
      @line.include?('chicken')
    end

    def chicken_leg?
      @line.include?('paha') && @line.any? { |word| word.include?('bawa') }
    end

    def chicken_2?
      @line.include?('paha') && @line.include?('atas')
    end

    def pork?
      @line.include?('pork')
    end

    def bacon?
      @line.include?('bacon')
    end

    def beef?
      @line.include?('beef')
    end

    ####

    def fish?
      tuna? || shrimp? || barramundi? || fish_steak?
    end

    def tuna?
      @line.include?('tuna') && @line.include?('steak')
    end

    def shrimp?
      @line.include?('shrimp') && @line.include?('fresh')
    end

    def barramundi?
      @line.include?('barramundi')
    end

    def fish_steak?
      @line.any? { |word| word.include?('fish') } && @line.include?('steak')
    end

    ####

    def sausage_and_sausages?
      bernardi? || el_primo? || ham? || kanzler? || smoke_leg? || salami? || salami_2?
    end

    def bernardi?
      @line.include?('bernardi')
    end

    def el_primo?
      @line.include?('el') && @line.include?('primo')
    end

    def ham?
      @line.include?('ham')
    end

    def kanzler?
      @line.include?('kanzler')
    end

    def smoke_leg?
      @line.any? { |word| word.include?('smoke') } && @line.any? { |word| word.include?('leg') }
    end

    def salami?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('salam') }
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
      @line.include?('sunkist') && @line.any? { |word| word.include?('rst') }
    end

    def thins?
      @line.include?('thins')
    end

    def sunflower_seeds?
      @line.include?('snflwrs') && @line.any? { |word| word.include?('seed') }
    end

    def pringles?
      @line.include?('pringles')
    end

    def cashewnuts?
      @line.include?('cashewnuts')
    end

    def some_seeds?
      @line.include?('rebo') && @line.include?('kuaci')
    end

    def crisps?
      @line.include?('lorenz') && @line.include?('barbecue')
    end

    ####

    def grocery?
      barilla?
    end

    def barilla?
      @line.include?('barilla')
    end

    ####

    def kitchen_stuff?
      tissue? || kitchen_ware? || sponge? || mitu_blue?
    end

    def tissue?
      @line.include?('paseo')
    end

    def kitchen_ware?
      @line.include?('kitchen') && @line.include?('ware')
    end

    def sponge?
      @line.include?('bagus') && @line.include?('bilas')
    end

    def mitu_blue?
      @line.include?('mitu') && @line.include?('blue')
    end

    ####

    def food_bag_or_delivery?
      @line.include?('linds') && @line.include?('tas') && @line.include?('kain')
    end

    ####

    def bath_stuff?
      toilet_paper?
    end

    def toilet_paper?
      @line.include?('bagus') && @line.include?('klap')
    end

    ####

    def pampers?
      @line.include?('makuku') && @line.include?('slim')
    end

    ####

    def home_stuff?
      coal?
    end

    def coal?
      @line.include?('wood') && @line.include?('charcoal')
    end
  end
end
