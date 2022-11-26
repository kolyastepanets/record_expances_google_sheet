module DetectCategoryAndSubcategoryFromLine
  class FrestiveShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine?
    end

    def beer?
      @line.include?('bintang')
    end

    def wine?
      @line.include?('hatten') && @line.include?('rose')
    end

    ####

    def eggs?
      @line.include?('egg')
    end

    ####

    def water?
      coca_cola? || rauch_strawberry?
    end

    def coca_cola?
      @line.include?('coca') && @line.include?('cola')
    end

    def rauch_strawberry?
      @line.include?('rauch') && @line.include?('strawbry')
    end

    ####

    def spices_and_seasonings?
      cook_cream?
    end

    def cook_cream?
      @line.include?('cook') && @line.include?('cream')
    end

    ####

    def sweets?
      honey? || oreo? || monggo_chocolate? || icecream? || kinder_joy? || kinder_bueno? ||
        like_m_and_ms? || lindt? || chacha?
    end

    def honey?
      @line.include?('shifa') && @line.include?('acacia')
    end

    def oreo?
      @line.include?('oreo') && @line.include?('bisc')
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
      @line.include?('delfi') && @line.include?('mini') && @line.include?('toys')
    end

    def lindt?
      @line.include?('lindt')
    end

    def chacha?
      @line.include?('chacha')
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
      banana? || apple? || melon? || pineapple?
    end

    def banana?
      @line.include?('banana') && @line.include?('sunpride')
    end

    def apple?
      @line.include?('apple') && @line.include?('ryl')
    end

    def melon?
      @line.include?('melon') && @line.include?('cantaluope')
    end

    def pineapple?
      @line.include?('pineapple')
    end

    ####

    def vegetables?
      potato? || pepper? || zucchini? || tomato? || parsley? || carrot? || sault_cucumbers? ||
        bonduel_peas? || avocado? || garlic? || rucola?
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
      @line.include?('tomato') && @line.include?('cherry')
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

    ####

    def dairy?
      cheese? || butter? || milk? || sour_cream? || kefir?
    end

    def cheese?
      ricotta? || slices? || mozarella? || yummy_chese? || block?
    end

    def ricotta?
      @line.include?('fresh') && @line.include?('ricotta')
    end

    def slices?
      @line.include?('kraft') && @line.include?('singles')
    end

    def mozarella?
      @line.include?('bella') && @line.include?('mozza')
    end

    def yummy_chese?
      @line.include?('yummy') && @line.include?('chese')
    end

    def block?
      @line.include?('emmental') && @line.include?('block')
    end

    def butter?
      @line.include?('anchor')
    end

    def milk?
      @line.include?('greenfields') && @line.include?('fresh')
    end

    def sour_cream?
      @line.include?('sour') && @line.any? { |word| word.include?('cream') }
    end

    def kefir?
      @line.include?('kefir')
    end

    ####

    def bread?
      just_bread? || bread_for_hot_dog? || for_wrap?
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

    ####

    def meat?
      chicken? || chicken_leg? || chicken_2?
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

    ####

    def fish?
      tuna?
    end

    def tuna?
      @line.include?('tuna') && @line.include?('steak')
    end

    ####

    def sausage_and_sausages?
      bernardi? || el_primo?
    end

    def bernardi?
      @line.include?('bernardi')
    end

    def el_primo?
      @line.include?('el') && @line.include?('primo')
    end

    ####

    def for_beer?
      pistachios? || thins? || sunflower_seeds?
    end

    def pistachios?
      @line.include?('sunkist') && @line.any? { |word| word.include?('rst') }
    end

    def thins?
      @line.include?('thins') && @line.include?('chives')
    end

    def sunflower_seeds?
      @line.include?('snflwrs') && @line.any? { |word| word.include?('seed') }
    end

    ####

    def grocery?
    end

    ####

    def kitchen_stuff?
      tissue? || kitchen_ware?
    end

    def tissue?
      @line.include?('paseo') && (@line.include?('tissue') || @line.include?('soft'))
    end

    def kitchen_ware?
      @line.include?('kitchen') && @line.include?('ware')
    end

    ####

    def food_bag_or_delivery?
      @line.include?('linds') && @line.include?('tas') && @line.include?('kain')
    end
  end
end
