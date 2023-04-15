class MarkPaidForMonthPoolman < GetOrSetDataInGoogleSheetBase
  START_COLUMN = 'A2'
  MONTH_INDEX = 1
  YEAR_INDEX = 2
  FULL_DATE_INDEX = 3
  PAID_COLUMN_INDEX = 4
  INCREASE_INDEX_TO_MATCH_ROW_NUMBER= 2

  def initialize
    @previous_month = (Date.today.month - 1).to_s
    @current_month = Date.today.month.to_s
    @year = Date.today.year.to_s
    @data_for_2_months = []
  end

  def call
    get_data_for_2_months
    make_paid
  end

  private

  def get_data_for_2_months
    @range = "'Pool man'!#{START_COLUMN}:E"
    make_request
    @response.values.each.with_index do |array_of_data, index|
      @data_for_2_months << [array_of_data[FULL_DATE_INDEX], array_of_data[PAID_COLUMN_INDEX], index + INCREASE_INDEX_TO_MATCH_ROW_NUMBER] if [@previous_month, @current_month].include?(array_of_data[MONTH_INDEX]) && array_of_data[YEAR_INDEX] == @year
    end
    @data_for_2_months
  end

  def make_paid
    @data_for_2_months.each do |data|
      next if data[1].present?

      UpdateCellInGoogleSheet.call(
        '✔',
        "E#{data[2]}",
        page: 'Pool man'
      )
    end
  end
end
