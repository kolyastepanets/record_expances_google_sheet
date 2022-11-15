module DetectCategoryAndSubcategoryFromLine
  class BaliDirectStoreShop < Default
    def alcohol?
    end

    def water?
    end

    ####

    def spices_and_seasonings?
      tomato_puree?
    end

    def tomato_puree?
      @line.include?('tomato') && @line.include?('puree')
    end

    ####

    def sweets?
      cookonuts_cookies?
    end

    def cookonuts_cookies?
      @line.include?('cookonuts') && @line.include?('cookies')
    end

    ####

    def tea_or_coffee?
    end

    ####

    def fruits?
      lemon? || pineapple? || corn?
    end

    def lemon?
      @line.include?('lemon')
    end

    def pineapple?
      @line.include?('pineapple')
    end

    def corn?
      @line.include?('sweet') && @line.include?('corn')
    end

    ####

    def vegetables?
      cucumber? || onion? || beetroot? || arugula? || potato? || carrot? || cabbage? || tomato?
    end

    def cucumber?
      @line.include?('cucumber')
    end

    def onion?
      @line.include?('onion')
    end

    def beetroot?
      @line.include?('beetroot')
    end

    def arugula?
      @line.include?('arugula')
    end

    def potato?
      @line.include?('potato')
    end

    def carrot?
      @line.include?('carrot')
    end

    def cabbage?
      @line.include?('cabbage')
    end

    def tomato?
      (@line.include?('cherry') && @line.include?('tomato')) || @line.include?('tomato')
    end

    ####

    def dairy?
      kefir? || mozzarella? || cheese? || milk?
    end

    def kefir?
      @line.include?('kefir')
    end

    def mozzarella?
      @line.include?('mozzarella')
    end

    def cheese?
      @line.include?('cheese')
    end

    def milk?
      @line.include?('milk')
    end

    ####

    def bread?
    end

    ####

    def meat?
      whole_chicken? || beef?
    end

    def whole_chicken?
      @line.include?('whole') && @line.include?('chicken')
    end

    def beef?
      @line.include?('beef')
    end

    ####

    def fish?
      gold_band_snapper?
    end

    def gold_band_snapper?
      @line.include?('gold') && @line.include?('band') && @line.include?('snapper')
    end

    ####

    def sausage_and_sausages?
      cheese_sausage?
    end

    def cheese_sausage?
      @line.include?('cheese') && @line.include?('sausage')
    end

    ####

    def ready_to_cook?
      syrniki?
    end

    def syrniki?
      @line.include?('syrniki')
    end

    ####

    def for_beer?
    end

    def eggs?
      @line.include?('eggs')
    end

    def grocery?
    end

    def bath_stuff?
    end

    def home_stuff?
    end

    def food_bag_or_delivery?
    end

    def kitchen_stuff?
    end
  end
end
