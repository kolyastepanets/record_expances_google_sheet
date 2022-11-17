# ApiGoogleSheet::ReceiveCategories

module ApiGoogleSheet
  class ReceiveCategories < GetOrSetDataInGoogleSheetBase
    def initialize
      @redis = Redis.new
    end

    def call
      return categories_from_redis if categories_from_redis.any?

      super
    end

    private

    def prepare_request_data
      @range = "'Категории'!A2:B1000"
    end

    def parse_response
      category_to_sub_categories = @response.values.group_by(&:shift).transform_values(&:flatten)
      @redis.set("category_to_sub_categories", category_to_sub_categories.to_json, ex: 1.month)
      category_to_sub_categories
    end

    def categories_from_redis
      category_to_sub_categories = @redis.get("category_to_sub_categories")

      return [] if category_to_sub_categories.nil?

      JSON.parse(category_to_sub_categories)
    end
  end
end
