class EnterExpencesFopDollarCardFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
    @params = {
      category_name: nil,
      sub_category_name: nil,
      price_in_usd: @transaction_data[:amount].abs / 100.0,
      current_month: Date.today.month,
      mono_description: @transaction_data[:description],
    }
  end

  def call
    build_params
    call_job
  end

  private

  def build_params
    case @transaction_data[:description]
    when -> (description) { cambridge_buses.include?(description) }
      @params[:category_name] = 'Транспорт'
      @params[:sub_category_name] = 'Автобус'
    when mcdonalds
      @params[:category_name] = 'Еда'
      @params[:sub_category_name] = 'Готовая'
    when sold_dollars_from_fop
      grivnas = @transaction_data[:operationAmount].abs / 100.0
      dollars = @transaction_data[:amount].abs / 100.0

      result = CalculateTotalSpentUsdAndUah.call

      # increase uah amount
      UpdateCommonCurrencyExpenses.call(
        result[:total_left_uah_money] + grivnas,
        result[:coordinates_of_total_left_uah_money],
      )

      # decrease usd amount
      UpdateCommonCurrencyExpenses.call(
        result[:total_left_usd_money] - dollars,
        result[:coordinates_of_total_left_usd_money],
      )
    end
  end

  def call_job
    return if @params[:category_name].nil?

    PutExpencesFopDollarCardJob.perform_later(@params)
  end

  def cambridge_buses
    ["STGCOACH/CTYLINK", "THE COACH YARD"]
  end

  def mcdonalds
    "McDonald’s"
  end

  def sold_dollars_from_fop
    "На гривневый счет ФОП для перевода на карту"
  end
end
