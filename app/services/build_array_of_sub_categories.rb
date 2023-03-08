class BuildArrayOfSubCategories
  include CallableService

  def initialize(category_name, kind_of_transaction, transaction_id, price)
    @categories = ReceiveCategories.call
    @category_name = category_name
    @kind_of_transaction = kind_of_transaction
    @transaction_id = transaction_id
    @price = price
  end

  def call
    show_per_line = @category_name == 'Путешествия' ? AllConstants::SHOW_TRAVEL_SUB_CATEGORIES_PER_LINE : AllConstants::SHOW_ITEMS_PER_LINE

    prepare_sub_categories = @categories[@category_name].each_slice(show_per_line)
                                                        .map do |sub_categories_array|
      sub_categories_array.map do |sub_category|
        sub_category = sub_category.first(15) + "_" if sub_category.size > 15

        { text: sub_category, callback_data: "#{sub_category}:#{@kind_of_transaction}:#{@transaction_id}:#{@price}" }
      end
    end

    category_without_subcategory = [
      {
        text: "<<",
        callback_data: "<<:#{@kind_of_transaction.delete("1")}:#{@transaction_id}:#{@price}"
      },
      {
        text: "Без подкатегории",
        callback_data: ":#{@kind_of_transaction}:#{@transaction_id}:#{@price}"
      }
    ]

    prepare_sub_categories.push(category_without_subcategory)
  end
end
