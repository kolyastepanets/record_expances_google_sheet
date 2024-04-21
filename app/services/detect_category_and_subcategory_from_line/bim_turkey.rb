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
      chocolate_cake? || snickers? || nutella? || biscuit?
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
      ayran?
    end

    def ayran?
      @line.include?('ayran')
    end
  end
end
