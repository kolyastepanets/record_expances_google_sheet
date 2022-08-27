class EnterExpencesFopDollarCardFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
    @params = {
      category_name: nil,
      sub_category_name: nil,
      price_in_usd: @transaction_data[:amount].abs / 100.0,
      current_month: Date.today.month,
    }
  end

  def call
    build_params
    call_job
  end

  private

  def build_params
    case @transaction_data[:description]
    when cambridge_bus
      @params[:category_name] = 'Транспорт'
      @params[:sub_category_name] = 'Автобус'
    when mcdonalds
      @params[:category_name] = 'Еда'
      @params[:sub_category_name] = 'Готовая'
    end
  end

  def call_job
    return if @params[:category_name].nil?

    PutExpencesFopDollarCardJob.perform_later(@params)
  end

  def cambridge_bus
    "STGCOACH/CTYLINK"
  end

  def mcdonalds
    "McDonald's"
  end
end
