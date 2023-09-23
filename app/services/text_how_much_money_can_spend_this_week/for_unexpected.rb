module TextHowMuchMoneyCanSpendThisWeek
  class ForUnexpected < Base
    def category_name
      "Непредвиденное"
    end

    def week_limit_spend
      4
    end
  end
end
