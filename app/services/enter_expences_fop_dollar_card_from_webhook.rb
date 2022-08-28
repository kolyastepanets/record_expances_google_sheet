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
      @params = {
        sold_dollars_from_fop: true,
        grivnas: @transaction_data[:operationAmount].abs / 100.0,
        dollars: @transaction_data[:amount].abs / 100.0,
      }
    end
  end

  def call_job
    EnterSoldDollarsFromFopJob.perform_later(@params) if @params[:sold_dollars_from_fop]
    PutExpencesFopDollarCardJob.perform_later(@params) if @params[:category_name].present?
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
