module BuildArrayOfTextWithPrices
  class Default
    include CallableService

    def initialize(parsed_texts)
      @parsed_texts = parsed_texts
    end

    def call
      grouped_texts = group_texts_for_parsed_texts
      grouped_texts << total_price_array_of_text
      build_array_of_texts_with_prices(grouped_texts)
    end

    private

    def group_texts_for_parsed_texts
      raise NotImplementedError
    end

    def total_price_array_of_text
      raise NotImplementedError
    end

    def build_array_of_texts_with_prices
      raise NotImplementedError
    end

    def string_price_to_float_price(str)
      str.gsub("-", "").gsub(",", ".").to_f
    end
  end
end
