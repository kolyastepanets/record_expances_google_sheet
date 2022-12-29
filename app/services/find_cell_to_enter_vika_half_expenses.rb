class FindCellToEnterVikaHalfExpenses < GetOrSetDataInGoogleSheetBase
  COLUMN_LETTER = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)
  KEY_FIND_CELL_VIKA_TOTAL_SPENT_USD = 'Vika total spent usd'.freeze
  KEY_FIND_CELL_VIKA_TOTAL_SPENT_UAH = 'Vika total spent uah'.freeze
  KEY_FIND_CELL_MYKOLA_TOTAL_SPENT_USD = 'Mykola total spent usd'.freeze
  KEY_FIND_CELL_MYKOLA_TOTAL_SPENT_UAH = 'Mykola total spent uah'.freeze

  def initialize
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
    vika_total_spent_usd = ''
    vika_total_spent_uah = ''
    mykola_total_spent_usd = ''
    mykola_total_spent_uah = ''

    @response.values.each do |value_array|
      value_array.each_with_index do |value, value_array_index|
        if value == KEY_FIND_CELL_VIKA_TOTAL_SPENT_USD
          vika_total_spent_usd = value_array[value_array_index + 1]
        end
      end
    end

    @response.values.each do |value_array|
      value_array.each_with_index do |value, value_array_index|
        if value == KEY_FIND_CELL_VIKA_TOTAL_SPENT_UAH
          vika_total_spent_uah = value_array[value_array_index + 1]
        end
      end
    end
    vika_total_spent_uah = vika_total_spent_uah.delete("грн").gsub(/[[:space:]]+/, "").to_f

    @response.values.each do |value_array|
      value_array.each_with_index do |value, value_array_index|
        if value == KEY_FIND_CELL_MYKOLA_TOTAL_SPENT_USD
          mykola_total_spent_usd = value_array[value_array_index + 1]
        end
      end
    end

    @response.values.each do |value_array|
      value_array.each_with_index do |value, value_array_index|
        if value == KEY_FIND_CELL_MYKOLA_TOTAL_SPENT_UAH
          mykola_total_spent_uah = value_array[value_array_index + 1]
        end
      end
    end
    mykola_total_spent_uah = mykola_total_spent_uah.delete("грн").gsub(/[[:space:]]+/, "").to_f

    {
      vika_total_spent_usd: vika_total_spent_usd,
      vika_total_spent_uah: vika_total_spent_uah,

      mykola_total_spent_usd: mykola_total_spent_usd,
      mykola_total_spent_uah: mykola_total_spent_uah,
    }
  end
end
