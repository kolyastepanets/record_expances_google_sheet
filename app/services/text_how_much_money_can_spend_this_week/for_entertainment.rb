module TextHowMuchMoneyCanSpendThisWeek
  class ForEntertainment < Base
    def category_name
      "Развлечения"
    end

    def week_limit_spend
      total_sum_for_previous_week > 5 ? (5 - (total_sum_for_previous_week - 5)).round(2) : 5
    end
  end
end
