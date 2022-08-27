class EnterExpencesUahBlackCardFromWebhook
  include CallableService

  def initialize(transaction_data)
    @transaction_data = transaction_data
    @params = {
      category_name: nil,
      sub_category_name: nil,
      price_in_uah: @transaction_data[:amount].abs / 100.0,
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
    when cambridge_bus
      @params[:category_name] = 'Транспорт'
      @params[:sub_category_name] = 'Автобус'
    end
  end

  def call_job
    return if @params[:category_name].nil?

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

  def cambridge_bus
    "STGCOACH/CTYLINK"
  end
end
