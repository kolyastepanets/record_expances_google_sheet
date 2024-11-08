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
      can_show_final_sum: true,
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
      @params[:sub_category_name] = 'Онлайн-видео'
    when -> (description) { description == "Лиля ❤️" && Date.today.day == 1 && (@params[:price_in_uah].present? ? (@params[:price_in_uah] > 10000) : false) }
      @params[:category_name] = 'Лиля'
      @params[:sub_category_name] = nil
    when -> (description) { (description == "Лиля ❤️" || description.include?("Лілія С")) && !description.include?("Від: Лілія С") && Date.today.day == 1 && (@params[:price_in_uah].present? ? @params[:price_in_uah].between?(1500, 4000) : false) }
      @params[:category_name] = 'Марк'
      @params[:sub_category_name] = nil
    when -> (description) { (Date.today.day == 13 && description == 'Apple' && @params[:operation_amount] == 2.99) }
      @params[:category_name] = 'Марк'
      @params[:sub_category_name] = 'Книги'
    when -> (description) { (description == google_disk) || (Date.today.day == 3 && description == 'Apple' && @params[:operation_amount] == 1.99) }
      @params[:category_name] = 'Для дома'
      @params[:sub_category_name] = 'google'
    when -> (description) { description.include?(kolya_mama_start_card) && description.include?(kolya_mama_end_card) && Date.today.day == 1 && @params[:price_in_uah].between?(4900, 5100) }
      @params[:category_name] = 'Подарки'
      @params[:sub_category_name] = 'мама Коли'
    when -> (description) { description.include?(liliia_papa_start_card) && description.include?(liliia_papa_end_card) && Date.today.day == 1 && @params[:price_in_uah].between?(4900, 5100) }
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
    when -> (description) { description.downcase.include?(ENV['MYKOLA_PHONE_NUMBER']) }
      @params[:category_name] = 'Коля'
      @params[:sub_category_name] = 'Мобильный'
    when -> (description) { description.downcase.include?(ENV['LILIIA_PHONE_NUMBER']) }
      @params[:category_name] = 'Лиля'
      @params[:sub_category_name] = 'Мобильный'
    when bali_visa
      @params[:category_name] = 'Путешествия'
      @params[:sub_category_name] = 'Виза'
    when -> (description) { description.downcase.include?(bali_coffee) }
      @params[:category_name] = 'Еда'
      @params[:sub_category_name] = 'Кофе, Чай'
    end
  end

  def cambridge_buses
    ["STGCOACH/CTYLINK", "THE COACH YARD"]
  end

  def ready_food
    ["WASABI, SUSHI & BENTO", "mcdonald", "KIOSK MCD", "THE LEAVES CAFE EATERY"]
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
    "536354******4425"
  end

  def kladovka_2
    "431414****5779"
  end

  def kolya_mama_start_card
    "516875"
  end

  def kolya_mama_end_card
    "6402"
  end

  def liliia_papa_start_card
    "414949"
  end

  def liliia_papa_end_card
    "0254"
  end

  def digital_ocean
    "DigitalOcean"
  end

  def bali_visa
    "BAYU SANTERO 1 MBL"
  end

  def bali_coffee
    "bbs - nespresso"
  end
end
