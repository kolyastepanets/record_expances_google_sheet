module AllConstants
  VIKA_PAYED = 'v'.freeze
  MYKOLA_PAYED = 'm'.freeze
  MAIN_BUTTONS = [
    ['All buttons', 'Внести расходы'],
  ].freeze
  REPLY_MARKUP_MAIN_BUTTONS = {
    keyboard: MAIN_BUTTONS,
    resize_keyboard: true,
    one_time_keyboard: true,
    is_persistent: false,
    selective: true,
  }.freeze
  SALARY_ON_WISE = 'wise'.freeze
  SALARY_ON_UAH_BLACK_MONO = 'uah black mono'.freeze
  SHOW_ITEMS_PER_LINE = 2
  SHOW_TRAVEL_SUB_CATEGORIES_PER_LINE = 1
  ALL_COLUMN_LETTERS = ('A'..'Z').to_a.concat(('AA'..'CJ').to_a)
end
