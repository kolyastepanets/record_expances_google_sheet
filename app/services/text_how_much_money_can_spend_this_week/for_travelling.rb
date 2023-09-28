module TextHowMuchMoneyCanSpendThisWeek
  class ForTravelling < Base
    def initialize
      @redis = Redis.new
      @current_period = Date.parse("01-10-2023")..Date.today.at_end_of_week
      @dates = @current_period
        .to_a
        .map { |current_date| { day: current_date.day.to_s, months: [current_date.month.to_s, "#{current_date.month},1"], year: current_date.year.to_s } }
    end

    def category_name
      "Путешествия"
    end

    def week_limit_spend
      100
    end

    def month_limit_spend
      500
    end

    def parse_response
      total_spend_already = total_sum_for_period

      total_count_months = @current_period.to_a.map { |current_date| current_date.month }.uniq.size
      max_allow_to_spend = total_count_months * month_limit_spend

      if max_allow_to_spend > total_spend_already
        count_months = (Date.parse("01-10-2023")..(Date.today.at_beginning_of_week)).to_a.map { |current_date| current_date.month }.uniq.size
        how_much_can_spend = (count_months * month_limit_spend - total_spend_already).round(2)
        text_how_much_can_spend = "Now can spend: $#{how_much_can_spend}"
        next_time_can_start_spending = ""
      else
        number_of_weeks_to_wait = ((total_spend_already - max_allow_to_spend) / week_limit_spend).round(0)
        week_can_start_spend = (Date.today.at_beginning_of_week + number_of_weeks_to_wait.weeks)..(Date.today.at_end_of_week + number_of_weeks_to_wait.weeks)
        count_months = (Date.parse("01-10-2023")..(Date.today.at_beginning_of_week + number_of_weeks_to_wait.weeks)).to_a.map { |current_date| current_date.month }.uniq.size
        how_much_can_spend = (count_months * month_limit_spend - total_spend_already).round(2)
        text_how_much_can_spend = "Next time can spend: $#{how_much_can_spend}"
        next_time_can_start_spending = "<b>Next time can start spending: #{week_can_start_spend.first.strftime("%d %b %Y")} \- #{week_can_start_spend.last.strftime("%d %b %Y")}</b>"
      end

      "Spent on <b>#{category_name}</b>: $#{total_spend_already}\nMonth limit: $#{month_limit_spend}\n#{text_how_much_can_spend}\n#{next_time_can_start_spending}"
    end

    def total_sum_for_period
      return @total_sum_for_period if defined? @total_sum_for_period

      new_result = []
      total_sum = 0

      @response_values.each do |array_of_data|
        new_result << array_of_data if array_of_data[CATEGORY_INDEX] == category_name && fit_date?(@dates, array_of_data[DAY_INDEX], array_of_data[MONTH_INDEX], array_of_data[YEAR_INDEX])
      end

      new_result.each do |array_of_data|
        price = array_of_data[PRICE_INDEX].gsub(/[[:space:]]+/, "").delete("$").gsub(",",".").to_f
        total_sum += price
      end

      @total_sum_for_period = total_sum.round(2)
    end
  end
end
