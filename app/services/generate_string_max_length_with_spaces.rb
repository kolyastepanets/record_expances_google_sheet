class GenerateStringMaxLengthWithSpaces
  include CallableService

  def initialize(word, max_characters_length)
    @word = word.to_s
    @max_characters_length = max_characters_length
  end

  def call
    how_many_spaces_to_add = @max_characters_length - @word.size
    word_to_display = @word.truncate(@max_characters_length, omission: '')
    how_many_spaces_to_add.times do
      word_to_display << " "
    end
    word_to_display
  end
end
