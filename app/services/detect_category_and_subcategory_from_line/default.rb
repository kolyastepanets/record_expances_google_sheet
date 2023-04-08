module DetectCategoryAndSubcategoryFromLine
  class Default
    include CallableService

    def initialize(line_from_receipt)
      @line = line_from_receipt.join.downcase
    end

    def call
      category_name = nil
      sub_category_name = nil

      if alcohol?
        category_name = 'Еда'
        sub_category_name = 'Алкоголь'
      elsif water?
        category_name = 'Еда'
        sub_category_name = 'Вода'
      elsif spices_and_seasonings?
        category_name = 'Еда'
        sub_category_name = 'Специи, приправы'
      elsif sweets?
        category_name = 'Еда'
        sub_category_name = 'Сладости'
      elsif tea_or_coffee?
        category_name = 'Еда'
        sub_category_name = 'Кофе, Чай'
      elsif fruits?
        category_name = 'Еда'
        sub_category_name = 'Фрукты'
      elsif vegetables?
        category_name = 'Еда'
        sub_category_name = 'Овощи'
      elsif dairy?
        category_name = 'Еда'
        sub_category_name = 'Молочка'
      elsif bread?
        category_name = 'Еда'
        sub_category_name = 'Хлеб и др'
      elsif meat?
        category_name = 'Еда'
        sub_category_name = 'Мясо'
      elsif fish?
        category_name = 'Еда'
        sub_category_name = 'Рыба'
      elsif sausage_and_sausages?
        category_name = 'Еда'
        sub_category_name = 'Колбаса, сосиски'
      elsif for_beer?
        category_name = 'Еда'
        sub_category_name = 'К пиву'
      elsif eggs?
        category_name = 'Еда'
        sub_category_name = 'Яйца'
      elsif grocery?
        category_name = 'Еда'
        sub_category_name = 'Бакалея'
      elsif food_bag_or_delivery?
        category_name = 'Еда'
        sub_category_name = 'Новопочта'
      elsif ready_to_cook?
        category_name = 'Еда'
        sub_category_name = 'Полуфабрикаты/морозилка'
      elsif bath_stuff?
        category_name = 'Для дома'
        sub_category_name = 'Ванные принадлежности'
      elsif kitchen_stuff?
        category_name = 'Для дома'
        sub_category_name = 'Кухонные принадлежности'
      elsif home_stuff?
        category_name = 'Для дома'
        sub_category_name = 'инвентарь'
      elsif pampers?
        category_name = 'Марк'
        sub_category_name = 'Памперсы'
      elsif mark_toys?
        category_name = 'Марк'
        sub_category_name = 'Игрушки'
      elsif liliia_bath_stuff?
        category_name = 'Лиля'
        sub_category_name = 'Ванные принадлежности'
      elsif liliia_clothes?
        category_name = 'Лиля'
        sub_category_name = 'Одежда'
      elsif pharmacy?
        category_name = 'Для дома'
        sub_category_name = 'Аптека'
      elsif mykola_bath_stuff?
        category_name = 'Коля'
        sub_category_name = 'Ванные принадлежности'
      end

      [category_name, sub_category_name]
    end

    private

    def alcohol?
    end

    def water?
    end

    def spices_and_seasonings?
    end

    def sweets?
    end

    def tea_or_coffee?
    end

    def fruits?
    end

    def vegetables?
    end

    def dairy?
    end

    def bread?
    end

    def meat?
    end

    def fish?
    end

    def sausage_and_sausages?
    end

    def for_beer?
    end

    def eggs?
    end

    def grocery?
    end

    def bath_stuff?
    end

    def home_stuff?
    end

    def food_bag_or_delivery?
    end

    def kitchen_stuff?
    end

    def ready_to_cook?
    end

    def pampers?
    end

    def mark_toys?
    end

    def liliia_bath_stuff?
    end

    def pharmacy?
    end

    def liliia_clothes?
    end

    def mykola_bath_stuff?
    end
  end
end
