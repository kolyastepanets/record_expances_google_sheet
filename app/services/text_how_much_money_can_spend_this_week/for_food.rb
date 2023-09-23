module TextHowMuchMoneyCanSpendThisWeek
  class ForFood < Base
    def category_name
      "Еда"
    end

    def week_limit_spend
      170
    end
  end
end
