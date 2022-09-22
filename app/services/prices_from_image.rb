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
    text_lines.each do |line|
      if (sainsbury_end?(line) || polish_shop_end?(line)) && line.match(/\d*\.\d*$/)
        break @total_sum_in_receipt = line.match(/\d*\.\d*$/)[0].to_f
      end

      if negative_number_in_waitrose?(line)
        next
      end

      matched_number_with_two_digits_after_point = line.match(/\d*\.\d*$/)
      matched_number_with_two_digits_after_point = line.match(/\d*\.\d*/) if matched_number_with_two_digits_after_point.nil?
      if matched_number_with_two_digits_after_point
        @collected_prices << matched_number_with_two_digits_after_point[0].to_f.round(2)

        # category_name, sub_category_name = shop_parse_class.call(line)

        # @categories_with_prices << {
        #   category_name: category_name,
        #   sub_category_name: sub_category_name,
        #   price: matched_number_with_two_digits_after_point[0].to_f.round(2)
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

  def text_lines
    @text_lines ||= ConvertImageToArrayOfText.call(get_telegram_image)
  end

  def return_result
    # [@categories_with_prices.reject { |hsh| hsh[:price].zero? }, @total_sum_in_receipt.round(2), @file_id]
    [@collected_prices.reject(&:zero?), @total_sum_in_receipt.round(2), @file_id]
  end

  def sainsbury_end?(line)
    line.include?('BALANCE')
  end

  def polish_shop_end?(line)
    line.include?('total') || line.include?('Total')
  end

  # because I have to manually withdraw price from some product in receipt
  # maybe can be automatted, it would be great!
  def negative_number_in_waitrose?(line)
    line.match(/-\d*\.\d*$/) && text_lines.any? { |line| line.include?('waitrose') }
  end

  def shop_parse_class
    if text_lines.any? { |line| line.include?('waitrose') }
      DetectCategoryAndSubcategoryFromLine::Waitrose
    elsif text_lines.any? { |line| line.include?('sainsbury') }
      DetectCategoryAndSubcategoryFromLine::Sainsburys
    else
      DetectCategoryAndSubcategoryFromLine::Default
    end
  end
end
