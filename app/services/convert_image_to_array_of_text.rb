class ConvertImageToArrayOfText < GoogleVisionBase
  POSSIBLE_Y_POSITION = 11

  def initialize(image)
    @image = image
  end

  private

  def parse_response
    result = @response.responses[0].to_h

    grouped_strings = []

    result[:text_annotations].each do |text_annotation|
      grouped_strings << { key: text_annotation[:bounding_poly][:vertices][-1][:y], text: [text_annotation[:description]] }
    end
    grouped_strings.delete_at(0)

    grouped_texts = []
    grouped_texts << grouped_strings[0]

    grouped_strings.each do |grouped_string|
      grouped_texts.each do |grouped_text|
        if grouped_text[:key].between?(grouped_string[:key] - POSSIBLE_Y_POSITION, grouped_string[:key] + POSSIBLE_Y_POSITION)
          break grouped_text[:text].concat(grouped_string[:text])
        end
        if grouped_texts[-1] == grouped_text
          break grouped_texts << grouped_string
        end
      end
    end

    grouped_texts = grouped_texts.sort_by{ |grouped_text| grouped_text[:key] }

    text_lines = []

    grouped_texts.each do |grouped_text|
      text_lines << grouped_text[:text].join
    end

    text_lines
  end
end
