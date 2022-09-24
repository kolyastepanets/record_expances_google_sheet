module DetectCategoryAndSubcategoryFromLine
  class PolishShop < Default
    def sweets?
      merci? || merci_dark? || czekolada? || oreo? || kinder?
    end

    def merci?
      @line.include?('coffee') && @line.include?('cream') && @line.include?('merci')
    end

    def merci_dark?
      @line.include?('dark') && @line.include?('merci')
    end

    def czekolada?
      @line.include?('czekolada')
    end

    def oreo?
      @line.include?('oreo')
    end

    def kinder?
      @line.include?('kinder')
    end

    ####

    def dairy?
      smetana? || butter? || cottage_cheese?
    end

    def smetana?
      @line.include?('milandia') && @line.include?('serek') && @line.include?('smiet')
    end

    def butter?
      @line.include?('maslo') && @line.include?('polskie')
    end

    def cottage_cheese?
      @line.include?('twarog')
    end

    ####

    def for_beer?
      @line.include?('mini') && @line.include?('golka')
    end

    ####

    def spices_and_seasonings?
      @line.include?('buraczki') && @line.include?('pap')
    end

    ####

    def meat?
      @line.include?('butchery')
    end

    ####

    def grocery?
      porridge?
    end

    def porridge?
      @line.include?('kasza')
    end

    ####

    def sausage_and_sausages?
      @line.include?('kielbasa')
    end
  end
end
