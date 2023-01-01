class CommonExpensesFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
    @params = {
      category_name: nil,
      sub_category_name: nil,
      operation_amount: @transaction_data[:operationAmount].to_i.abs / 100.0,
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

  def build_common_params
    case @transaction_data[:description]
    when youtube
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'youtube'
    when -> (description) { description == "Лиля ❤️" && Date.today.day == 1 }
      @params[:category_name] = 'Лиля'
      @params[:sub_category_name] = nil
    when google_disk
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'google'
    when -> (description) { description == kolya_mama && Date.today.day == 1 }
      @params[:category_name] = 'Подарки'
      @params[:sub_category_name] = 'мама Коли'
    when -> (description) { description == liliia_papa && Date.today.day == 1 }
      @params[:category_name] = 'Подарки'
      @params[:sub_category_name] = 'Папа Лили'
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
    when -> (description) { ready_food.any? { |food| description.downcase.include?(food.downcase) } }
      @params[:category_name] = 'Еда'
      @params[:sub_category_name] = 'Готовая'
    when -> (description) { description.include?(uk_train) }
      @params[:category_name] = 'Транспорт'
      @params[:sub_category_name] = 'Поезд'
    when -> (description) { airlines.include?(description) }
      @params[:category_name] = 'Путешествия'
      @params[:sub_category_name] = 'Авиа билеты'
    when airbnb
      @params[:category_name] = 'Путешествия'
      @params[:sub_category_name] = 'аренда кв'
    when -> (description) { description.downcase.include?('банкомат') }
      @params[:category_name] = 'Кэш'
      @params[:sub_category_name] = nil
    end
  end

  def cambridge_buses
    ["STGCOACH/CTYLINK", "THE COACH YARD"]
  end

  def ready_food
    ["WASABI, SUSHI & BENTO", "mcdonald"]
  end

  def uk_train
    "trainline"
  end

  def airlines
    ["Wizz Air"]
  end

  def airbnb
    "AIRBNB"
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

  def liliia_papa
    "414949******0254"
  end

  def digital_ocean
    "DigitalOcean"
  end
end
