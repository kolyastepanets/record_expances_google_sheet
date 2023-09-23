module TextHowMuchMoneyCanSpendThisWeek
  class ForUnexpected < Base
    def category_name
      "Непредвиденное"
    end

    def week_limit_spend
      total_sum_for_previous_week > 4 ? (4 - (total_sum_for_previous_week - 4)).round(2) : 4
    end
  end
end
