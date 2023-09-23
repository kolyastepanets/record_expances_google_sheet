module TextHowMuchMoneyCanSpendThisWeek
  class ForHome < Base
    def category_name
      "Для дома"
    end

    def week_limit_spend
      total_sum_for_previous_week > 70 ? (70 - (total_sum_for_previous_week - 70)).round(2) : 70
    end
  end
end
