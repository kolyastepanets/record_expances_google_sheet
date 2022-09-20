class PricesFromImage
  include CallableService

  def initialize(message_params)
    @message_params = message_params
    @collected_prices = []
    @total_sum_in_receipt = 0
  end

  def call
    parse_image
    return_result
  end

  private

  def parse_image
    image_to_s.split(/\n/).each.with_index do |line_with_spaces, index|
      line = line_with_spaces.gsub(/[[:space:]]/, '')

      if (line.include?('total') || line.include?('Total') || line.include?('Cash') || line.include?('Items:')) && line.match(/\d*\.\d*$/)
        break @total_sum_in_receipt = line.match(/\d*\.\d*$/)[0].to_f
      end

      matched_number_with_two_digits_after_point = line.match(/\d*\.\d*$/)
      if matched_number_with_two_digits_after_point
        @collected_prices << matched_number_with_two_digits_after_point[0].to_f
      end

      matched_number_with_two_digits_after_comma = line.match(/\d*\,\d*$/)
      if matched_number_with_two_digits_after_comma
        @collected_prices << matched_number_with_two_digits_after_comma[0].gsub(",", ".").to_f
      end
    end
  end

  def image_to_s
    last_photo = @message_params[:photo][-1][:file_id]

    response = Telegram.bot.get_file(file_id: last_photo)
    @file_id = response["result"]["file_unique_id"]

    url = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}/#{response["result"]["file_path"]}"
    res = Faraday.new(url: url).get
    File.open("public/out.jpg", "wb") do |f|
      f.write(res.body)
    end
    RTesseract.new("public/out.jpg").to_s
  end

  def return_result
    [@collected_prices.reject(&:zero?), @total_sum_in_receipt.round(2), @file_id]
  end
end
