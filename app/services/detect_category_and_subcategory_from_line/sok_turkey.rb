module DetectCategoryAndSubcategoryFromLine
  class SokTurkey < Default
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
      like_kinder? || snickers? || cookie_with_chocolate? || cookie?
    end

    def like_kinder?
      @line.include?('ozmo') && @line.include?('yumurta') && @line.include?('kafalar')
    end

    def snickers?
      @line.include?('snickers')
    end

    def cookie_with_chocolate?
      @line.include?('karmen') && @line.include?('beyaz') && @line.include?('çi̇kolat')
    end

    def cookie?
      @line.include?('tamköy') && @line.include?('tarsus') && @line.include?('çöreği̇')
    end

    ####

    def bread?
      just_bread?
    end

    def just_bread?
      @line.include?('ekmek') && @line.include?('odun')
    end

    ####

    def fruits?
      golden_apple?
    end

    def golden_apple?
      @line.include?('colden') && @line.include?('elma')
    end
  end
end
