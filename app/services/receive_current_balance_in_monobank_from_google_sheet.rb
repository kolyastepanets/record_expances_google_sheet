class ReceiveCurrentBalanceInMonobankFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  include CallableService

  private

  def end_line_to_search
    105
  end

  def find_by_word
    'сейчас на моно'
  end

  def parse_response
    "uah in google sheet: #{balance_to_return}"
  end
end
