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
    category_to_price.each do |line|
      if end_line_for_shop?(line[:category_name]) && line[:price].match(/\d*\.\d*$/)
        break @total_sum_in_receipt = line[:price].match(/\d{1,3}\.\d{1,2}$/)[0].to_f
      end

      if negative_number_in_waitrose?(line[:price])
        next
      end

      matched_number_with_two_digits_after_point = line[:price].match(/\d{1,2}\.\d{2}$/)
      matched_number_with_two_digits_after_point = line[:price].match(/\d{1,2}\.\d{2}/) if matched_number_with_two_digits_after_point.nil?
      matched_number_with_two_digits_after_point = line[:category_name].match(/\d{1,2}\.\d{2}/) if matched_number_with_two_digits_after_point.nil?
      if matched_number_with_two_digits_after_point
        @collected_prices << matched_number_with_two_digits_after_point[0].to_f.round(2)

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

    sainsbury_end?(line) || total_end?(line) || marks_and_spencer_end_or_comberton_shop?(line)
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

  # because I have to manually withdraw price from some product in receipt
  # maybe can be automatted, it would be great!
  def negative_number_in_waitrose?(line)
    line.match(/-\d*\.\d*$/) && all_text.downcase.include?('waitrose')
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
end
