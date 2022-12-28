class ReceiveCurrentMonthTaxesToPay < GetOrSetDataInGoogleSheetBase
  private

  def end_line_to_search
    85
  end

  def find_by_word
    'Налоги в грн'
  end

  def parse_response
    "To pay in #{Date::MONTHNAMES[Date.today.month]}: #{balance_to_return} uah"
  end
end
