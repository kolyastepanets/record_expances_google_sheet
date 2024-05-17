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
      choc_cookies? || doughunt?
    end

    def choc_cookies?
      @line.include?('choc') && @line.include?('cookies')
    end

    def doughunt?
      @line.include?('doughnut') && @line.include?('choc')
    end

    ####

    def ready_to_eat?
    end

    ####

    def dairy?
      milk? || butter? || maasdam_cheese?
    end

    def milk?
      @line.include?('milk') && @line.include?('semiskim')
    end

    def butter?
      @line.include?('butter') && @line.any? { |word| word.include?('salted') }
    end

    def maasdam_cheese?
      @line.include?('slices') && @line.include?('1.89')
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
      tomato_sauce? || oil?
    end

    def tomato_sauce?
      @line.include?('italian') && @line.include?('passata')
    end

    def oil?
      @line.include?('oil')
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

    ####

    def alcohol?
      berries_wine?
    end

    def berries_wine?
      @line.include?('berries') && @line.include?('wine')
    end

    ####

    def food_bag_or_delivery?
      bag?
    end

    def bag?
      @line.include?('carrier')
    end

    ####

    def vegetables?
      red_onion? || potatoes? || carrots? || piccolo_tomatoes? || cucumbers? || dill? ||
        cabbage? || beetroot?
    end

    def red_onion?
      @line.include?('red') && @line.include?('onions')
    end

    def potatoes?
      @line.include?('potatoes')
    end

    def carrots?
      @line.include?('carrots')
    end

    def piccolo_tomatoes?
      @line.include?('piccolo') && @line.include?('tomatoes')
    end

    def cucumbers?
      @line.include?('cucumbers')
    end

    def dill?
      @line.include?('d111') && @line.include?('fresh')
    end

    def cabbage?
      @line.include?('cabbage')
    end

    def beetroot?
      @line.include?('beetroot')
    end

    ####

    def sausage_and_sausages?
      krakauer_sausage?
    end

    def krakauer_sausage?
      @line.include?('krakauer') && @line.include?('sausage')
    end

    ####

    def meat?
      beef_steak?
    end

    def beef_steak?
      @line.include?('frying') && @line.include?('stea')
    end

    ####

    def bread?
      baguette?
    end

    def baguette?
      @line.include?('baguette')
    end
  end
end
