class ReceiveTotalFopSavedMoneyFromGoogleSheet < GetOrSetDataInGoogleSheetBase
  private

  def next_index_value_to_find
    3
  end

  def prepare_request_data
    @range = "'Статистика накоплений'!A1:D"
  end

  def find_by_word
    'СУММА ФОП'
  end

  def parse_response
    saved = @response.values
                     .drop_while { |arrays| arrays != [Date.today.year.to_s] }
                     .drop(1)
                     .detect { |item| item[0] == "СУММА ФОП" }
                     .last

    "total fop saved money in google sheet: #{saved}"
  end
end
