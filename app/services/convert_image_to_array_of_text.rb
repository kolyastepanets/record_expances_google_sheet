class ConvertImageToArrayOfText < GoogleVisionBase
  POSSIBLE_Y_POSITION = 10

  def initialize(image)
    @image = image
  end

  private

  def parse_response
    result = @response.responses[0].to_h

    grouped_strings = []

    result[:text_annotations].each do |text_annotation|
      grouped_strings << {
        key_y: text_annotation[:bounding_poly][:vertices][0][:y] || 0,
        key_x: text_annotation[:bounding_poly][:vertices][0][:x],
        text: text_annotation[:description]
      }
    end
    grouped_strings.delete_at(0)

    grouped_strings = grouped_strings.sort_by{ |grouped_string| grouped_string[:key_y] }

    memo = {}

    grouped_strings.each do |grouped_string|
      is_added = false

      POSSIBLE_Y_POSITION.times do |i|
        if memo.key?(grouped_string[:key_y] - i)
          memo[grouped_string[:key_y] - i] ||= []
          memo[grouped_string[:key_y] - i] << grouped_string

          is_added = true
          break
        end
      end

      next if is_added
      memo[grouped_string[:key_y]] ||= []
      memo[grouped_string[:key_y]] << grouped_string
    end

    memo = memo.sort

    grouped_texts = []

    memo.each do |key, values|
      grouped_texts << sort_words_from_left_to_right(values)
    end

    grouped_texts
  end

  def sort_words_from_left_to_right(values)
    values.sort_by { |value| value[:key_x] }.map { |value| value[:text] }
  end
end
