module TextHowMuchMoneyCanSpendThisWeek
  class ForEntertainment < Base
    def category_name
      "Развлечения"
    end

    def week_limit_spend
      5
    end
  end
end
