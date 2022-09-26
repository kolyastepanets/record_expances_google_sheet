module DetectCategoryAndSubcategoryFromLine
  class MarksAndSpencerShop < Default
    def fruits?
      @line.include?('bananas') || @line.include?('nectarines') || @line.include?('cherry') ||
        @line.include?('easypeel') || @line.include?('mango') || @line.include?('orangeloose') ||
        @line.include?('pomegranate')
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
  end
end
