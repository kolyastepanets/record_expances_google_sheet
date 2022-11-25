class FindCellToEnterVikaHalfExpenses < GetOrSetDataInGoogleSheetBase
  COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)
  KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_MONO = 'Vika total sum mono'.freeze
  KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_MONO_CELLS = 'Vika total sum mono cells'.freeze
  KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_CASH = 'Vika total sum cash'.freeze
  KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_CASH_CELLS = 'Vika total sum cash cells'.freeze
  KEY_FIND_CELL_SPENT_MYKOLA_TOTAL_SUM_MONO = 'Mykola total sum mono'.freeze
  KEY_FIND_CELL_SPENT_MYKOLA_TOTAL_SUM_MONO_CELLS = 'Mykola total sum mono cells'.freeze

  def initialize
    @month = Date.today.month
    @year_sheet = Date.today.year
  end

  private

  def prepare_request_data
    @range = "#{@year_sheet}!A#{start_line_to_search}:CJ#{end_line_to_search}"
  end

  def start_line_to_search
    60
  end

  def end_line_to_search
    120
  end

  def parse_response
    index_line_to_remember = 0
    index_column_to_remember = 0
    vika_total_sum_mono = 0
    vika_total_sum_mono_coordinates = ''
    vika_total_sum_mono_cells = ''
    vika_total_sum_mono_cells_coordinates = ''
    vika_total_sum_cash = 0
    vika_total_sum_cash_coordinates = ''
    vika_total_sum_cash_cells = ''
    vika_total_sum_cash_cells_coordinates = ''
    mykola_total_sum_mono = 0
    mykola_total_sum_mono_coordinates = ''
    mykola_total_sum_mono_cells = ''
    mykola_total_sum_mono_cells_coordinates = ''

    @response.values.each do |value_array|
      value_array.each_with_index do |value, index|
        index_column_to_remember = index if value == @month.to_s
      end
      break if !index_column_to_remember.zero?
    end

    index_value_to_update = index_column_to_remember + 1 # column, e.x. A, B, ..., AB, etc

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_MONO
          index_line_to_remember = value_array_index
          vika_total_sum_mono = value_array[index_value_to_update]
        end
      end
    end
    vika_total_sum_mono = vika_total_sum_mono.gsub(/[[:space:]]+/, "")
    vika_total_sum_mono_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_MONO_CELLS
          index_line_to_remember = value_array_index
          vika_total_sum_mono_cells = value_array[index_value_to_update]
        end
      end
    end
    vika_total_sum_mono_cells_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_CASH
          index_line_to_remember = value_array_index
          vika_total_sum_cash = value_array[index_value_to_update]
        end
      end
    end
    vika_total_sum_cash = vika_total_sum_cash.gsub(/[[:space:]]+/, "")
    vika_total_sum_cash_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_VIKA_TOTAL_SUM_CASH_CELLS
          index_line_to_remember = value_array_index
          vika_total_sum_cash_cells = value_array[index_value_to_update]
        end
      end
    end
    vika_total_sum_cash_cells_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_MYKOLA_TOTAL_SUM_MONO
          index_line_to_remember = value_array_index
          mykola_total_sum_mono = value_array[index_value_to_update]
        end
      end
    end
    mykola_total_sum_mono = mykola_total_sum_mono.gsub(/[[:space:]]+/, "")
    mykola_total_sum_mono_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    @response.values.each_with_index do |value_array, value_array_index|
      value_array.each do |value|
        if value == KEY_FIND_CELL_SPENT_MYKOLA_TOTAL_SUM_MONO_CELLS
          index_line_to_remember = value_array_index
          mykola_total_sum_mono_cells = value_array[index_value_to_update]
        end
      end
    end
    mykola_total_sum_mono_cells_coordinates = "#{COLUMN_LETTER[index_value_to_update]}#{start_line_to_search + index_line_to_remember}"

    {
      vika_total_sum_mono: vika_total_sum_mono.to_f,
      vika_total_sum_mono_coordinates: vika_total_sum_mono_coordinates,

      vika_total_sum_mono_cells: vika_total_sum_mono_cells,
      vika_total_sum_mono_cells_coordinates: vika_total_sum_mono_cells_coordinates,

      vika_total_sum_cash: vika_total_sum_cash.to_f,
      vika_total_sum_cash_coordinates: vika_total_sum_cash_coordinates,

      vika_total_sum_cash_cells: vika_total_sum_cash_cells,
      vika_total_sum_cash_cells_coordinates: vika_total_sum_cash_cells_coordinates,

      mykola_total_sum_mono: mykola_total_sum_mono.to_f,
      mykola_total_sum_mono_coordinates: mykola_total_sum_mono_coordinates,

      mykola_total_sum_mono_cells: mykola_total_sum_mono_cells,
      mykola_total_sum_mono_cells_coordinates: mykola_total_sum_mono_cells_coordinates,
    }
  end
end
