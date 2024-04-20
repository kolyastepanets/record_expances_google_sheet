module BuildArrayOfTextWithPrices
  class Pepito < Default
    private

    def group_texts_for_parsed_texts
      grouped_texts = []

      @parsed_texts.deep_dup.each.with_index do |array_of_text, index|
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

    def total_price_array_of_text
      array_of_text_total_price = nil
      next_array = nil

      @parsed_texts.each_with_index do |array_of_text, index|
        if net_value?(array_of_text)
          array_of_text_total_price = array_of_text
          next_array = @parsed_texts[index + 1]
          break
        end
      end

      if string_price_to_float_price(array_of_text_total_price[-1]).zero?
        array_of_text_total_price.concat(next_array)
      end

      array_of_text_total_price
    end

    def build_array_of_texts_with_prices(grouped_texts)
      array_of_texts_with_prices = []

      grouped_texts.each.with_index do |array_of_text, index|
        price = buid_price(array_of_text)
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

    def build_indonesian_price_with_discount(array_of_text)
      discount = 0

      array_of_text.reverse.each do |str|
        discount = string_price_to_float_price(str)
        next if discount.zero?

        break discount
      end

      price = 0
      array_of_text.take_while { |str| !str.include?('Disc') }.reverse.each do |str|
        price = string_price_to_float_price(str)
        next if price.zero?

        break price
      end

      price - discount
    end

    def string_price_to_float_price(str)
      str.delete(",").delete(".").to_f
    end

    def net_value?(array_of_text)
      array_of_text.join(', ').downcase.include?('net') && array_of_text.join(', ').downcase.include?('value')
    end
  end
end
