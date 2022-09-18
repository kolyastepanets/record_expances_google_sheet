class EnterExpencesUahBlackCardFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
    @params = {
      category_name: nil,
      sub_category_name: nil,
      price_in_uah: @transaction_data[:amount].abs / 100.0,
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
    when youtube
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'youtube'
    when -> (description) { description == "Лиля ❤️" && @params[:price_in_uah] == 18000 }
      @params[:category_name] = 'Лиля'
      @params[:sub_category_name] = nil
    when google_disk
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'google'
    when -> (description) { description == kolya_mama && @params[:price_in_uah] == 3000 }
      @params[:category_name] = 'Подарки'
      @params[:sub_category_name] = 'мама Коли'
    when kladovka_1
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'кладовка'
    when kladovka_2
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'кладовка'
    when digital_ocean
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'Сервак, впн'
    when -> (description) { cambridge_buses.include?(description) }
      @params[:category_name] = 'Транспорт'
      @params[:sub_category_name] = 'Автобус'
    end
  end

  def call_job
    return SendMessageToBotToAskToEnterExpences.call(@transaction_data) if @params[:category_name].nil?

    PutExpencesUahBlackCardJob.perform_later(@params)
  end

  def youtube
    "YouTube"
  end

  def google_disk
    "Google"
  end

  def kladovka_1
    "536354******0388"
  end

  def kladovka_2
    "431414******3237"
  end

  def kolya_mama
    "516875******6402"
  end

  def cambridge_buses
    ["STGCOACH/CTYLINK", "THE COACH YARD"]
  end

  def digital_ocean
    "DigitalOcean"
  end

  def currency_rate
    price_in_uah = @transaction_data[:amount].abs / 100.0
    operation_amount = @transaction_data[:operationAmount].abs / 100.0

    currency_rate = price_in_uah / operation_amount
    currency_rate = currency_rate.to_s
    currency_rate = currency_rate.split('.')
    "#{currency_rate[0]}.#{currency_rate[1].first(4)}".to_f
  end
end
