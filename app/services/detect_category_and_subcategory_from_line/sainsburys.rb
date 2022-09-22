module DetectCategoryAndSubcategoryFromLine
  class Sainsburys < Default

    def alcohol?
      wine?
    end

    def wine?
      @line.include?('house') && @line.include?('rose')
    end

    ####

    def water?
      (@line.include?('evian') && @line.include?('water'))
    end

    ####

    def spices_and_seasonings?
    end

    ####

    def sweets?
      milka? || m_and_m? || @line.include?('milkyway') || kinder? || @line.include?('snickers')
    end

    def milka?
      @line.include?('milka')
    end

    def m_and_m?
      @line.include?('m&m') && @line.include?('pouch')
    end

    def kinder?
      @line.include?('kindr') && @line.include?('bueno')
    end

    ####

    def tea_or_coffee?
    end

    ####

    def bath_stuff?
      @line.include?('baby') && @line.include?('bath') || @line.include?('caddy') && @line.include?('liners')
    end

    ####

    def fruits?
      @line.include?('mangoes') || @line.include?('grapes') || @line.include?('strawbs') ||
        @line.include?('plums') || @line.include?('apples') || mandarin?
    end

    def mandarin?
      @line.include?('easy') && @line.include?('peel')
    end

    ####

    def dairy?
      cheese? || sweet_yogurt?
    end

    def cheese?
      (@line.include?('mini') && @line.include?('babybel'))
    end

    def sweet_yogurt?
      (@line.include?('petit') && @line.include?('frais'))
    end

    ####

    def eggs?
      @line.include?('jseggs')
    end

    ####

    def home_stuff?
      @line.include?('lurpak') && @line.include?('light') && @line.include?('block')
    end

    ####

    def vegetables?
      @line.include?('veg') && @line.include?('selection')
    end

    ####

    def bread?
    end

    ####

    def meat?
      beef? || chicken?
    end

    def beef?
      @line.include?('lean') && @line.include?('diced') && @line.include?('beef')
    end

    def chicken?
      @line.include?('chicken') && @line.include?('mince')
    end

    ####

    def fish?
      @line.include?('basa') && @line.include?('flts') || salmon?
    end

    def salmon?
      @line.include?('harbour') && @line.include?('smokehouse')
    end

    ####

    def sausage_and_sausages?
    end

    ####

    def for_beer?
      @line.include?('wlkr') && @line.include?('c&o')
    end
  end
end
