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
    array_of_texts = parsed_texts
    array_of_texts = prepare_texts_for_pepito if is_pepito_supermarket?
    array_of_texts = prepare_texts_for_frestive if is_frestive_supermarket?

    array_of_texts.each do |line|
      if end_line_for_shop?(line.join) && match_total_price(line[-1])
        break @total_sum_in_receipt = match_total_price(line[-1])
      end

      if negative_number?(line[-1])
        next
      end

      matched_price = match_common_price(line)
      if matched_price
        if ENV['PARSE_PRICE_WITH_CATEGORIES']
          category_name, sub_category_name = shop_parse_class.call(line)

          @categories_with_prices << {
            category_name: category_name,
            sub_category_name: sub_category_name,
            price: matched_price,
          }
        else
          @collected_prices << matched_price
        end
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

  def parsed_texts
    @parsed_texts ||= ConvertImageToArrayOfText.call(get_telegram_image)
  end

  def return_result
    if ENV['PARSE_PRICE_WITH_CATEGORIES']
      [@categories_with_prices.reject { |hsh| hsh[:price].zero? }, @total_sum_in_receipt.round(2), @file_id]
    else
      [@collected_prices.reject(&:zero?), @total_sum_in_receipt.round(2), @file_id]
    end
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
  def negative_number?(line)
    all_text.downcase.include?('waitrose') && line.match(/-\d*\.\d*$/) ||
      is_frestive_supermarket? && line.match(/-\d*\,\d*$/)
  end

  def is_pepito_supermarket?
    all_text.downcase.include?('peptomarket') || all_text.downcase.include?('pepitomarket')
  end

  def is_frestive_supermarket?
    all_text.downcase.include?('frestive')
  end

  def all_text
    @all_text ||= parsed_texts.flat_map(&:join).join
  end

  def shop_parse_class
    if all_text.include?('waitrose')
      DetectCategoryAndSubcategoryFromLine::Waitrose
    elsif all_text.include?('sainsbury')
      DetectCategoryAndSubcategoryFromLine::Sainsburys
    elsif all_text.downcase.include?('comberton') && all_text.downcase.include?('costcutter')
      DetectCategoryAndSubcategoryFromLine::CombertonShop
    elsif all_text.downcase.include?('polish') && all_text.downcase.include?('marke')
      DetectCategoryAndSubcategoryFromLine::PolishShop
    elsif all_text.downcase.include?('marksandspencer')
      DetectCategoryAndSubcategoryFromLine::MarksAndSpencerShop
    elsif is_frestive_supermarket?
      DetectCategoryAndSubcategoryFromLine::FrestiveShop
    else
      DetectCategoryAndSubcategoryFromLine::Default
    end
  end

  def match_total_price(string_price)
    if is_pepito_supermarket? || is_frestive_supermarket?
      matched_price = (string_price.match(/\d*\,\d*\,\d*$/) || string_price.match(/\d*\,\d*$/) || string_price.match(/\d*.\d*\.\d*$/) || string_price.match(/\d*\.\d*$/))
      matched_price = matched_price[0].delete(",").delete(".").to_f if matched_price.present?
      return matched_price
    end

    matched_price = string_price.match(/\d*\.\d*$/)
    matched_price = matched_price[0].to_f if matched_price.present?
    matched_price
  end

  def match_common_price(line)
    if is_pepito_supermarket? || is_frestive_supermarket?
      matched_price = line[-1].match(/\d*\,\d*$/) || line[-1].match(/\d*\.\d*$/)
      matched_price = nil if strange_punctuation_in_price?(line[-1])
      matched_price = matched_price[0].delete(",").delete(".").to_f if !matched_price.nil?
      matched_price = nil if small_price_for_receipt?(matched_price)
      return matched_price
    end

    matched_price = line[-1].match(/\d{1,2}\.\d{2}$/) || line[-1].match(/\d{1,2}\.\d{2}/) || line.join.match(/\d{1,2}\.\d{2}/)
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

  def prepare_texts_for_pepito
    new_parsed_texts = []
    filtered_texts = parsed_texts.deep_dup.reject { |array_of_text| array_of_text.size <= 2 }

    filtered_texts.each.with_index do |array_of_text, index|
      if array_of_text.any? { |word| word.downcase == 'total' }
        break
      end

      if is_all_numbers?(array_of_text)
        add_last_price_to_array_of_texts!(new_parsed_texts, array_of_text)
        add_next_text_as_new_array!(new_parsed_texts, filtered_texts, index)
        next
      end

      next if already_added?(array_of_text, new_parsed_texts)
      next new_parsed_texts << array_of_text if new_parsed_texts.empty?

      add_text_to_already_existing_array_of_text!(new_parsed_texts, array_of_text)
    end

    new_parsed_texts
  end

  def prepare_texts_for_frestive
    # remove  ['1', '@', '115,000'] - it means quantity and full price
    parsed_texts.reject { |array_of_text| array_of_text.size <= 3 }
  end

  def is_all_numbers?(array_of_text)
    array_of_text.all? { |text| text.include?('.') || text.include?(',') } || array_of_text.all? { |text| text.to_f > 0 }
  end

  def add_last_price_to_array_of_texts!(new_parsed_texts, array_of_text)
    new_parsed_texts[-1].concat([array_of_text[-1]])
  end

  def add_next_text_as_new_array!(new_parsed_texts, filtered_texts, index)
    new_parsed_texts << filtered_texts[index + 1]
  end

  def add_text_to_already_existing_array_of_text!(new_parsed_texts, array_of_text)
    new_parsed_texts[-1].concat(array_of_text)
  end

  def already_added?(array_of_text, new_parsed_texts)
    (array_of_text - (new_parsed_texts[-1] || [])).blank?
  end
end
