module DetectCategoryAndSubcategoryFromLine
  class LidlShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def fruits?
      plums? || mango?
    end

    def plums?
      @line.include?('plums') && @line.include?('0080414')
    end

    def mango?
      @line.include?('mango') && @line.include?('loose')
    end

    ####

    def sweets?
      choc_cookies?
    end

    def choc_cookies?
      @line.include?('choc') && @line.include?('cookies')
    end

    ####

    def meat?
    end

    ####

    def ready_to_eat?
    end

    ####

    def dairy?
      milk? || butter?
    end

    def milk?
      @line.include?('milk') && @line.include?('semiskim')
    end

    def butter?
      @line.include?('butter') && @line.any? { |word| word.include?('salted') }
    end

    ####

    def eggs?
      eggs_1?
    end

    def eggs_1?
      @line.include?('eggs')
    end

    ####

    def spices_and_seasonings?
      tomato_sauce?
    end

    def tomato_sauce?
      @line.include?('italian') && @line.include?('passata')
    end

    ####

    def kitchen_stuff?
      salt_shaker?
    end

    def salt_shaker?
      @line.include?('saltshakercoursesalt')
    end

    ####

    def tea_or_coffee?
      indonesia_coffee?
    end

    def indonesia_coffee?
      @line.include?('indonesia') && @line.include?('instant')
    end

  end
end
