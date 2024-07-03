module BuildArrayOfTextWithPrices
  class Tesco < Default
    private

    def group_texts_for_parsed_texts
      grouped_texts = []

      array_with_company_name = @parsed_texts.detect { |array_of_text| array_of_text.any? { |str| str.include?("tesco") } }
      array_with_company_name_index = @parsed_texts.index(array_with_company_name)

      @parsed_texts[array_with_company_name_index..-1].deep_dup.each.with_index do |array_of_text, index|
        break if total_end?(array_of_text)
        break if subtotal_end?(array_of_text)

        next if array_of_text.any? { |str| str.downcase == 'vat' } && array_of_text.any? { |str| str.downcase == 'number' }
        next if array_of_text == array_with_company_name
        next if array_of_text.size <= 2
        next if !array_of_text[-1].include?('.')
        next if (array_of_text[-1].include?('.') && array_of_text[-1].include?('g'))

        grouped_texts << array_of_text
      end

      grouped_texts
    end

    def total_price_array_of_text
      @parsed_texts.detect { |array_of_text| total_end?(array_of_text) }
    end

    def build_array_of_texts_with_prices(grouped_texts)
      array_of_texts_with_prices = []

      grouped_texts.each do |array_of_text|
        price = buid_price(array_of_text)

        # subtract discount from the previous price
        if price.positive? && array_of_text.any? { |arr| arr == '-' } && array_of_text[-1].include?('.') && array_of_text[0].downcase == "cc"
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

    def total_end?(array_of_words)
      array_of_words.any? { |word| word.downcase == 'total' }
    end

    def subtotal_end?(array_of_text)
      array_of_text.any? { |str| str.downcase == 'subtotal' }
    end
  end
end
