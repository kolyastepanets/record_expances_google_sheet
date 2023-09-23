module TextHowMuchMoneyCanSpendThisWeek
  class ForHome < Base
    def category_name
      "Для дома"
    end

    def week_limit_spend
      70
    end
  end
end
