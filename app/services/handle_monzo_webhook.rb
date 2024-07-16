class HandleMonzoWebhook
  include CallableService

  def initialize(params)
    @params = JSON.parse(params.to_json).deep_symbolize_keys
    @redis = Redis.new
  end

  def call
    save_to_redis
    send_webhook_to_google_sheet
  end

  private

  def save_to_redis
    @redis.set("monzo_transaction_id_#{@params[:data][:id]}", @params.to_json, ex: 48.hours) if !@redis.exists?("monzo_transaction_id_#{@params[:data][:id]}")
  end

  def send_webhook_to_google_sheet
    TestJob.perform_later(@params)
  end
end
