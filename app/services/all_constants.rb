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
  SALARY_ON_USD_FOP = 'usd fop mono'.freeze
  SALARY_ON_UAH_BLACK_MONO = 'uah black mono'.freeze
end
