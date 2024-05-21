module BuildArrayOfTextWithPrices
  class Polish < Default
    private

    def group_texts_for_parsed_texts
      grouped_texts = []

      array_with_date = @parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.match(/\d{2}\/\d{2}\/\d{2}/) } }
      array_with_date_index = @parsed_texts.index(array_with_date)

      @parsed_texts[array_with_date_index..-1].deep_dup.each.with_index do |array_of_text, index|
        break if polish_shop_end?(array_of_text)

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

    def total_price_array_of_text
      @parsed_texts.detect { |array_of_text| polish_shop_end?(array_of_text) }
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

        break if polish_shop_end?(array_of_text)
      end

      array_of_texts_with_prices
    end

    def buid_price(array_of_text)
      price = 0

      reversed_array_of_text = array_of_text.reverse
      reversed_array_of_text.each do |str|
        price = string_price_to_float_price(str)

        next if price.zero?
        next if price > 300 # unreal price

        break price
      end

      price
    end

    def polish_shop_end?(array_of_text)
      array_of_text.any? { |str| str.downcase.include?('items') }
    end
  end
end
