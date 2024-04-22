module BuildArrayOfTextWithPrices
  class SokTurkey < Default
    private

    def group_texts_for_parsed_texts
      grouped_texts = []
      first_2adt = !@parsed_texts.join.include?("2adt")

      @parsed_texts.deep_dup.each.with_index do |array_of_text, index|
        break if not_product?(array_of_text)

        if array_of_text.join.downcase.include?("2adt")
          first_2adt = true
          next
        end
        next if !first_2adt

        last_two_elements = array_of_text.last(2)
        if last_two_elements[0] == "*" && last_two_elements[1].include?(",")
          grouped_texts[-1]&.concat(array_of_text)
        else
          grouped_texts << array_of_text
        end
      end

      grouped_texts.filter { |array_of_text| array_of_text.length > 1 }
                   .drop_while { |array_of_text| !array_of_text.include?("FİŞ") || !array_of_text.include?("NO") }
                   .reject { |array_of_text| array_of_text.include?("FİŞ") && array_of_text.include?("NO") }
    end

    def total_price_array_of_text
      total_price_array_of_text = @parsed_texts.detect { |array_of_text| total_price_end?(array_of_text) }

      if total_price_array_of_text[-1].downcase == "toplam"
        @parsed_texts.each_with_index do |array_of_text, index|
          break total_price_array_of_text.concat(@parsed_texts[index + 1]) if array_of_text == total_price_array_of_text
        end
      end

      total_price_array_of_text
    end

    def build_array_of_texts_with_prices(grouped_texts)
      array_of_texts_with_prices = []

      grouped_texts.each do |array_of_text|
        price = buid_price(array_of_text)

        next if price.zero?

        array_of_texts_with_prices << {
          array_or_words: array_of_text,
          price: price,
        }
      end

      array_of_texts_with_prices
    end

    def buid_price(array_of_text)
      price = 0

      reversed_array_of_text = array_of_text.reverse
      reversed_array_of_text.each do |str|
        price = string_price_to_float_price(str)

        next if price.zero?

        break price
      end

      price
    end

    def not_product?(array_of_text)
      array_of_text.any? { |str| str.downcase.include?('topkdv') }
    end

    def total_price_end?(array_of_text)
      array_of_text.any? { |str| str.downcase.include?('toplam') }
    end
  end
end
