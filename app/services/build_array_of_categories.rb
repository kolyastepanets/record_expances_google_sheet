class BuildArrayOfCategories
  include CallableService

  def initialize(kind_of_transaction, transaction_id, price)
    @categories = ReceiveCategories.call
    @kind_of_transaction = kind_of_transaction
    @transaction_id = transaction_id
    @price = price
  end

  def call
    categories = @categories.keys.each_slice(AllConstants::SHOW_ITEMS_PER_LINE).map do |categories_array|
      categories_array.map do |category|
        { text: category, callback_data: "#{category}:#{@kind_of_transaction}:#{@transaction_id}:#{@price}" }
      end
    end

    remove_messages = []
    if @transaction_id
      remove_messages = [
        {
          text: "Удалить сообщения этой транзакции",
          callback_data: "remove_messages: #{@transaction_id}"
        }
      ]
    end

    categories.push(remove_messages)

    categories
  end
end
