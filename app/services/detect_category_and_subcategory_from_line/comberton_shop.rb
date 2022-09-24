module DetectCategoryAndSubcategoryFromLine
  class CombertonShop < Default
    def for_beer?
      @line.include?('walkers') && @line.include?('crisps')
    end

    ####

    def dairy?
      (@line.include?('elmlea') && @line.include?('double')) ||
        cheese? || butter? || milk?
    end

    def milk?
      @line.include?('whole') && @line.include?('fresh') && @line.include?('mil')
    end

    def butter?
      @line.include?('butter') && @line.include?('slightly')
    end

    def cheese?
      @line.include?('mozzarella')
    end

    ####

    def alcohol?
      wine?
    end

    def wine?
      @line.include?('beefstk') && @line.include?('liberty') && @line.include?('malbec')
    end

    def spices_and_seasonings?
      @line.include?('sauce') && @line.include?('soy')
    end
  end
end
