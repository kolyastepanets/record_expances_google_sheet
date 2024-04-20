module DetectCategoryAndSubcategoryFromLine
  class SokTurkey < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    ####

    def bath_stuff?
      bath_tissue?
    end

    def bath_tissue?
      @line.include?('confort') && @line.include?('havlu')
    end

    ####

    def grocery?
      piyale? || barilla?
    end

    def piyale?
      @line.include?('pi̇yale') && @line.include?('uzun')
    end

    def barilla?
      @line.include?('barilla') && @line.include?('spaghetti')
    end

    ####

    def tea_or_coffee?
      lipton? || jacobs?
    end

    def lipton?
      @line.include?('lipton')
    end

    def jacobs?
      @line.include?('jacobs')
    end

    ####

    def dairy?
      milk? || ayran?
    end

    def milk?
      @line.include?('mis') && @line.include?('uht') && @line.include?('süt')
    end

    def ayran?
      @line.include?('ayran')
    end

    ####

    def sausage_and_sausages?
      maret?
    end

    def maret?
      @line.include?('maret') && @line.include?('enfes') && @line.include?('macar')
    end

    ####

    def spices_and_seasonings?
      sunflower_oil?
    end

    def sunflower_oil?
      @line.include?('evi̇n') && @line.include?('ayçi̇çekyaği')
    end

    ####

    def sweets?
      like_kinder?
    end

    def like_kinder?
      @line.include?('ozmo') && @line.include?('yumurta') && @line.include?('kafalar')
    end
  end
end
