class ReceiveKolyaLeftMoney < GetOrSetDataInGoogleSheetBase
  include CallableService

  KOLYA_MONTH_BALANCE = 6000

  private

  def next_index_value_to_find
    3
  end

  def find_by_word
    'Коля'
  end

  def parse_response
    balance_to_return
  end
end
