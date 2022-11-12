module DetectCategoryAndSubcategoryFromLine
  class FrestiveShop < Default
    def alcohol?
      beer?
    end

    def beer?
      @line.include?('bintang')
    end

    ####

    def eggs?
      @line.include?('egg') && @line.include?('bioland')
    end

    ####

    def water?
      coca_cola?
    end

    def coca_cola?
      @line.include?('coca') && @line.include?('cola')
    end

    ####

    def spices_and_seasonings?
    end

    ####

    def sweets?
      honey? || oreo? || monggo_chocolate? || icecream? || kinder_joy? || kinder_bueno? || like_m_and_ms?
    end

    def honey?
      @line.include?('shifa') && @line.include?('acacia')
    end

    def oreo?
      @line.include?('oreo') && @line.include?('bisc')
    end

    def monggo_chocolate?
      @line.include?('monggo') && @line.include?('mlk')
    end

    def icecream?
      @line.include?('walls') && @line.include?('mgnum')
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

    ####

    def tea_or_coffee?
      coffee?
    end

    def coffee?
      @line.include?('nescafe')
    end

    ####

    def fruits?
      banana? || apple? || melon?
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

    ####

    def vegetables?
      potato? || pepper? || zucchini? || tomato? || parsley?
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

    ####

    def dairy?
      cheese? || butter? || milk?
    end

    def cheese?
      ricotta? || slices? || mozarella?
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

    def butter?
      @line.include?('anchor') && @line.include?('pat')
    end

    def milk?
      @line.include?('greenfields') && @line.include?('fresh')
    end

    ####

    def bread?
      @line.include?('bread')
    end

    ####

    def meat?
      chicken?
    end

    def chicken?
      @line.include?('chicken')
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
    end

    ####

    def for_beer?
      pistachios?
    end

    def pistachios?
      @line.include?('sunkist') && @line.include?('rst')
    end

    ####

    def grocery?
    end

    ####

    def kitchen_stuff?
      tissue?
    end

    def tissue?
      @line.include?('paseo') && (@line.include?('tissue') || @line.include?('soft'))
    end

    ####

    def food_bag_or_delivery?
      @line.include?('linds') && @line.include?('tas') && @line.include?('kain')
    end
  end
end
