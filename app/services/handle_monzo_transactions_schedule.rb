class HandleMonzoTransactionsSchedule
  include CallableService

  def initialize
    @redis = Redis.new
  end

  def call
    @redis.scan_each(match: 'monzo_transaction_id_*') do |key|
      params = JSON.parse(@redis.get(key)).deep_symbolize_keys
      next if params[:already_sent_to_bot]

      handle_monzo_transaction(params)
      update_redis(key, params)
    end
  end

  private

  def handle_monzo_transaction(params)
    amount = (params[:data][:amount].to_i.abs / 100.0).round(2)

    if money_from_joint_to_personal?(params)
      withdraw_from_joint_account(amount)
      add_to_personal_account(amount)
      send_notification_to_bot("£#{amount} was transferred from Joint Monzo to Personal Monzo account.")
      return
    end

    if transaction_money_from_joint_to_personal?(params)
      return
    end

    if money_from_personal_to_joint?(params)
      withdraw_from_personal_account(amount)
      add_to_joint_account(amount)
      send_notification_to_bot("£#{amount} was transferred from Personal Monzo account to Joint Monzo.")
      return
    end

    if transaction_money_from_personal_to_joint?(params)
      return
    end

    if salary?(params)
      add_to_personal_account(amount)
      send_notification_to_bot("Salary £#{amount} was saved to Personal Monzo account.")
      return
    end

    if youtube?(params)
      withdraw_from_joint_account(amount)
      save_to_google_sheet('Для дома', 'Онлайн-видео', amount)
      send_notification_to_bot("Youtube premium £#{amount} was spent from Joint account.")
      return
    end

    if google_storage?(params)
      withdraw_from_joint_account(amount)
      save_to_google_sheet('Для дома', 'google', amount)
      send_notification_to_bot("Google storage £#{amount} was spent from Joint account.")
      return
    end

    if digital_ocean?(params)
      withdraw_from_joint_account(amount)
      save_to_google_sheet('Для дома', 'Сервак, впн', amount)
      send_notification_to_bot("Digital Ocean £#{amount} was spent from Joint account.")
      return
    end

    if lebara_1?(params)
      withdraw_from_joint_account(amount)
      save_to_google_sheet('Коля', 'Мобильный', amount)
      send_notification_to_bot("Lebara Коля £#{amount} was spent from Joint account.")
      return
    end

    if lebara_2?(params)
      withdraw_from_joint_account(amount)
      save_to_google_sheet('Лиля', 'Мобильный', amount)
      send_notification_to_bot("Lebara Лиля £#{amount} was spent from Joint account.")
      return
    end

    if rebel_energy?(params)
      withdraw_from_joint_account(amount)
      save_to_google_sheet('Для дома', 'комуналка', amount)
      send_notification_to_bot("Rebel Energy £#{amount} was spent from Joint account.")
      return
    end

    # virgin media
    # ready food
    # council tax
    # water
    # tesco subscription
    # netflix

    send_ask_message_to_bot(params)
  end

  def money_from_joint_to_personal?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && params[:data][:description] == ENV['MY_MONZO_NAME'] && params[:data][:amount].negative?
  end

  def withdraw_from_joint_account(amount)
    result = ReceiveJointMonzoGbpFromGoogleSheet.call
    price_to_put_in_sheets = "#{result[:gbp_joint_monzo_formula]} - #{amount.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_joint_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end

  def add_to_personal_account(amount)
    result = ReceiveMonzoGbpFromGoogleSheet.call
    increased_price_to_put_in_sheets = "#{result[:gbp_monzo_formula]} + #{amount.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      increased_price_to_put_in_sheets,
      result[:coordinates_of_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end

  def send_notification_to_bot(message)
    SendNotificationMessageToBot.call(message, show_reply_markup_main_buttons: true)
  end

  def transaction_money_from_joint_to_personal?(params)
    params[:data][:account_id] == ENV['MONZO_ACCOUNT_ID'] && params[:data][:description] == ENV['JOINT_MONZO_NAME'] && params[:data][:amount].positive?
  end

  def money_from_personal_to_joint?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && params[:data][:description] == ENV['MY_MONZO_NAME'] && params[:data][:amount].positive?
  end

  def withdraw_from_personal_account(amount)
    result = ReceiveMonzoGbpFromGoogleSheet.call
    decreased_price_to_put_in_sheets = "#{result[:gbp_monzo_formula]} - #{amount.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      decreased_price_to_put_in_sheets,
      result[:coordinates_of_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end

  def add_to_joint_account(amount)
    result = ReceiveJointMonzoGbpFromGoogleSheet.call
    price_to_put_in_sheets = "#{result[:gbp_joint_monzo_formula]} + #{amount.to_s.gsub(".", ",")}"

    UpdateCellInGoogleSheet.call(
      price_to_put_in_sheets,
      result[:coordinates_of_joint_gbp_monzo_formula],
      page: 'Статистика накоплений'
    )
  end

  def transaction_money_from_personal_to_joint?(params)
    params[:data][:account_id] == ENV['MONZO_ACCOUNT_ID'] && params[:data][:description] == ENV['JOINT_MONZO_NAME'] && params[:data][:amount].negative?
  end

  def salary?(params)
    params[:data][:account_id] == ENV['MONZO_ACCOUNT_ID'] && salary_description?(params[:data][:description].downcase) && params[:data][:amount].positive?
  end

  def salary_description?(description)
    description.include?('hawk') && description.include?('applic') && description.include?('corp')
  end

  def youtube?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && description_youtube_premium?(params[:data][:description].downcase) && params[:data][:amount].negative?
  end

  def description_youtube_premium?(description)
    description.include?('youtube') && description.include?('premium')
  end

  def google_storage?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && description_google_storage?(params[:data][:description].downcase) && params[:data][:amount].negative?
  end

  def description_google_storage?(description)
    description.include?('google') && description.include?('storage')
  end

  def digital_ocean?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && description_digital_ocean?(params[:data][:description].downcase) && params[:data][:amount].negative?
  end

  def description_digital_ocean?(description)
    description.include?('digital') && description.include?('ocean')
  end

  def lebara_1?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] &&
      description_lebara?(params[:data][:description].downcase) &&
      params[:data][:amount].negative? &&
      !one_of_two_lebara_transcations_already_saved?
  end

  def one_of_two_lebara_transcations_already_saved?
    lebara_params = []

    @redis.scan_each(match: 'monzo_transaction_id_*') do |key|
      params = JSON.parse(@redis.get(key)).deep_symbolize_keys
      lebara_params << params if params.dig(:data, :description).downcase.include?('lebara')
    end

    lebara_params.any? { |params| params[:already_sent_to_bot] }
  end

  def lebara_2?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && description_lebara?(params[:data][:description].downcase) && params[:data][:amount].negative?
  end

  def description_lebara?(description)
    description.include?('lebara')
  end

  def rebel_energy?(params)
    params[:data][:account_id] == ENV['JOINT_MONZO_ACCOUNT_ID'] && description_rebel_energy?(params[:data][:description].downcase) && params[:data][:amount].negative?
  end

  def description_rebel_energy?(description)
    description.include?('rebel') && description.include?('energy')
  end

  def save_to_google_sheet(category_name, sub_category_name, amount)
    price_to_put_in_sheets = "=#{amount.to_s.gsub(".", ",")} * #{CurrencyRate.call('GBP', 'USD').to_s.gsub(".", ",")}"
    PutExpensesToGoogleSheet.call(category_name, sub_category_name, price_to_put_in_sheets)
  end

  def send_ask_message_to_bot(params)
    SendMessageToBotToAskToEnterExpencesFromMonzo.call(params)
  end

  def update_redis(key, params)
    params[:already_sent_to_bot] = true
    @redis.set(key, params.to_json, ex: 24.hours)
  end
end
