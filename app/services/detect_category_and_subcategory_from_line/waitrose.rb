module DetectCategoryAndSubcategoryFromLine
  class Waitrose < Default
    def call
    end

    ####

    def alcohol?
      wine?
    end

    def wine?
      @line.include?('beefsteak') && @line.include?('club') && @line.include?('malbe')
    end

    ####

    def water?
      mark_sweet_water? || lipton_tea?
    end

    def mark_sweet_water?
      (@line.include?('fruit') && @line.include?('shoot') && @line.include?('blkcrrnt')) ||
        (@line.include?('frt') && @line.include?('shts') && @line.include?('frts'))
    end

    def lipton_tea?
      @line.include?('lipton') && @line.include?('ice') && @line.include?('tea')
    end

    ####

    def spices_and_seasonings?
      @line.include?('mayonnaise') || sugar? || honey?
    end

    def sugar?
      @line.include?('silver') && @line.include?('spoon')
    end

    def honey?
      @line.include?('runny') && @line.include?('honey')
    end

    ####

    def sweets?
      ritter_sport? || lindt?
    end

    def lindt?
      @line.include?('lindt') && @line.include?('choc')
    end

    def ritter_sport?
      @line.include?('ritter') && @line.include?('sport')
    end

    ####

    def tea_or_coffee?
      starbucks?
    end

    def starbucks?
      @line.include?('starbcks') && @line.include?('house')
    end

    ####

    def bath_stuff?
      venus?
    end

    def venus?
      @line.include?('venus') && @line.include?('razor')
    end

    ####

    def fruits?
      @line.include?('sweetcorn') || @line.include?('lemon') || @line.include?('watermelon') || @line.include?('bananas')
    end

    ####

    def dairy?
      cheese? || kefir? || double_cream? || milk?
    end

    def cheese?
      (@line.include?('leerdammer') && @line.include?('original')) ||
        @line.include?('mozzarella')
    end

    def kefir?
      @line.include?('bio') && @line.include?('kefir')
    end

    def double_cream?
      @line.include?('yeo') && @line.include?('doub') && @line.include?('cream')
    end

    def milk?
      @line.include?('whole') && @line.include?('milk')
    end

    ####

    def vegetables?
      radish? || avocados? || tomatoes? || peppers? || leaves?
    end

    def radish?
      @line.include?('radish') #&& @line.include?('bunch')
    end

    def avocados?
      @line.include?('avocados')
    end

    def tomatoes?
      (@line.include?('vine') && @line.include?('classic') && @line.include?('toms')) ||
        (@line.include?('pome') && @line.include?('dei') && @line.include?('moro'))
    end

    def peppers?
      @line.include?('mixed') && @line.include?('peppers')
    end

    def leaves?
      (@line.include?('wild') && @line.include?('rocket')) ||
        (@line.include?('asparagus') && @line.include?('tips'))
    end

    ####

    def bread?
      ciabattas? || just_bread? || waffles? || (@line.include?('mini') && @line.include?('piadina'))
    end

    def ciabattas?
      @line.include?('half') && @line.include?('ciabattas')
    end

    def just_bread?
      @line.include?('white') && @line.include?('farmhouse')
    end

    def waffles?
      @line.include?('waffles') && @line.include?('jongens')
    end

    ####

    def meat?
      chiken?
    end

    def chiken?
      @line.include?('chkn') && @line.include?('legs')
    end

    ####

    def fish?
      prawns?
    end

    def prawns?
      @line.include?('prawns')
    end

    ####

    def sausage_and_sausages?
      ham?
    end

    def ham?
      @line.include?('torchon') && @line.include?('ham')
    end

    ####

    def for_beer?
      @line.include?('bear') && @line.include?('original')
    end
  end
end
