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
    if money_from_joint_to_personal?(params)
      withdraw_from_joint_account((params[:data][:amount].abs / 100.0).round(2))
      add_to_personal_account((params[:data][:amount].abs / 100.0).round(2))
      return
    end

    if transaction_money_from_joint_to_personal?(params)
      return
    end

    if money_from_personal_to_joint?(params)
      withdraw_from_personal_account((params[:data][:amount].abs / 100.0).round(2))
      add_to_joint_account((params[:data][:amount].abs / 100.0).round(2))
      return
    end

    if transaction_money_from_personal_to_joint?(params)
      return
    end

    if salary?(params)
      add_to_personal_account((params[:data][:amount].abs / 100.0).round(2))
      return
    end

    send_message_to_bot(params)
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

  def send_message_to_bot(params)
    SendMessageToBotToAskToEnterExpencesFromMonzo.call(params)
  end

  def update_redis(key, params)
    params[:already_sent_to_bot] = true
    @redis.set(key, params.to_json, ex: 24.hours)
  end
end
