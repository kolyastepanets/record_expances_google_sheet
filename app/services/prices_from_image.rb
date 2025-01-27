class PricesFromImage
  include CallableService

  def initialize(message_params)
    @message_params = message_params
    @collected_prices = []
    @total_sum_in_receipt = 0
    @categories_with_prices = []
  end

  def call
    parse_image
    return_result
  end

  private

  def parse_image
    prepare_texts_by_class.each do |line|
      if prepare_texts_by_class[-1] == line
        break @total_sum_in_receipt = line[:price]
      end

      category_name, sub_category_name = shop_parse_class.call(line[:array_or_words])

      @categories_with_prices << {
        category_name: category_name,
        sub_category_name: sub_category_name,
        price: line[:price],
        full_parsed_line: line[:array_or_words].join(', '),
      }
    end
  end

  def get_telegram_image
    file_id = @message_params[:photo][-1][:file_id] if @message_params.key?(:photo)
    file_id = @message_params[:document][:file_id] if @message_params.key?(:document)

    response = Telegram.bot.get_file(file_id: file_id)
    @unique_file_id = response["result"]["file_unique_id"]

    url = "https://api.telegram.org/file/bot#{Telegram.bots_config[:default]}/#{response["result"]["file_path"]}"
    Faraday.new(url: url).get.body
  end

  def parsed_texts
    @parsed_texts ||= ConvertImageToArrayOfText.call(get_telegram_image)
  end

  def return_result
    [@categories_with_prices, @total_sum_in_receipt.round(2), @unique_file_id]
  end

  def is_pepito_supermarket?
    all_text.downcase.include?('peptomarket') || all_text.downcase.include?('pepito') || express_berawa?
  end

  def express_berawa?
    all_text.downcase.include?('berawa') && all_text.downcase.include?('express')
  end

  def is_frestive_supermarket?
    all_text.downcase.include?('frestive')
  end

  def is_waitrose?
    all_text.downcase.include?('waitrose')
  end

  def is_polish_shop?
    all_text.downcase.include?('polish') && all_text.downcase.include?('marke')
  end

  def is_comberton_shop?
    all_text.downcase.include?('comberton') || all_text.downcase.include?('costcutter')
  end

  def is_marks_and_spencer?
    all_text.downcase.include?('marksandspencer')
  end

  def is_lidl?
    all_text.downcase.include?('lidl.co.uk')
  end

  def is_tesco?
    all_text.downcase.include?('tesco')
  end

  def is_sok_turkey?
    all_text.downcase.include?('marketler')
  end

  def is_bim_turkey?
    (all_text.downcase.include?('bim') || all_text.downcase.include?('bi̇m')) &&
      (all_text.downcase.include?('bi̇rleşik') || all_text.downcase.include?('bi̇rleşi̇k'))
  end

  def all_text
    @all_text ||= parsed_texts.flat_map(&:join).join
  end

  def shop_parse_class
    if is_waitrose?
      DetectCategoryAndSubcategoryFromLine::WaitroseShop
    elsif all_text.include?('sainsbury')
      DetectCategoryAndSubcategoryFromLine::SainsburysShop
    elsif is_comberton_shop?
      DetectCategoryAndSubcategoryFromLine::CombertonShop
    elsif is_polish_shop?
      DetectCategoryAndSubcategoryFromLine::PolishShop
    elsif is_marks_and_spencer?
      DetectCategoryAndSubcategoryFromLine::MarksAndSpencerShop
    elsif is_lidl?
      DetectCategoryAndSubcategoryFromLine::LidlShop
    elsif is_frestive_supermarket?
      DetectCategoryAndSubcategoryFromLine::FrestiveShop
    elsif is_pepito_supermarket?
      DetectCategoryAndSubcategoryFromLine::PepitoShop
    elsif is_sok_turkey?
      DetectCategoryAndSubcategoryFromLine::SokTurkeyShop
    elsif is_bim_turkey?
      DetectCategoryAndSubcategoryFromLine::BimTurkeyShop
    elsif is_tesco?
      DetectCategoryAndSubcategoryFromLine::TescoShop
    else
      DetectCategoryAndSubcategoryFromLine::Default
    end
  end

  def prepare_texts_by_class
    klass = if is_waitrose?
              BuildArrayOfTextWithPrices::Waitrose
            elsif all_text.include?('sainsbury')
              BuildArrayOfTextWithPrices::Sainsburys
            elsif is_comberton_shop?
              BuildArrayOfTextWithPrices::Comberton
            elsif is_polish_shop?
              BuildArrayOfTextWithPrices::Polish
            elsif is_marks_and_spencer?
              BuildArrayOfTextWithPrices::MarksAndSpencer
            elsif is_lidl?
              BuildArrayOfTextWithPrices::Lidl
            elsif is_frestive_supermarket?
              BuildArrayOfTextWithPrices::Frestive
            elsif is_pepito_supermarket?
              BuildArrayOfTextWithPrices::Pepito
            elsif is_sok_turkey?
              BuildArrayOfTextWithPrices::SokTurkey
            elsif is_bim_turkey?
              BuildArrayOfTextWithPrices::BimTurkey
            elsif is_tesco?
              BuildArrayOfTextWithPrices::Tesco
            else
              BuildArrayOfTextWithPrices::Default
            end
    klass.call(parsed_texts)
  end
end
