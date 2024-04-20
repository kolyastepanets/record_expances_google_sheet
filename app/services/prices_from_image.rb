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
    array_of_texts = prepare_texts_for_polish_shop if is_polish_shop?
    array_of_texts = prepare_texts_for_comberton_shop if is_comberton_shop?
    array_of_texts = prepare_texts_for_marks_and_spencer if is_marks_and_spencer?
    array_of_texts = prepare_texts_for_tesco if is_tesco?
    array_of_texts = prepare_texts_for_pepito if is_pepito_supermarket?
    array_of_texts = prepare_texts_for_frestive if is_frestive_supermarket?
    array_of_texts = prepare_texts_for_sok_turkey if sok_turkey?

    array_of_texts.each do |line|
      if end_line_for_shop?(line[:array_or_words])
        break @total_sum_in_receipt = line[:price]
      end

      category_name, sub_category_name = shop_parse_class.call(line[:array_or_words])

      @categories_with_prices << {
        category_name: category_name,
        sub_category_name: sub_category_name,
        price: line[:price],
        full_parsed_line: line[:array_or_words].join(', '),
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
    [@categories_with_prices, @total_sum_in_receipt.round(2), @unique_file_id]
  end

  def end_line_for_shop?(array_of_words)
    sainsbury_end?(array_of_words) ||
      pepito_end?(array_of_words) ||
      polish_or_comberton_shop_end?(array_of_words) ||
      sok_turkey_total_price_end?(array_of_words) ||
      total_end?(array_of_words)
  end

  def sainsbury_end?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'balance' }
  end

  def pepito_end?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'net' } && array_of_words.any? { |word| word.downcase == 'value' }
  end

  def total_end?(array_of_words)
    array_of_words.any? { |word| word.downcase == 'total' }
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

  def is_waitrose?
    all_text.downcase.include?('waitrose')
  end

  def is_polish_shop?
    all_text.downcase.include?('polish') && all_text.downcase.include?('marke')
  end

  def is_comberton_shop?
    all_text.downcase.include?('comberton') || all_text.downcase.include?('costcutter')
  end

  def is_marks_and_spencer?
    all_text.downcase.include?('marksandspencer')
  end

  def is_tesco?
    all_text.downcase.include?('tesco')
  end

  def sok_turkey?
    all_text.downcase.include?('marketler')
  end

  def all_text
    @all_text ||= parsed_texts.flat_map(&:join).join
  end

  def shop_parse_class
    if is_waitrose?
      DetectCategoryAndSubcategoryFromLine::Waitrose
    elsif all_text.include?('sainsbury')
      DetectCategoryAndSubcategoryFromLine::Sainsburys
    elsif is_comberton_shop?
      DetectCategoryAndSubcategoryFromLine::CombertonShop
    elsif is_polish_shop?
      DetectCategoryAndSubcategoryFromLine::PolishShop
    elsif is_marks_and_spencer?
      DetectCategoryAndSubcategoryFromLine::MarksAndSpencerShop
    elsif is_frestive_supermarket?
      DetectCategoryAndSubcategoryFromLine::FrestiveShop
    elsif is_pepito_supermarket?
      DetectCategoryAndSubcategoryFromLine::PepitoShop
    elsif sok_turkey?
      DetectCategoryAndSubcategoryFromLine::SokTurkey
    else
      DetectCategoryAndSubcategoryFromLine::Default
    end
  end

  def prepare_texts_for_pepito
    grouped_texts = group_arrays_by_product_code_pepito
    grouped_texts << total_price_array_of_text_pepito
    build_array_of_texts_with_prices_pepito(grouped_texts)
  end

  def group_arrays_by_product_code_pepito
    grouped_texts = []

    parsed_texts.deep_dup.each.with_index do |array_of_text, index|
      break if array_of_text.any? { |str| str.include?('total') || str.include?('Total') }

      next if array_of_text.any? { |str| str.include?('Items')} && !array_of_text.any? { |str| str.include?('Total')}

      if array_of_text.any? { |str| str.length >= 10 && (str.start_with?('10') || str.start_with?('P10')) } # product code => means new line
        grouped_texts << array_of_text
      else
        grouped_texts[-1]&.concat(array_of_text)
      end
    end

    grouped_texts
  end

  def build_array_of_texts_with_prices_pepito(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each.with_index do |array_of_text, index|
      price = buid_indonesian_price(array_of_text)
      price = build_indonesian_price_with_discount(array_of_text) if array_of_text.any? { |str| str.include?('Disc') }

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if net_value?(array_of_text)
    end

    array_of_texts_with_prices
  end

  def build_indonesian_price_with_discount(array_of_text)
    discount = 0

    array_of_text.reverse.each do |str|
      discount = string_to_indonesian_price(str)
      next if discount.zero?

      break discount
    end

    price = 0
    array_of_text.take_while { |str| !str.include?('Disc') }.reverse.each do |str|
      price = string_to_indonesian_price(str)
      next if price.zero?

      break price
    end

    price - discount
  end

  def buid_indonesian_price(array_of_text)
    price = 0

    reversed_array_of_text = array_of_text.reverse
    reversed_array_of_text.each do |str|
      next if str.size == 4 # "1.00"

      # ["...", "...", "30", ",", "100"]
      if str.size == 3
        str = ''
        str = reversed_array_of_text[4] + reversed_array_of_text[3] if reversed_array_of_text[3] == "," # ["TOTAL", "1", ",", "300", ",", "100"]
        str += reversed_array_of_text[2] + reversed_array_of_text[1] + reversed_array_of_text[0]
      end

      price = string_to_indonesian_price(str)

      next if price < 10

      break price
    end

    price
  end

  def net_value?(array_of_text)
    array_of_text.join(', ').downcase.include?('net') && array_of_text.join(', ').downcase.include?('value')
  end

  def string_to_indonesian_price(str)
    str.delete(",").delete(".").to_f
  end

  def total_price_array_of_text_pepito
    array_of_text_total_price = nil
    next_array = nil

    parsed_texts.each_with_index do |array_of_text, index|
      if net_value?(array_of_text)
        array_of_text_total_price = array_of_text
        next_array = parsed_texts[index + 1]
        break
      end
    end

    if string_to_indonesian_price(array_of_text_total_price[-1]).zero?
      array_of_text_total_price.concat(next_array)
    end

    array_of_text_total_price
  end

  # ----------------------------

  def prepare_texts_for_frestive
    grouped_texts = group_arrays_by_product_code_frestive
    grouped_texts << total_price_array_of_text_frestive
    build_array_of_texts_with_prices_frestive(grouped_texts)
  end

  def group_arrays_by_product_code_frestive
    grouped_texts = []

    parsed_texts.deep_dup.each.with_index do |array_of_text, index|
      break if array_of_text.any? { |str| str.downcase.include?('total') }

      next if array_of_text.any? { |str| str.include?('@') || str.include?('€') } # skip ['1', '@', '115,000'] - it means quantity and full price
      next if array_of_text.any? { |str| str.include?('disc') } # skip discount
      next if array_of_text.size == 1 && !array_of_text.any? { |str| str.match(/[[:punct:]]/) } # skip ['randomtext']
      next if array_of_text.size == 4 && string_to_indonesian_price(array_of_text[0]).between?(1, 10) # ["0.9", "167", ",", "000"]
      next if array_of_text.any? { |str| str.count('/') == 2 } # skip date
      next if array_of_text.any? { |str| str.count(':') == 2 || str.count(':') == 1 } # skip time
      next if array_of_text.size == 1 && parsed_texts[index + 1].any? { |str| str.include?('disc') } # special hack for 2 cases
      next if array_of_text.size == 2 && parsed_texts[index + 1].any? { |str| frestive_product_start?(str.gsub(/\D/, '')) } # ["0.274", "33,000"]
      next if array_of_text.any? { |str| str.downcase.include?('items') } && !array_of_text.any? { |str| str.downcase.include?('total') }

      if array_of_text.any? { |str| frestive_product_start?(str.gsub(/\D/, '')) } || array_of_text.size >= 5
        grouped_texts << array_of_text
      else
        grouped_texts[-1]&.concat(array_of_text)
      end
    end

    grouped_texts
  end

  def frestive_product_start?(str)
    str.length >= 8 && (str.start_with?('1') || str.start_with?('2') || str.start_with?('3'))
  end

  def total_price_array_of_text_frestive
    total_price_array_of_text = parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.downcase.include?('total') } }

    if total_price_array_of_text[-1].downcase == "total"
      parsed_texts.each_with_index do |array_of_text, index|
        break total_price_array_of_text.concat(parsed_texts[index + 1]) if array_of_text == total_price_array_of_text
      end
    end

    total_price_array_of_text
  end

  def build_array_of_texts_with_prices_frestive(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each.with_index do |array_of_text, index|
      price = buid_indonesian_price(array_of_text)

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if array_of_text.any? { |str| str.downcase.include?('total') }
    end

    array_of_texts_with_prices
  end

  # ----------------------------

  def prepare_texts_for_waitrose
    grouped_texts = group_texts_for_waitrose
    grouped_texts << total_price_array_of_text_waitrose
    build_array_of_texts_with_prices_waitrose(grouped_texts)
  end

  def group_texts_for_waitrose
    grouped_texts = []

    parsed_texts.deep_dup.each.with_index do |array_of_text, index|
      break if waitrose_or_marks_and_spencer_end?(array_of_text)

      next if array_of_text.any? { |str| str.downcase.include?('items') }
      next if array_of_text[-1].match(/-\d*\.\d*$/) # negative number (discount)

      if array_of_text.size == 1
        grouped_texts[-1]&.concat(array_of_text)
      else
        grouped_texts << array_of_text
      end
    end

    grouped_texts
  end

  def total_price_array_of_text_waitrose
    parsed_texts.detect { |array_of_text| waitrose_or_marks_and_spencer_end?(array_of_text) }
  end

  def build_array_of_texts_with_prices_waitrose(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each do |array_of_text|
      price = buid_uk_price(array_of_text)

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if waitrose_or_marks_and_spencer_end?(array_of_text)
    end

    array_of_texts_with_prices
  end

  def buid_uk_price(array_of_text)
    price = 0

    reversed_array_of_text = array_of_text.reverse
    reversed_array_of_text.each do |str|
      price = string_to_uk_price(str)

      next if price.zero?
      next if price > 300 # unreal price

      break price
    end

    price
  end

  def waitrose_or_marks_and_spencer_end?(array_of_text)
    array_of_text.any? { |str| str.downcase.include?('balance') }
  end

  def string_to_uk_price(str)
    str.gsub("-", "").gsub(",", ".").to_f
  end

  # ----------------------------

  def prepare_texts_for_polish_shop
    grouped_texts = group_texts_for_polish_shop
    grouped_texts << total_price_array_of_text_polish_or_comberton_shop
    build_array_of_texts_with_prices_polish_shop(grouped_texts)
  end

  def group_texts_for_polish_shop
    grouped_texts = []

    array_with_date = parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.match(/\d{2}\/\d{2}\/\d{2}/) } }
    array_with_date_index = parsed_texts.index(array_with_date)

    parsed_texts[array_with_date_index..-1].deep_dup.each.with_index do |array_of_text, index|
      break if polish_or_comberton_shop_end?(array_of_text)

      next if array_of_text == array_with_date

      if array_of_text.size == 1
        grouped_texts[-1]&.concat(array_of_text)
      else
        grouped_texts << array_of_text
      end
    end

    grouped_texts.each.with_index do |array_of_text, index|
      if array_of_text.any? { |str| str.include?("£") } && !grouped_texts[index - 1].any? { |str| str.include?("£") }
        grouped_texts[index - 1]&.concat(array_of_text)
        grouped_texts.delete_at(index)
      end
    end

    grouped_texts
  end

  def total_price_array_of_text_polish_or_comberton_shop
    parsed_texts.detect { |array_of_text| polish_or_comberton_shop_end?(array_of_text) }
  end

  def build_array_of_texts_with_prices_polish_shop(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each do |array_of_text|
      price = buid_uk_price(array_of_text)

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if polish_or_comberton_shop_end?(array_of_text)
    end

    array_of_texts_with_prices
  end

  def polish_or_comberton_shop_end?(array_of_text)
    array_of_text.any? { |str| str.downcase.include?('items') }
  end

  # ----------------------------

  def prepare_texts_for_comberton_shop
    grouped_texts = group_texts_for_comberton_shop
    grouped_texts << total_price_array_of_text_polish_or_comberton_shop
    build_array_of_texts_with_prices_polish_shop(grouped_texts)
  end

  def group_texts_for_comberton_shop
    grouped_texts = []

    array_with_pound = parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str == "£" } }
    array_with_pound_index = parsed_texts.index(array_with_pound)

    parsed_texts[array_with_pound_index..-1].deep_dup.each.with_index do |array_of_text, index|
      break if polish_or_comberton_shop_end?(array_of_text)

      next if array_of_text == array_with_pound

      grouped_texts << array_of_text
    end

    grouped_texts
  end

  # ----------------------------

  def prepare_texts_for_marks_and_spencer
    grouped_texts = group_texts_for_marks_and_spencer
    grouped_texts << total_price_array_of_text_marks_and_spencer
    build_array_of_texts_with_prices_marks_and_spencer(grouped_texts)
  end

  def group_texts_for_marks_and_spencer
    grouped_texts = []

    array_with_company_name = parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.include?("marksandspencer") } }
    array_with_company_name_index = parsed_texts.index(array_with_company_name)

    parsed_texts[array_with_company_name_index..-1].deep_dup.each.with_index do |array_of_text, index|
      break if waitrose_or_marks_and_spencer_end?(array_of_text)

      next if array_of_text == array_with_company_name
      next if array_of_text.size == 3

      grouped_texts << array_of_text
    end

    grouped_texts
  end

  def total_price_array_of_text_marks_and_spencer
    parsed_texts.detect { |array_of_text| waitrose_or_marks_and_spencer_end?(array_of_text) }
  end

  def build_array_of_texts_with_prices_marks_and_spencer(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each do |array_of_text|
      price = buid_uk_price(array_of_text)

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if waitrose_or_marks_and_spencer_end?(array_of_text)
    end

    array_of_texts_with_prices
  end

  # ----------------------------

  def prepare_texts_for_tesco
    grouped_texts = group_texts_for_tesco
    grouped_texts << total_price_array_of_text_tesco
    build_array_of_texts_with_prices_tesco(grouped_texts)
  end

  def group_texts_for_tesco
    grouped_texts = []

    array_with_company_name = parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.include?("tesco") } }
    array_with_company_name_index = parsed_texts.index(array_with_company_name)

    parsed_texts[array_with_company_name_index..-1].deep_dup.each.with_index do |array_of_text, index|
      break if total_end?(array_of_text)

      next if array_of_text == array_with_company_name

      grouped_texts << array_of_text
    end

    grouped_texts
  end

  def total_price_array_of_text_tesco
    parsed_texts.detect { |array_of_text| total_end?(array_of_text) }
  end

  def build_array_of_texts_with_prices_tesco(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each do |array_of_text|
      price = buid_uk_price(array_of_text)

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }

      break if total_end?(array_of_text)
    end

    array_of_texts_with_prices
  end

  # ----------------------------

  def prepare_texts_for_sok_turkey
    grouped_texts = group_texts_for_sok_turkey
    grouped_texts << total_price_array_of_text_sok_turkey
    build_array_of_texts_with_prices_sok_turkey(grouped_texts)
  end

  def group_texts_for_sok_turkey
    grouped_texts = []

    parsed_texts.deep_dup.each.with_index do |array_of_text, index|
      break if sok_turkey_end?(array_of_text)

      if array_of_text.any? { |str| str.length >= 13 && str.start_with?('8') } # product code => means new line
        grouped_texts << array_of_text
      else
        grouped_texts[-1]&.concat(array_of_text)
      end
    end

    grouped_texts
  end

  def total_price_array_of_text_sok_turkey
    total_price_array_of_text = parsed_texts.detect { |array_of_text| sok_turkey_total_price_end?(array_of_text) }

    if total_price_array_of_text[-1].downcase == "toplam"
      parsed_texts.each_with_index do |array_of_text, index|
        break total_price_array_of_text.concat(parsed_texts[index + 1]) if array_of_text == total_price_array_of_text
      end
    end

    total_price_array_of_text
  end

  def build_array_of_texts_with_prices_sok_turkey(grouped_texts)
    array_of_texts_with_prices = []

    grouped_texts.each do |array_of_text|
      price = buid_turkey_price(array_of_text)

      next if price.zero?

      array_of_texts_with_prices << {
        array_or_words: array_of_text,
        price: price,
      }
    end

    array_of_texts_with_prices
  end

  def buid_turkey_price(array_of_text)
    price = 0

    reversed_array_of_text = array_of_text.reverse
    reversed_array_of_text.each do |str|
      price = string_to_uk_price(str)

      next if price.zero?

      break price
    end

    price
  end

  def sok_turkey_end?(array_of_text)
    array_of_text.any? { |str| str.downcase.include?('topkdv') }
  end

  def sok_turkey_total_price_end?(array_of_text)
    array_of_text.any? { |str| str.downcase.include?('toplam') }
  end

  # ----------------------------
end
