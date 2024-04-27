module DetectCategoryAndSubcategoryFromLine
  class BimTurkey < Default
    ####

    def bath_stuff?
      soap?
    end

    def soap?
      @line.include?('şampuan') && @line.include?('dalin')
    end

    ####

    def eggs?
      @line.include?("yumurta")
    end

    ####

    def sweets?
      chocolate_cake? || snickers? || nutella? || biscuit? || kinder_biscuit?
    end

    def chocolate_cake?
      @line.include?("kek") && @line.include?("bit.çi̇kol")
    end

    def snickers?
      @line.include?("snickers")
    end

    def nutella?
      @line.include?("findkremasi") && @line.include?("kak")
    end

    def biscuit?
      @line.include?("biskuvi") && @line.include?("kak")
    end

    def kinder_biscuit?
      @line.include?("kekçi̇k.kap") && @line.include?("pingui")
    end

    ####

    def kitchen_stuff?
      wet_wipes? || dishcloth? || paper_towels?
    end

    def wet_wipes?
      @line.include?('islak') && @line.include?('havlu')
    end

    def dishcloth?
      @line.include?('temi̇zli̇k') && @line.include?('bezi̇')
    end

    def paper_towels?
      @line.include?('kağit') && @line.include?('havlugli') && @line.include?('blume')
    end

    ####

    def food_bag_or_delivery?
      food_bag?
    end

    def food_bag?
      @line.include?('alişveri̇ş') && @line.include?('poşeti') && @line.include?('bim')
    end

    ####

    def dairy?
      ayran? || milk? || yogurt? || cheddar_cheese?
    end

    def ayran?
      @line.include?('ayran')
    end

    def milk?
      @line.include?('süt') && @line.include?('dost')
    end

    def yogurt?
      @line.include?('yoğurt') && @line.include?('dost')
    end

    def cheddar_cheese?
      @line.include?('peynir') && @line.include?('cheddar')
    end

    ####

    def sausage_and_sausages?
      sausages? || ham? || ham_2? || salami?
    end

    def sausages?
      @line.include?('uzun') && @line.include?('sosis') && @line.include?('dana')
    end

    def ham?
      @line.include?('salam') && @line.include?('hindi')
    end

    def ham_2?
      @line.include?('hindi') && @line.include?('fume')
    end

    def salami?
      @line.include?('pilic') && @line.include?('salam')
    end

    ####

    def spices_and_seasonings?
      sunflower_oil?
    end

    def sunflower_oil?
      @line.include?('ayçiçek') && @line.include?('yaği') && @line.include?('sole')
    end

    ####

    def bread?
      just_bread? || baking_powder?
    end

    def just_bread?
      @line.include?('ekmek') && @line.include?('kepekli')
    end

    def baking_powder?
      @line.include?('kabartma') && @line.include?('tozu')
    end

    ####

    def for_beer?
      cashew?
    end

    def cashew?
      @line.include?('kavrulmuş') && @line.include?('kaju')
    end
  end
end
