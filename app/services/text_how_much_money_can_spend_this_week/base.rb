module TextHowMuchMoneyCanSpendThisWeek
  class Base < GetOrSetDataInGoogleSheetBase
    START_COLUMN = 'A2'
    CATEGORY_INDEX = 0
    PRICE_INDEX = 2
    DAY_INDEX = 3
    MONTH_INDEX = 4
    YEAR_INDEX = 5
    EXPIRE_TIME = 30.minutes

    def initialize
      @redis = Redis.new
      previous_week = (Date.today.at_beginning_of_week - 1.week)..(Date.today.at_end_of_week - 1.week)
      current_week = Date.today.at_beginning_of_week..Date.today.at_end_of_week
      @display_current_week = "#{current_week.first.strftime("%d %b %Y")} - #{current_week.last.strftime("%d %b %Y")}"
      @dates_previous_week = previous_week
        .to_a
        .map { |current_date| { day: current_date.day.to_s, months: [current_date.month.to_s, "#{current_date.month},1"], year: current_date.year.to_s } }
      @dates = current_week
        .to_a
        .map { |current_date| { day: current_date.day.to_s, months: [current_date.month.to_s, "#{current_date.month},1"], year: current_date.year.to_s } }
    end

    private

    def prepare_request_data
      @range = "'Повседневные'!#{START_COLUMN}:F"
    end

    def make_request
      all_expenses = @redis.get('all_expenses')
      if all_expenses.present?
        @response_values = JSON.parse(all_expenses)
        return @response_values
      end

      @response_values = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range).values
      @redis.set('all_expenses', @response_values.to_json, ex: EXPIRE_TIME)
    end

    def parse_response
      total_sum = total_sum_for_current_week

      left_to_spend = (week_limit_spend - total_sum).round(2)

      if left_to_spend.positive?
        text_left_to_spend = "Left to spend: $#{left_to_spend}"
        next_time_can_start_spending = ""
      else
        text_left_to_spend = "<b>WARNING! STOP spending! Overspending: $#{left_to_spend.abs}</b>"
        number_of_weeks_to_wait = (total_sum / week_limit_spend).round(0)
        week_can_start_spend = (Date.today.at_beginning_of_week + number_of_weeks_to_wait.weeks)..(Date.today.at_end_of_week + number_of_weeks_to_wait.weeks)
        next_time_can_start_spending = "<b>Next time can start spending: #{week_can_start_spend.first.strftime("%d %b %Y")} \- #{week_can_start_spend.last.strftime("%d %b %Y")}</b>"
      end

      "Spent on <b>#{category_name}</b> #{@display_current_week} in current week: $#{total_sum}\nWeek limit: $#{week_limit_spend}\n#{text_left_to_spend}\n#{next_time_can_start_spending}"
    end

    def total_sum_for_current_week
      return @total_sum_for_current_week if defined? @total_sum_for_current_week

      new_result = []
      total_sum = 0

      @response_values.each do |array_of_data|
        new_result << array_of_data if array_of_data[CATEGORY_INDEX] == category_name && fit_date?(@dates, array_of_data[DAY_INDEX], array_of_data[MONTH_INDEX], array_of_data[YEAR_INDEX])
      end

      new_result.each do |array_of_data|
        price = array_of_data[PRICE_INDEX].gsub(/[[:space:]]+/, "").delete("$").gsub(",",".").to_f
        total_sum += price
      end

      @total_sum_for_current_week = total_sum.round(2)
    end

    def total_sum_for_previous_week
      return @total_sum_for_previous_week if defined? @total_sum_for_previous_week

      new_result = []
      total_sum = 0

      @response_values.each do |array_of_data|
        new_result << array_of_data if array_of_data[CATEGORY_INDEX] == category_name && fit_date?(@dates_previous_week, array_of_data[DAY_INDEX], array_of_data[MONTH_INDEX], array_of_data[YEAR_INDEX])
      end

      new_result.each do |array_of_data|
        price = array_of_data[PRICE_INDEX].gsub(/[[:space:]]+/, "").delete("$").gsub(",",".").to_f
        total_sum += price
      end

      @total_sum_for_previous_week = total_sum.round(2)
    end

    def fit_date?(dates, day, month, year)
      dates.any? do |date|
        date[:day] == day && date[:months].include?(month) && date[:year] == year
      end
    end

    def category_name
      raise NoImplementedError
    end

    def week_limit_spend
      raise NoImplementedError
    end
  end
end
