module TextHowMuchMoneyCanSpendThisWeek
  class ForTravelling < Base
    def category_name
      "Путешествия"
    end

    def week_limit_spend
      100
    end
  end
end
