module DetectCategoryAndSubcategoryFromLine
  class Default
    include CallableService

    def initialize(line_from_receipt)
      @line = line_from_receipt.downcase
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
      elsif bath_stuff?
        category_name = 'Для дома'
        sub_category_name = 'Ванные принадлежности'
      elsif home_stuff?
        category_name = 'Для дома'
        sub_category_name = 'Инвентарь'
      end

      [category_name, sub_category_name]
    end
  end
end
