module DetectCategoryAndSubcategoryFromLine
  class Sainsburys < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

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
      milka? || m_and_m? || @line.include?('milkyway') || kinder? || @line.include?('snickers') ||
      condensed_milk?
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

    def condensed_milk?
      @line.include?('steinhauer') && @line.include?('milk')
    end

    ####

    def tea_or_coffee?
    end

    ####

    def bath_stuff?
      baby_bath? || caddy_liners? || tangle_teezer? || toner? || for_hair? || hair_comb?
    end

    def baby_bath?
      @line.include?('baby') && @line.include?('bath')
    end

    def caddy_liners?
      @line.include?('caddy') && @line.include?('liners')
    end

    def tangle_teezer?
      @line.include?('wet') && @line.include?('detangler')
    end

    def toner?
      @line.include?('msm') && @line.include?('exfoltoner')
    end

    def for_hair?
      @line.include?('elnett') && @line.include?('xtr') && @line.include?('stng') && @line.include?('hld')
    end

    def hair_comb?
      @line.include?('ss24') && @line.include?('mar') && @line.include?('g10')
    end

    ####

    def fruits?
      @line.include?('mangoes') || @line.include?('grapes') || @line.include?('strawbs') ||
        @line.include?('plums') || @line.include?('apples') || mandarin? || grapes_2? ||
        pomegranate?
    end

    def mandarin?
      @line.include?('easy') && @line.include?('peel')
    end

    def grapes_2?
      @line.include?('grape') && @line.include?('white')
    end

    def pomegranate?
      @line.include?('pomegranate')
    end

    ####

    def dairy?
      cheese? || sweet_yogurt? || milk? || yogurt_as_strawberry? || cheese_2? || cheese_3? ||
        yogurt? || yogurt_2?
    end

    def cheese?
      (@line.include?('mini') && @line.include?('babybel'))
    end

    def sweet_yogurt?
      (@line.include?('petit') && @line.include?('frais'))
    end

    def milk?
      @line.include?('cravendale') && @line.include?('whole')
    end

    def yogurt_as_strawberry?
      @line.include?('munch') && @line.include?('squashms')
    end

    def yogurt?
      @line.include?('valley') && @line.include?('yogurt')
    end

    def yogurt_2?
      @line.include?('petit') && @line.include?('strw') && @line.include?('rsp')
    end

    def cheese_2?
      @line.include?('miekpol') && @line.include?('krolewski')
    end

    def cheese_3?
      @line.include?('miekpol') && @line.include?('salamie')
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
      baton?
    end

    def baton?
      @line.include?('baton') && @line.include?('white')
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
      @line.include?('basa') && @line.include?('flts') || salmon? || herring?
    end

    def salmon?
      @line.include?('harbour') && @line.include?('smokehouse')
    end

    def herring?
      @line.include?('lisner') && @line.any? { |word| word.include?('snack') }
    end

    ####

    def sausage_and_sausages?
      poland_sausage? || salami? || pork_sausage? || sausages_2?
    end

    def poland_sausage?
      @line.include?('krakus') && @line.include?('zywiecka')
    end

    def salami?
      @line.include?('soklw') && @line.include?('slmi')
    end

    def pork_sausage?
      @line.include?('prk') && @line.include?('sausage')
    end

    def sausages_2?
      @line.include?('morliny') && @line.include?('brlnki')
    end

    ####

    def for_beer?
      smth_for_beer? || peanuts?
    end

    def smth_for_beer?
      @line.include?('wlkr') && @line.include?('c&o')
    end

    def peanuts?
      @line.include?('peanuts')
    end

    ####

    def pampers?
      @line.include?('pmpr') && @line.include?('dry')
    end

    ####

    def food_bag_or_delivery?
      food_bag?
    end

    def food_bag?
      @line.include?('bag') && @line.include?('for') && @line.include?('life')
    end

    ####

    def pharmacy?
      baby_cream?
    end

    def baby_cream?
      @line.include?("bepanthen") && @line.include?("ointment")
    end
  end
end
