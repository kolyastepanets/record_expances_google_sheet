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
    array_of_texts = prepare_texts_for_waitrose if is_waitrose?
    array_of_texts = prepare_texts_for_pepito if is_pepito_supermarket?
    array_of_texts = prepare_texts_for_frestive if is_frestive_supermarket?
    array_of_texts = prepare_texts_for_bali_direct_store if is_bali_direct_store?

    # binding.pry
    # array_of_texts.each do |line|
    #   if end_line_for_shop?(line) && match_total_price(line)
    #     break @total_sum_in_receipt = match_total_price(line)
    #   end

    #   matched_price = match_common_price(line)
    #   next if matched_price.nil?

    #   category_name, sub_category_name = shop_parse_class.call(line)

    #   @categories_with_prices << {
    #     category_name: category_name,
    #     sub_category_name: sub_category_name,
    #     price: matched_price,
    #     full_parsed_line: line.join(", "),
    #   }
    # end

    array_of_texts.each do |line|
      if end_line_for_shop?(line[:array_or_words])
        break @total_sum_in_receipt = line[:price]
      end

      category_name, sub_category_name = shop_parse_class.call(line[:array_or_words])

      @categories_with_prices << {
        category_name: category_name,
        sub_category_name: sub_category_name,
        price: line[:price],
        full_parsed_line: line[:array_or_words],
      }
    end
  end

  def get_telegram_image
    file_id = @message_params[:photo][-1][:file_id] if @message_params.key?(:photo)
    file_id = @message_params[:document][:file_id] if @message_params.key?(:document)

    response = Telegram.bot.get_file(file_id: file_id)
    @unique_file_id = response["result"]["file_unique_id"]

    url = "https://api.telegram.org/file/bot#{Telegram.bots_config[:default]}/#{response["result"]["file_path"]}"
    Faraday.new(url: url).get.body
  end

  def parsed_texts
    @parsed_texts ||= ConvertImageToArrayOfText.call(get_telegram_image)
  end

  def return_result
    [@categories_with_prices.reject { |hsh| hsh[:price].zero? }, @total_sum_in_receipt.round(2), @unique_file_id]
  end

  def end_line_for_shop?(array_of_words)
    return false if array_of_words.nil?

    sainsbury_end?(array_of_words) ||
      pepito_end?(array_of_words) ||
      marks_and_spencer_end_or_comberton_shop?(array_of_words) ||
      total_end?(array_of_words)
  end

  def sainsbury_end?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'balance' }
  end

  def pepito_end?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'net' } && array_of_words.any? { |word| word.downcase == 'value' }
  end

  def marks_and_spencer_end_or_comberton_shop?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'items' }
  end

  def total_end?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'total' }
  end

  def bali_direct_store_subtotal?(line)
    is_bali_direct_store? && line.any? { |word| word.downcase == 'subtotal' }
  end

  def negative_number?(line)
    all_text.downcase.include?('waitrose') && line.match(/-\d*\.\d*$/) ||
      is_frestive_supermarket? && line.match(/-\d*\,\d*$/)
  end

  def is_pepito_supermarket?
    all_text.downcase.include?('peptomarket') || all_text.downcase.include?('pepito') || express_berawa?
  end

  def express_berawa?
    all_text.downcase.include?('berawa') && all_text.downcase.include?('express')
  end

  def is_frestive_supermarket?
    all_text.downcase.include?('frestive')
  end

  def is_bali_direct_store?
    all_text.downcase.include?('bali') && all_text.downcase.include?('direct') && all_text.downcase.include?('store')
  end

  def is_waitrose?
    all_text.downcase.include?('waitrose')
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
    elsif is_pepito_supermarket?
      DetectCategoryAndSubcategoryFromLine::PepitoShop
    elsif is_bali_direct_store?
      DetectCategoryAndSubcategoryFromLine::BaliDirectStoreShop
    else
      DetectCategoryAndSubcategoryFromLine::Default
    end
  end

  def match_total_price(line)
    string_price = line[-1]

    if is_pepito_supermarket? || is_bali_direct_store?
      matched_price = string_price.match(/\d*\,\d*\,\d*$/) || string_price.match(/\d*\.\d*\,\d*$/) || string_price.match(/\d*\,\d*$/) || string_price.match(/\d*.\d*\.\d*$/) || string_price.match(/\d*\.\d*$/)
      matched_price = matched_price[0].delete(",").delete(".").to_f if matched_price.present?
      return matched_price
    end

    if is_frestive_supermarket?
      index_of_total_word = line.map(&:downcase).find_index('total')
      string_price = line.select.with_index { |word, index| index > index_of_total_word }.join

      matched_price = (string_price.match(/\d*\,\d*\,\d*$/) || string_price.match(/\d*\,\d*$/) || string_price.match(/\d*.\d*\.\d*$/) || string_price.match(/\d*\.\d*$/)) || string_price.match(/\d*$/)
      matched_price = matched_price[0].delete(",").delete(".").to_f if matched_price.present?
      return matched_price
    end

    matched_price = string_price.match(/\d*\.\d*$/)
    matched_price = matched_price[0].to_f if matched_price.present?
    matched_price
  end

  def match_common_price(line)
    if is_pepito_supermarket?
      if line[-1].include?(' - ') # calculate discount
        price, discount = line[-1].split(' - ')
        matched_price = price.match(/\d*\,\d*$/) || price.match(/\d*\.\d*$/)
        matched_price = matched_price[0].delete(",").delete(".").to_f if !matched_price.nil?

        matched_discount = discount.match(/\d*\,\d*$/) || discount.match(/\d*\.\d*$/) || discount.match(/\d*$/)
        matched_discount = matched_discount[0].delete(",").delete(".").to_f if !matched_discount.nil?

        return matched_price - matched_discount
      end

      matched_price = line[-1].match(/\d*\,\d*$/) || line[-1].match(/\d*\.\d*$/)
      matched_price = nil if strange_punctuation_in_price?(line[-1])
      matched_price = matched_price[0].delete(",").delete(".").to_f if !matched_price.nil?
      matched_price = nil if small_price_for_receipt?(matched_price)
      return matched_price
    end

    if is_frestive_supermarket? || is_bali_direct_store?
      matched_price = line[-1].match(/\d*\,\d*$/) || line[-1].match(/\d*\.\d*$/)
      matched_price = nil if strange_punctuation_in_price?(line[-1])
      matched_price = matched_price[0].delete(",").delete(".").to_f if !matched_price.nil?
      matched_price = nil if small_price_for_receipt?(matched_price)

      if matched_price.nil?
        matched_price = line.last(3).join
        matched_price = matched_price.match(/\d*\,\d*$/) || matched_price.match(/\d*\.\d*$/)
        matched_price = matched_price[0].delete(",").delete(".").to_f if !matched_price.nil?
      end

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

  # def prepare_texts_for_pepito
  #   new_parsed_texts = []
  #   filtered_texts = parsed_texts.deep_dup.reject { |array_of_text| array_of_text.size <= 1 }

  #   filtered_texts.each.with_index do |array_of_text, index|
  #     if array_of_text.map(&:downcase).include?('discount')
  #       next
  #     end

  #     if line_is_discount?(array_of_text, index)
  #       next
  #     end

  #     if is_all_numbers?(array_of_text) && line_is_discount?(filtered_texts[index + 1], index)
  #       discount_value = (filtered_texts[index + 1] - ['P'])[-2]
  #       value_to_add = ["#{array_of_text[-1]} - #{discount_value}"]
  #       add_last_price_to_array_of_texts!(new_parsed_texts, value_to_add)
  #       add_next_text_as_new_array!(new_parsed_texts, filtered_texts, index + 1)
  #       next
  #     end

  #     if is_all_numbers?(array_of_text)
  #       add_last_price_to_array_of_texts!(new_parsed_texts, [array_of_text[-1]])
  #       add_next_text_as_new_array!(new_parsed_texts, filtered_texts, index)
  #       next
  #     end

  #     if is_all_numbers?(array_of_text - [".", ","])
  #       add_last_price_to_array_of_texts!(new_parsed_texts, [array_of_text.last(3).join])
  #       add_next_text_as_new_array!(new_parsed_texts, filtered_texts, index)
  #       next
  #     end

  #     next if already_added?(array_of_text, new_parsed_texts)
  #     next new_parsed_texts << array_of_text if new_parsed_texts.empty?

  #     add_text_to_already_existing_array_of_text!(new_parsed_texts, array_of_text)

  #     if array_of_text.map(&:downcase).include?('net') && array_of_text.map(&:downcase).include?('value')
  #       if !array_of_text.any? { |word| word.count("0-9") > 0 }
  #         add_text_to_already_existing_array_of_text!(new_parsed_texts, filtered_texts[index + 1])
  #       end

  #       break
  #     end
  #   end

  #   new_parsed_texts
  # end

  def prepare_texts_for_pepito
    grouped_texts = group_arrays_by_product_code
    grouped_texts << total_price_array_of_text
    build_array_of_texts_with_prices(grouped_texts)
  end

  def group_arrays_by_product_code
    grouped_texts = []

    parsed_texts.deep_dup.each.with_index do |array_of_text, index|
      next if array_of_text.any? { |str| str.include?('Items')} && !array_of_text.any? { |str| str.include?('Total')}
      break if array_of_text.any? { |str| str.include?('total') || str.include?('Total') }

      if array_of_text.any? { |str| str.length >= 10 && (str.start_with?('10') || str.start_with?('P10')) } # product code => means new line
        grouped_texts << array_of_text
      else
        grouped_texts[-1]&.concat(array_of_text)
      end
    end

    grouped_texts
  end

  def build_array_of_texts_with_prices(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each.with_index do |array_of_text, index|
      price = buid_normal_price(array_of_text)
      price = build_price_with_discount(array_of_text) if array_of_text.any? { |str| str.include?('Disc') }

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if net_value?(array_of_text)
    end

    array_of_texts_with_prices
  end

  def build_price_with_discount(array_of_text)
    discount = 0

    array_of_text.reverse.each do |str|
      discount = string_to_number(str)
      next if discount.zero?

      break discount
    end

    price = 0
    array_of_text.take_while { |str| !str.include?('Disc') }.reverse.each do |str|
      price = string_to_number(str)
      next if price.zero?

      break price
    end

    price - discount
  end

  def buid_normal_price(array_of_text)
    price = 0

    reversed_array_of_text = array_of_text.reverse
    reversed_array_of_text.each do |str|
      next if str.size == 4 # "1.00"

      price = string_to_number(str)

      next if price.zero?

      if str.size == 3 # ["...", "...", "30", ",", "100"]
        price = string_to_number(reversed_array_of_text[2] + reversed_array_of_text[1] + reversed_array_of_text[0])
      end

      break price
    end

    price
  end

  def net_value?(array_of_text)
    array_of_text.join(', ').downcase.include?('net') && array_of_text.join(', ').downcase.include?('value')
  end

  def string_to_number(str)
    str.delete(",").delete(".").to_f
  end

  def total_price_array_of_text
    array_of_text_total_price = nil
    next_array = nil

    parsed_texts.each_with_index do |array_of_text, index|
      if net_value?(array_of_text)
        array_of_text_total_price = array_of_text
        next_array = parsed_texts[index + 1]
        break
      end
    end

    if string_to_number(array_of_text_total_price[-1]).zero?
      array_of_text_total_price.concat(next_array)
    end

    array_of_text_total_price
  end

  def prepare_texts_for_frestive
    new_parsed_texts = []

    filtered_texts = parsed_texts
      .reject { |array_of_text| array_of_text.size <= 3 && array_of_text.any? { |word| word.match(/[[:punct:]&&[^,]]/) } && array_of_text.size != 1 } # remove  ['1', '@', '115,000'] - it means quantity and full price
      .reject { |array_of_text| (array_of_text.size == 5 || array_of_text.size == 6) && array_of_text.include?('@') } # remove  ["1.016", "@", "39", ",", "000"] - it means quantity and full price
      .reject { |array_of_text| array_of_text.size == 2 } # remove  ['1', '115,000'] - it means quantity and full price
      .reject { |array_of_text| array_of_text[-1].match(/-\d*\,\d*$/) } # negative number (discount)
      .reject { |array_of_text| array_of_text.include?('disc') && array_of_text.include?('toko') }
      .reject { |array_of_text| array_of_text.size == 4 && array_of_text[0].size != 8 && !array_of_text.map(&:downcase).include?('total') }

    filtered_texts.each.with_index do |array_of_text, index|
      if is_all_numbers?(array_of_text) && array_of_text.size == 1 && last_element_is_not_number?(new_parsed_texts)
        add_last_price_to_array_of_texts!(new_parsed_texts, array_of_text)
        next
      end
      if is_all_numbers?(array_of_text) && array_of_text.size == 1
        next
      end

      new_parsed_texts << array_of_text
    end

    new_parsed_texts
  end

  def last_element_is_not_number?(new_parsed_texts)
    new_parsed_texts[-1][-1].to_f == 0.00
  end

  def prepare_texts_for_bali_direct_store
    parsed_texts.reject { |array_of_text| array_of_text.any? { |word| word.downcase == 'subtotal' } }
  end

  # because I have to manually withdraw price from some product in receipt
  # maybe can be automatted, it would be great!
  def prepare_texts_for_waitrose
    parsed_texts.reject { |array_of_text| array_of_text[-1].match(/-\d*\.\d*$/) } # negative number (discount)
  end

  def is_all_numbers?(array_of_text)
    array_of_text.all? { |text| text.include?('.') || text.include?(',') } || array_of_text.all? { |text| text.to_f > 0 }
  end

  def line_is_discount?(current_array, index)
    current_array.include?('Disc') && current_array.include?('.') && current_array.include?('(')
  end

  def add_last_price_to_array_of_texts!(new_parsed_texts, number)
    new_parsed_texts[-1].concat(number)
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
