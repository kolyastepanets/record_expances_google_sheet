module DetectCategoryAndSubcategoryFromLine
  class Default
    include CallableService

    def initialize(line_from_receipt)
      @line = line_from_receipt.downcase
    end

    def call
      category_name = nil
      sub_category_name = nil

      [category_name, sub_category_name]
    end
  end
end
