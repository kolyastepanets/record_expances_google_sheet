module BuildArrayOfTextWithPrices
  class Lidl < Default
    private

    def group_texts_for_parsed_texts
      grouped_texts = []

      array_with_pound = @parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str == "£" } }
      array_with_pound_index = @parsed_texts.index(array_with_pound)

      # binding.pry
      @parsed_texts[array_with_pound_index..-1].deep_dup.each.with_index do |array_of_text, index|
        break if total_end_card?(array_of_text)
        break if total_end?(array_of_text)

        next if array_of_text == array_with_pound
        next if array_of_text.include?('@') && array_of_text.include?('kg') && array_of_text.include?('/')

        if array_of_text.size <= 2 && !discount?(array_of_text[-1])
          grouped_texts[-1]&.concat(array_of_text)
          next
        end

        grouped_texts << array_of_text
      end

      grouped_texts
    end

    def total_price_array_of_text
      @parsed_texts.detect { |array_of_text| total_end_card?(array_of_text) } ||
        @parsed_texts.detect { |array_of_text| total_end?(array_of_text) }
    end

    def build_array_of_texts_with_prices(grouped_texts)
      array_of_texts_with_prices = []

      grouped_texts.each do |array_of_text|
        price = buid_price(array_of_text)

        # subtract discount from the previous price
        if price.positive? && discount?(array_of_text[-1])
          array_of_texts_with_prices[-1][:price] -= price
          next
        end

        next if price.zero?

        array_of_texts_with_prices << {
          array_or_words: array_of_text,
          price: price,
        }

        break if total_end?(array_of_text)
      end

      array_of_texts_with_prices.filter { |hash| hash[:price].positive? }
    end

    def discount?(element)
      element.include?('-') && element.include?('.')
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

    def total_end?(array_of_words)
      array_of_words.any? { |word| word.downcase == 'total' }
    end

    def total_end_card?(array_of_words)
      array_of_words.any? { |word| word.downcase == 'card' }
    end
  end
end
