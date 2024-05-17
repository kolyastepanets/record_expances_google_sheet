module DetectCategoryAndSubcategoryFromLine
  class MarksAndSpencerShop < Default
    def fruits?
      @line.include?('bananas') || @line.include?('nectarines') || @line.include?('cherry') ||
        @line.include?('easypeel') || @line.include?('mango') || @line.include?('orangeloose') ||
        @line.include?('pomegranate') || grape?
    end

    def grape?
      @line.include?('grape') && @line.include?('white')
    end

    ####

    def sweets?
      happy_lollies?
    end

    def happy_lollies?
      @line.include?('happy') && @line.include?('lollies')
    end

    ####

    def meat?
      chiken_wings? || turkey?
    end

    def chiken_wings?
      @line.include?('ogwings')
    end

    def turkey?
      @line.include?('trky') && @line.include?('fil')
    end

    ####

    def ready_to_eat?
      sandwich?
    end

    def sandwich?
      @line.include?('coronation') && @line.include?('chic')
    end

    ####

    def dairy?
      strawberry_yogurt?
    end

    def strawberry_yogurt?
      @line.include?('strawberry') && @line.include?('29381142')
    end
  end
end
