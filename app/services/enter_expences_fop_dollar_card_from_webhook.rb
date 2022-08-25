class EnterExpencesFopDollarCardFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
  end

  def call
    case @transaction_data["description"]
    when cambridge_bus
      # to put in Sidekiq
      # PutExpensesToGoogleSheet.call('Транспорт', 'Автобус', price_in_usd, Date.today.month)

      # result = CalculateTotalSpentUsdAndUah.call

      # # decrease usd saved amount
      # UpdateCommonCurrencyExpenses.call(
      #   result[:total_left_usd_money] - price_in_usd,
      #   result[:coordinates_of_total_left_usd_money],
      # )
      # to put in Sidekiq
    when mcdonalds
      # PutExpensesToGoogleSheet.call('Еда', 'Готовая', price_in_usd, Date.today.month)
    end
  end

  private

  def cambridge_bus
    "STGCOACH/CTYLINK"
  end

  def mcdonalds
    "McDonald's"
  end

  def price_in_usd
    @transaction_data["amount"].abs / 100.0
  end
end
