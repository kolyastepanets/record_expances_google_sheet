class ReceiveJointMonzoGbpFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  COLUMN_LETTER = ('A'..'G').to_a
  KEY_FIND_CELL_LEFT_WISE_MONEY = "GBP Joint Monzo".freeze
  NEXT_SECOND_CELL = 2

  def initialize(value_render_option: 'FORMULA')
    @year = Date.today.year
    @value_render_option = value_render_option
  end

  private

  def prepare_request_data
    @range = "'Статистика накоплений'!A#{start_line_to_search}:G#{end_line_to_search}"
  end

  def start_line_to_search
    1
  end

  def end_line_to_search
    1000
  end

  def make_request
    @response = service_google_sheet.get_spreadsheet_values(ENV['FIN_PLAN_SPREAD_SHEET_ID'], @range, value_render_option: @value_render_option)
  end

  def parse_response
    gbp_monzo_formula = ''
    index_line_to_remember = 0
    start_looking_after_year = false

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        start_looking_after_year = true if value == @year

        if value == KEY_FIND_CELL_LEFT_WISE_MONEY && start_looking_after_year
          gbp_monzo_formula = value_array[NEXT_SECOND_CELL]
          index_line_to_remember = value_array_index
        end
      end
      break if !index_line_to_remember.zero?
    end

    {
      gbp_joint_monzo_formula: gbp_monzo_formula,
      coordinates_of_joint_gbp_monzo_formula: "#{COLUMN_LETTER[NEXT_SECOND_CELL]}#{start_line_to_search + index_line_to_remember}",
    }
  end
end
