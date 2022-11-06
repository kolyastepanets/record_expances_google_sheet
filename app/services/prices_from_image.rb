class PricesFromImage
  include CallableService

  def initialize(message_params)
    @message_params = message_params
    @collected_prices = []
    @total_sum_in_receipt = 0
    @categories_with_prices = []
  end

  def call
    parse_image
    return_result
  end

  private

  def parse_image
    # binding.pry
    category_to_price.each do |line|
      if end_line_for_shop?(line[:category_name]) && match_total_price(line[:price])
        break @total_sum_in_receipt = match_total_price(line[:price])
      end

      if negative_number_in_waitrose?(line[:price])
        next
      end

      matched_price = match_common_price(line)
      if matched_price
        @collected_prices << matched_price

        # category_name, sub_category_name = shop_parse_class.call(line)

        # @categories_with_prices << {
        #   category_name: category_name,
        #   sub_category_name: sub_category_name,
        #   price: matched_number_with_two_digits_after_point[0].to_f.round(2),
        #   line_to_parse: line
        # }
      end
    end
  end

  def get_telegram_image
    last_photo = @message_params[:photo][-1][:file_id]

    response = Telegram.bot.get_file(file_id: last_photo)
    @file_id = response["result"]["file_unique_id"]

    url = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}/#{response["result"]["file_path"]}"
    Faraday.new(url: url).get.body
  end

  def category_to_price
    @category_to_price ||= ConvertImageToArrayOfText.call(get_telegram_image)
  end

  def return_result
    # [@categories_with_prices.reject { |hsh| hsh[:price].zero? }, @total_sum_in_receipt.round(2), @file_id]
    [@collected_prices.reject(&:zero?), @total_sum_in_receipt.round(2), @file_id]
  end

  def end_line_for_shop?(line)
    return false if line.nil?

    sainsbury_end?(line) || total_end?(line) || marks_and_spencer_end_or_comberton_shop?(line) || pepito_end?(line)
  end

  def sainsbury_end?(line)
    line.include?('BALANCE')
  end

  def total_end?(line)
    line.downcase.include?('total')
  end

  def marks_and_spencer_end_or_comberton_shop?(line)
    line.downcase.include?('items')
  end

  def pepito_end?(line)
    line.downcase.include?('totalreceived')
  end

  # because I have to manually withdraw price from some product in receipt
  # maybe can be automatted, it would be great!
  def negative_number_in_waitrose?(line)
    all_text.downcase.include?('waitrose') && line.match(/-\d*\.\d*$/)
  end

  def is_pepito_supermarket?
    all_text.downcase.include?('peptomarket') || all_text.downcase.include?('pepitomarket')
  end

  def all_text
    category_to_price.map { |ha| ha[:category_name] + ha[:price].to_s }.join
  end

  def shop_parse_class
    if text_lines.any? { |line| line.include?('waitrose') }
      DetectCategoryAndSubcategoryFromLine::Waitrose
    elsif text_lines.any? { |line| line.include?('sainsbury') }
      DetectCategoryAndSubcategoryFromLine::Sainsburys
    elsif text_lines.any? { |line| line.include?('COMBERTON') && line.include?('COSTCUTTER') }
      DetectCategoryAndSubcategoryFromLine::CombertonShop
    elsif text_lines.any? { |line| line.downcase.include?('polish') && line.downcase.include?('marke') }
      DetectCategoryAndSubcategoryFromLine::PolishShop
    elsif text_lines.any? { |line| line.downcase.include?('marksandspencer') }
      DetectCategoryAndSubcategoryFromLine::MarksAndSpencerShop
    else
      DetectCategoryAndSubcategoryFromLine::Default
    end
  end

  def match_total_price(string_price)
    if is_pepito_supermarket?
      matched_price = (string_price.match(/\d*\,\d*$/) || string_price.match(/\d*.\d*\.\d*$/) || string_price.match(/\d*\.\d*$/))
      matched_price = matched_price[0].delete(",").delete(".").to_f if matched_price.present?
      return matched_price
    end

    matched_price = string_price.match(/\d*\.\d*$/)
    matched_price = matched_price[0].to_f if matched_price.present?
    matched_price
  end

  def match_common_price(line)
    if is_pepito_supermarket?
      matched_price = line[:price].match(/\d*\,\d*$/) || line[:price].match(/\d*\.\d*$/)
      matched_price = nil if strange_punctuation_in_price?(line[:price])
      matched_price = matched_price[0].delete(",").delete(".").to_f if !matched_price.nil?
      matched_price = nil if small_price_for_receipt?(matched_price)
      return matched_price
    end

    matched_price = line[:price].match(/\d{1,2}\.\d{2}$/) || line[:price].match(/\d{1,2}\.\d{2}/) || line[:category_name].match(/\d{1,2}\.\d{2}/)
    matched_price = matched_price[0].to_f if !matched_price.nil?
    matched_price
  end

  def strange_punctuation_in_price?(string_price)
    string_price.count('.') > 1 || string_price.include?('-')
  end

  def small_price_for_receipt?(matched_price)
    return false if matched_price.nil?

    matched_price <= 100
  end
end
