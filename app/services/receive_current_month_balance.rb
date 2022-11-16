class ReceiveCurrentMonthBalance < GetOrSetDataInGoogleSheetBase
  private

  def next_index_value_to_find
    2
  end

  def end_line_to_search
    105
  end

  def find_by_word
    'СУММА:'
  end

  def parse_response
    "Потрачено: #{balance_to_return}"
  end
end
