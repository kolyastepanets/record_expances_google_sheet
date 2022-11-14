module DetectCategoryAndSubcategoryFromLine
  class PepitoShop < Default
    def alcohol?
      beer?
    end

    def beer?
      @line.include?('crystal') && @line.include?('bintang')
    end

    ####

    def eggs?
      @line.include?('telur') && @line.include?('ayam')
    end

    ####

    def water?
      green_tea? || cherry_juice?
    end

    def green_tea?
      @line.include?('green') && @line.include?('tea') && @line.include?('original')
    end

    def cherry_juice?
      @line.include?('clasic') && @line.include?('sour') && @line.include?('chery')
    end

    ####

    def spices_and_seasonings?
    end

    ####

    def sweets?
      magnum_icecream? || oreo_cake? || lindt? || kit_kat?
    end

    def magnum_icecream?
      @line.include?('magnum') && (@line.include?('almond') || @line.include?('classic'))
    end

    def oreo_cake?
      @line.include?('oreo') && @line.include?('cakes')
    end

    def lindt?
      @line.include?('lindt')
    end

    def kit_kat?
      @line.include?('kat') && @line.include?('kit')
    end

    ####

    def tea_or_coffee?
    end

    ####

    def fruits?
      pineapple? || mango? || dragon_fruit? || watermelon? || banana? || grape?
    end

    def pineapple?
      @line.include?('nanas') && @line.include?('honi')
    end

    def mango?
      @line.include?('mangga') && @line.include?('gdong')
    end

    def dragon_fruit?
      @line.include?('dragon') && @line.include?('fruit')
    end

    def watermelon?
      @line.include?('semangka') && @line.include?('merah')
    end

    def banana?
      @line.include?('sunpride') && @line.include?('pisang')
    end

    def grape?
      @line.include?('green') && @line.include?('grape')
    end

    ####

    def vegetables?
      cucumber? || pepper? || tomato? || avocado?
    end

    def cucumber?
      @line.include?('kyuri')
    end

    def pepper?
      @line.include?('paprika') && @line.include?('hij')
    end

    def tomato?
      @line.include?('beef') && @line.include?('tomato')
    end

    def avocado?
      @line.include?('alpukat')
    end

    ####

    def dairy?
      milk? || greenfields_milk? || kin_milk? || greenfields_yog? || biokul_yog? || kin_yog? || delicyo_yog? || cimory_yog?
    end

    def milk?
      @line.include?('milk') && @line.include?('life')
    end

    def greenfields_milk?
      @line.include?('greenfield') && @line.include?('milk')
    end

    def kin_milk?
      @line.include?('kin') && @line.include?('milk')
    end

    def greenfields_yog?
      @line.include?('greenfield') && @line.include?('yog')
    end

    def biokul_yog?
      @line.include?('biokul') && @line.include?('yog')
    end

    def kin_yog?
      @line.include?('kin') && @line.include?('yog')
    end

    def delicyo_yog?
      @line.include?('delicyo') && @line.include?('yog')
    end

    def cimory_yog?
      @line.include?('cimory') && @line.include?('squeeze')
    end

    ####

    def bread?
      donut? || just_bread?
    end

    def donut?
      @line.include?('onut') && @line.include?('sprinkle')
    end

    def just_bread?
      @line.include?('whole') && @line.include?('wheat')
    end

    ####

    def meat?
      chicken_breast?
    end

    def chicken_breast?
      @line.include?('chic') && @line.include?('breast')
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
      mamas_ham? || mamas_pork? || sausages? || cooked_ham? || bacon? || smith_field_ham?
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
      @line.include?('ooked') && @line.include?('ham')
    end

    def bacon?
      @line.include?('streaky') && @line.include?('bacon')
    end

    def smith_field_ham?
      @line.include?('smithfield') && @line.include?('ham')
    end

    ####

    def for_beer?
      lays? || pistachios?
    end

    def lays?
      @line.include?('lay') && @line.include?('chips')
    end

    def pistachios?
      @line.include?('pistachios')
    end

    ####

    def grocery?
      rice?
    end

    def rice?
      @line.include?('basmati') && @line.include?('rice')
    end

    ####

    def kitchen_stuff?
      tissue? || some_stuff?
    end

    def tissue?
      @line.include?('paseo') && @line.include?('ultrs')
    end

    def some_stuff?
      @line.include?('youth') && @line.include?('kitchen')
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
      clear_gel?
    end

    def clear_gel?
      @line.include?('clear') && @line.include?('active')
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
