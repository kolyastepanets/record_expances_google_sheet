module TextHowMuchMoneyCanSpendThisWeek
  class ForFood < Base
    def category_name
      "Еда"
    end

    def week_limit_spend
      total_sum_for_previous_week > 170 ? (170 - (total_sum_for_previous_week - 170)).round(2) : 170
    end
  end
end
