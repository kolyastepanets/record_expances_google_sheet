class ReceiveUsdFopFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  private

  def next_index_value_to_find
    3
  end

  def prepare_request_data
    @range = "'Статистика накоплений'!A#{start_line_to_search}:G#{end_line_to_search}"
  end

  def start_line_to_search
    15
  end

  def end_line_to_search
    3000
  end

  def find_by_word
    'СУММА ФОП'
  end

  def parse_response
    "usd fop in google sheet: #{balance_to_return}"
  end
end
