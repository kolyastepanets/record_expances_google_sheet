module DetectCategoryAndSubcategoryFromLine
  class PepitoShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine?
    end

    def beer?
      bintang_beer? || bali_hai_beer?
    end

    def bintang_beer?
      @line.any? { |word| word.include?('bintang') } && @line.include?('crystal')
    end

    def bali_hai_beer?
      @line.include?('bali') && @line.include?('hai')
    end

    def wine?
      @line.include?('hatten') && @line.include?('white')
    end

    ####

    def eggs?
      @line.include?('telur')
    end

    ####

    def water?
      green_tea? || cherry_juice? || cola?
    end

    def green_tea?
      @line.include?('green') && @line.include?('tea') && @line.include?('original')
    end

    def cherry_juice?
      @line.include?('clasic') && @line.include?('sour') && @line.include?('chery')
    end

    def cola?
      @line.include?('coca') && @line.include?('cola')
    end

    ####

    def spices_and_seasonings?
      soy_souce? || mayonaise?
    end

    def soy_souce?
      @line.include?('kikko') && @line.include?('asin')
    end

    def mayonaise?
      @line.include?('mayonais')
    end

    ####

    def sweets?
      magnum_icecream? || oreo_cake? || lindt? || kit_kat? || oreo_biscuit? || milk_chocolate? ||
        like_m_and_ms? || kinder_bueno?
    end

    def magnum_icecream?
      @line.include?('magnum')
    end

    def oreo_cake?
      @line.include?('oreo') && @line.include?('cakes')
    end

    def lindt?
      @line.any? { |word| word.include?('lindt') }
    end

    def kit_kat?
      @line.any? { |word| word.include?('kit') } && @line.include?('kat')
    end

    def oreo_biscuit?
      @line.include?('oreo')
    end

    def milk_chocolate?
      @line.include?('milk') && @line.include?('chocolate')
    end

    def like_m_and_ms?
      @line.include?('chacha') && @line.include?('peanut')
    end

    def kinder_bueno?
      @line.include?('kinder') && @line.include?('bueno')
    end

    ####

    def tea_or_coffee?
      nescafe?
    end

    def nescafe?
      @line.include?('nescafe')
    end

    ####

    def fruits?
      pineapple? || mango? || dragon_fruit? || watermelon? || banana? || grape? || corn?
    end

    def pineapple?
      @line.any? { |word| word.include?('nanas') } && @line.include?('honi')
    end

    def mango?
      @line.include?('mangga') && @line.include?('gdong')
    end

    def dragon_fruit?
      @line.include?('dragon') && @line.include?('fruit')
    end

    def watermelon?
      @line.any? { |word| word.include?('semangka') } && @line.include?('merah')
    end

    def banana?
      @line.any? { |word| word.include?('unpride') } && @line.include?('pisang')
    end

    def grape?
      @line.include?('green') && @line.include?('grape')
    end

    def corn?
      @line.include?('jagung') && @line.include?('manis')
    end

    ####

    def vegetables?
      cucumber? || pepper? || tomato? || avocado? || brokoli? || potato? || canned_pepper? || carrot?
    end

    def cucumber?
      @line.any? { |word| word.include?('kyuri') }
    end

    def pepper?
      @line.include?('paprika') && @line.include?('hij')
    end

    def tomato?
      @line.include?('beef') && @line.include?('tomato')
    end

    def avocado?
      @line.any? { |word| word.include?('alpukat') }
    end

    def brokoli?
      @line.include?('brokoli')
    end

    def potato?
      @line.include?('kentang') && @line.include?('besar')
    end

    def canned_pepper?
      @line.include?('mamas') && @line.include?('pepper') && @line.include?('roast')
    end

    def carrot?
      @line.include?('wortel') && @line.include?('medan')
    end

    ####

    def dairy?
      milk? || greenfields_milk? || kin_milk? || greenfields_yog? || biokul_yog? || kin_yog? ||
        delicyo_yog? || cimory_yog? || j_j_cheese? || laughing_cow_cheese?
    end

    def milk?
      @line.include?('milk') && @line.include?('life')
    end

    def greenfields_milk?
      @line.any? { |word| word.include?('greenfield') } && @line.include?('milk')
    end

    def kin_milk?
      @line.include?('kin') && @line.include?('freshmilk')
    end

    def greenfields_yog?
      @line.include?('greenfields') && @line.include?('yog')
    end

    def biokul_yog?
      @line.any? { |word| word.include?('iokul') } && @line.include?('yog')
    end

    def kin_yog?
      @line.include?('kin') && @line.include?('yog')
    end

    def delicyo_yog?
      @line.any? { |word| word.include?('del') } && @line.any? { |word| word.include?('icyo') } && @line.include?('yog')
    end

    def cimory_yog?
      @line.include?('cimory') && @line.include?('squeeze')
    end

    def j_j_cheese?
      @line.include?('j') && @line.include?('&') && @line.include?('cott')
    end

    def laughing_cow_cheese?
      @line.any? { |word| word.include?('laughing') } && @line.any? { |word| word.include?('co') } &&
        @line.any? { |word| word.include?('chee') }
    end

    ####

    def bread?
      donut? || bread_sticks? || toast?
    end

    def donut?
      @line.any? { |word| word.include?('onut') } && @line.include?('sprinkle')
    end

    def bread_sticks?
      @line.include?('grissini') && @line.include?('gluten')
    end

    def toast?
      @line.any? { |word| word.include?('toast') }
    end

    ####

    def meat?
      chicken_breast? || chicken_leg?
    end

    def chicken_breast?
      @line.include?('chic') && @line.include?('breast')
    end

    def chicken_leg?
      @line.include?('chicken') && @line.include?('leg')
    end

    ####

    def fish?
      marlin?
    end

    def marlin?
      @line.include?('marlin') && @line.include?('steak')
    end

    ####

    def sausage_and_sausages?
      mamas_ham? || mamas_pork? || sausages? || cooked_ham? || bacon? || smith_field_ham? ||
        mamas_salami?
    end

    def mamas_ham?
      @line.include?('mamas') && @line.include?('ham')
    end

    def mamas_pork?
      @line.include?('mamas') && @line.include?('pork')
    end

    def sausages?
      @line.include?('kanzler') && @line.include?('original')
    end

    def cooked_ham?
      @line.any? { |word| word.include?('ooked') } && @line.include?('ham')
    end

    def bacon?
      @line.include?('bacon')
    end

    def smith_field_ham?
      @line.any? { |word| word.include?('smithfield') } && @line.include?('ham')
    end

    def mamas_salami?
      @line.include?('mamas') && @line.include?('salami')
    end

    ####

    def for_beer?
      lays? || pistachios? || pringles?
    end

    def lays?
      @line.include?('lays') || (@line.include?('lay') && @line.include?('chips'))
    end

    def pistachios?
      @line.include?('pistachios') || @line.include?('pischio')
    end

    def pringles?
      @line.include?('pringles')
    end

    ####

    def grocery?
      rice? || barilla_farfalle?
    end

    def rice?
      @line.include?('basmati') && @line.include?('rice')
    end

    def barilla_farfalle?
      @line.include?('barilla') && @line.include?('farfalle')
    end

    ####

    def kitchen_stuff?
      tissue? || some_stuff? || sponge?
    end

    def tissue?
      @line.include?('paseo')
    end

    def some_stuff?
      @line.any? { |word| word.include?('youth') } && @line.include?('kitchen')
    end

    def sponge?
      @line.include?('polytex') && @line.include?('sponge')
    end

    ####

    def food_bag_or_delivery?
      bag?
    end

    def bag?
      @line.include?('pepito') && @line.include?('bag')
    end

    ####

    def bath_stuff?
      clear_gel? || colgate? || local_vanish? || vanish?
    end

    def clear_gel?
      @line.include?('clear') && @line.include?('active')
    end

    def colgate?
      @line.include?('colgate')
    end

    def local_vanish?
      @line.include?('proclin')
    end

    def vanish?
      @line.include?('vanish')
    end

    ####

    def home_stuff?
      bataries? || baby_wipes?
    end

    def bataries?
      @line.include?('panasonic') && @line.include?('alk')
    end

    def baby_wipes?
      @line.include?('baby') && @line.include?('wipes')
    end
  end
end
