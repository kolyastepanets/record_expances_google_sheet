class UsdFloatFromStringPriceToPutInSheets
  include CallableService

  def initialize(price_to_put_in_sheets)
    @price_to_put_in_sheets = price_to_put_in_sheets
  end

   # input:
   # "=75000 * 0,0024204 / 37,4406"
   # or
   # "=75000 / 15590,3682"
   #
   # output: result of 75000 * 0.0024204 / 37.4406
  def call
    return if @price_to_put_in_sheets.blank?

    price = @price_to_put_in_sheets.delete('=')
    first_part, divide_by = price.split('/')
    divide_by_number = divide_by.gsub(',', '.').to_f

    first_part_number = first_part.to_f
    if first_part.include?('*')
     first_number, second_number = first_part.split('*')
     first_number = first_number.gsub(',', '.').to_f
     second_number = second_number.gsub(',', '.').to_f

     first_part_number = first_number * second_number
    end

    (first_part_number / divide_by_number).round(0)
  end
end
