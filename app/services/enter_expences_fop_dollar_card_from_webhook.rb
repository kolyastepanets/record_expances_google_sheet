class EnterExpencesFopDollarCardFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
    @params = {
      category_name: nil,
      sub_category_name: nil,
      price_in_usd: @transaction_data[:amount].abs / 100.0,
      operation_amount: @transaction_data[:operationAmount].abs / 100.0,
      current_month: Date.today.month,
      mono_description: @transaction_data[:description],
      currency_rate: currency_rate,
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
    when -> (description) { ready_food.include?(description) }
      @params[:category_name] = 'Еда'
      @params[:sub_category_name] = 'Готовая'
    when uk_train
      @params[:category_name] = 'Транспорт'
      @params[:sub_category_name] = 'Поезд'
    when wizz_air
      @params[:category_name] = 'Путешествия'
      @params[:sub_category_name] = 'Авиа билеты'
    when sold_dollars_from_fop
      @params = {
        sold_dollars_from_fop: true,
        grivnas: @transaction_data[:operationAmount].abs / 100.0,
        dollars: @transaction_data[:amount].abs / 100.0,
      }
    end
  end

  def call_job
    return EnterSoldDollarsFromFopJob.perform_later(@params) if @params[:sold_dollars_from_fop]
    return PutExpencesFopDollarCardJob.perform_later(@params) if @params[:category_name].present?

    SendMessageToBotToAskToEnterExpences.call(@transaction_data.merge(is_fop_dollar: true))
  end

  def cambridge_buses
    ["STGCOACH/CTYLINK", "THE COACH YARD"]
  end

  def ready_food
    ["WASABI, SUSHI & BENTO", "McDonald’s"]
  end

  def sold_dollars_from_fop
    "На гривневый счет ФОП для перевода на карту"
  end

  def uk_train
    "thetrainline.com"
  end

  def wizz_air
    "Wizz Air"
  end

  def currency_rate
    price_in_usd = @transaction_data[:amount].abs / 100.0
    operation_amount = @transaction_data[:operationAmount].abs / 100.0

    currency_rate = operation_amount / price_in_usd
    currency_rate = currency_rate.to_s
    currency_rate = currency_rate.split('.')
    "#{currency_rate[0]}.#{currency_rate[1].first(4)}".to_f
  end
end
