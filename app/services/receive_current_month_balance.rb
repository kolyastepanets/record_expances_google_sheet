class ReceiveCurrentMonthBalance < GetOrSetDataInGoogleSheetBase
  include CallableService

  private

  def next_index_value_to_find
    2
  end

  def find_by_word
    'СУММА:'
  end

  def parse_response
    balance_to_return
  end
end
