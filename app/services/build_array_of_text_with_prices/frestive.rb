module BuildArrayOfTextWithPrices
  class Frestive < Default
    private

    def group_texts_for_parsed_texts
      grouped_texts = []

      @parsed_texts.deep_dup.each.with_index do |array_of_text, index|
        break if array_of_text.any? { |str| str.downcase.include?('total') }

        next if array_of_text.any? { |str| str.include?('@') || str.include?('€') } # skip ['1', '@', '115,000'] - it means quantity and full price
        next if array_of_text.any? { |str| str.include?('disc') } # skip discount
        next if array_of_text.size == 1 && !array_of_text.any? { |str| str.match(/[[:punct:]]/) } # skip ['randomtext']
        next if array_of_text.size == 4 && string_price_to_float_price(array_of_text[0]).between?(1, 10) # ["0.9", "167", ",", "000"]
        next if array_of_text.any? { |str| str.count('/') == 2 } # skip date
        next if array_of_text.any? { |str| str.count(':') == 2 || str.count(':') == 1 } # skip time
        next if array_of_text.size == 1 && @parsed_texts[index + 1].any? { |str| str.include?('disc') } # special hack for 2 cases
        next if array_of_text.size == 2 && @parsed_texts[index + 1].any? { |str| frestive_product_start?(str.gsub(/\D/, '')) } # ["0.274", "33,000"]
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

    def total_price_array_of_text
      total_price_array_of_text = @parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.downcase.include?('total') } }

      if total_price_array_of_text[-1].downcase == "total"
        @parsed_texts.each_with_index do |array_of_text, index|
          break total_price_array_of_text.concat(@parsed_texts[index + 1]) if array_of_text == total_price_array_of_text
        end
      end

      total_price_array_of_text
    end

    def build_array_of_texts_with_prices(grouped_texts)
      array_of_texts_with_prices = []

      grouped_texts.each.with_index do |array_of_text, index|
        price = buid_price(array_of_text)

        next if price.zero?

        array_of_texts_with_prices << {
          array_or_words: array_of_text,
          price: price,
        }

        break if array_of_text.any? { |str| str.downcase.include?('total') }
      end

      array_of_texts_with_prices
    end

    def buid_price(array_of_text)
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

        price = string_price_to_float_price(str)

        next if price < 10

        break price
      end

      price
    end

    def string_price_to_float_price(str)
      str.delete(",").delete(".").to_f
    end
  end
end
