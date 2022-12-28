class PrepareParamsAfterEnterSubcategoryBeforeSave
  include CallableService

  def initialize(telegram_message)
    @transaction_id, price = telegram_message.split(': ')[1].split('f1_id:')[1].split(":")
    @price = price.to_f
    @sub_category_name = find_full_sub_category_name(telegram_message.split(': ')[0])
    @redis = Redis.new
  end

  def call
    params = JSON.parse(@redis.get(@transaction_id))
    @last_price_to_message = params.select { |pri| pri["price"] == @price }[-1]

    new_params_for_redis = params - [@last_price_to_message]
    @redis.set(@transaction_id, new_params_for_redis.to_json, ex: 2.days)

    [params_to_save_to_google_sheet, new_params_for_redis, messages_to_delete]
  end

  private

  def price_in_uah
    price_in_uah = {}
    if @last_price_to_message["currency_to_uah"].present?
      price_in_uah = {
        price_in_uah: (@price * @last_price_to_message["currency_to_uah"]),
        price_in_uah_converted_to_usd_to_save_in_google_sheet: "=#{@price.to_s.gsub(".", ",")} * #{@last_price_to_message["currency_to_uah"].to_s.gsub(".", ",")} / #{MonobankCurrencyRates.call('USD', 'UAH').to_s.gsub(".", ",")}"
      }
    end
    price_in_uah
  end

  def price_in_usd
    price_in_usd = {}
    if @last_price_to_message["currency_to_usd"].present?
      price_in_usd = {
        price_in_usd: (@price / @last_price_to_message["currency_to_usd"]),
        price_in_usd_to_save_in_google_sheet: "=#{@price.to_s.gsub(".", ",")} / #{@last_price_to_message["currency_to_usd"].to_s.gsub(".", ",")}"
      }
    end
    price_in_usd
  end

  def params_to_save_to_google_sheet
    {
      category_name: @last_price_to_message["category_name"],
      sub_category_name: @sub_category_name,
      operation_amount: @price,
      who_paid: @last_price_to_message["who_paid"],
      **price_in_usd,
      **price_in_uah,
    }
  end

  def find_full_sub_category_name(sub_category_name)
    return sub_category_name if !sub_category_name.end_with?("_")

    short_sub_category_name = sub_category_name.delete("_")
    full_sub_category_name = ""

    sub_categories.each do |sub_category|
      if sub_category.include?(short_sub_category_name)
        full_sub_category_name = sub_category
        break
      end
    end
    full_sub_category_name
  end

  def sub_categories
    ReceiveCategories.call.values.flatten
  end

  def messages_to_delete
    @last_price_to_message["message_ids"]
  end
end
