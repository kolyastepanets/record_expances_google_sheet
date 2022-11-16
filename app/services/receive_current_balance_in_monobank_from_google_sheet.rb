class ReceiveCurrentBalanceInMonobankFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  private

  def end_line_to_search
    85
  end

  def find_by_word
    'Осталось черная моно грн'
  end

  def parse_response
    "uah in google sheet: #{balance_to_return}"
  end
end
