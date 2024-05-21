module DetectCategoryAndSubcategoryFromLine
  class TescoShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def fruits?
      blackberries? || strawberries? || pears? || bananas? || apples?
    end

    def blackberries?
      @line.include?('blackberries')
    end

    def strawberries?
      @line.include?('strawberries')
    end

    def pears?
      @line.include?('pears')
    end

    def bananas?
      @line.include?('bananas')
    end

    def apples?
      @line.include?('apple') && @line.include?('golden')
    end

    ####

    def sweets?
    end

    ####

    def ready_to_eat?
    end

    ####

    def dairy?
      salt_butter? || philadelphia_cheese? || soured_cream? || cravendale_milk? || cheese_slices?
    end

    def salt_butter?
      @line.include?('salted') && @line.include?('butter')
    end

    def philadelphia_cheese?
      @line.include?('philadelphia') && @line.include?('cheese')
    end

    def soured_cream?
      @line.include?('soured') && @line.include?('cream')
    end

    def cravendale_milk?
      @line.include?('cravendale') && @line.include?('milk')
    end

    def cheese_slices?
      @line.include?('cheese') && @line.include?('slices')
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
      mayonnaise? || lime_juice?
    end

    def mayonnaise?
      @line.include?('mayonnaise')
    end

    def lime_juice?
      @line.include?('lime') && @line.include?('juice')
    end

    ####

    def kitchen_stuff?
      washing_capsules?
    end

    def washing_capsules?
      @line.include?('washing') && @line.include?('capsules')
    end

    ####

    def tea_or_coffee?
    end

    ####

    def alcohol?
    end

    ####

    def food_bag_or_delivery?
    end

    ####

    def vegetables?
      asparagus? || avocado? || radish? || frozen_onions? || carrots? || garden_peas? ||
        potatoes? || cucumbers? || peppers? || garlic?
    end

    def asparagus?
      @line.include?('asparagus')
    end

    def avocado?
      @line.include?('avocado')
    end

    def radish?
      @line.include?('radish')
    end

    def frozen_onions?
      @line.include?('frozen') && @line.include?('onions')
    end

    def carrots?
      @line.include?('carrots')
    end

    def garden_peas?
      @line.include?('garden') && @line.include?('peas')
    end

    def potatoes?
      @line.include?('potatoes')
    end

    def cucumbers?
      @line.include?('cucumbers')
    end

    def peppers?
      @line.include?('peppers')
    end

    def garlic?
      @line.include?('garlic')
    end

    ####

    def sausage_and_sausages?
      paw_patrol? || unsmoked_bacon? || roast_ham? || cooked_ham?
    end

    def paw_patrol?
      @line.include?('paw') && @line.include?('patrol') && @line.include?('slices')
    end

    def unsmoked_bacon?
      @line.include?('unsmoked') && @line.include?('bacon')
    end

    def roast_ham?
      @line.include?('roast') && @line.include?('ham')
    end

    def cooked_ham?
      @line.include?('cooked') && @line.include?('ham')
    end

    ####

    def meat?
      chicken_drumsticks? || meatballs?
    end

    def chicken_drumsticks?
      @line.include?('chicken') && @line.include?('drumsticks')
    end

    def meatballs?
      @line.include?('meatballs')
    end

    ####

    def bread?
      wraps? || sliced_bread? || flour?
    end

    def wraps?
      @line.include?('wraps') && @line.include?('tortilla')
    end

    def sliced_bread?
      @line.include?('sliced') && @line.include?('white') && @line.include?('loaf')
    end

    def flour?
      @line.include?('flour')
    end

    ####

    def bath_stuff?
      shower_gel? || shaving_foam?
    end

    def shower_gel?
      @line.include?('shower') && @line.include?('gel')
    end

    def shaving_foam?
      @line.include?('shaving') && @line.include?('foam')
    end

    ####

    def home_stuff?
      cleaning_spray?
    end

    def cleaning_spray?
      @line.include?('cleaning') && @line.include?('spray')
    end

    ####

    def fish?
      prawns? || smoked_salmon?
    end

    def prawns?
      @line.include?('prawns')
    end

    def smoked_salmon?
      @line.include?('smoked') && @line.include?('salmon')
    end

    ####

    def grocery?
      basmati_rice? || spaghetti_pasta?
    end

    def basmati_rice?
      @line.include?('basmati') && @line.include?('rice')
    end

    def spaghetti_pasta?
      @line.include?('spaghetti') && @line.include?('pasta')
    end

    ####

    def ready_to_cook?
      baked_beans?
    end

    def baked_beans?
      @line.include?('baked') && @line.include?('beans')
    end

    ####

    def food_bag_or_delivery?
      pack_and_delivery?
    end

    def pack_and_delivery?
      @line.include?('pack') && @line.any? { |word| word.include?('deliver') }
    end
  end
end
