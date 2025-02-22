module DetectCategoryAndSubcategoryFromLine
  class FrestiveShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine? || champagne? || beer_2? || wine_2? || wine_3?
    end

    def beer?
      @line.include?('bintang')
    end

    def wine?
      @line.include?('hatten')
    end

    def champagne?
      @line.include?('sababay') && @line.include?('ascaro')
    end

    def beer_2?
      @line.include?('bali') && @line.include?('hai') && @line.any? { |word| word.include?('can') }
    end

    def wine_2?
      @line.any? { |word| word.include?('wine') }
    end

    def wine_3?
      @line.include?('sababay') && @line.include?('pink')
    end

    ####

    def eggs?
      @line.include?('egg') || (@line.any? { |word| word.include?('egg') } && @line.include?('rossa'))
    end

    ####

    def water?
      coca_cola? || rauch_juice? || mixed_juice? || fanta? || jungle_juice? || nestle_water? ||
        aqua_water? || cheers_water? || mango_juice? || peach_juice? || pear_juice? || bottle_of_water? ||
        water_soda? || diamond_juice? || coconut_water?
    end

    def coca_cola?
      @line.include?('coca') && @line.include?('cola')
    end

    def rauch_juice?
      @line.include?('rauch')
    end

    def mixed_juice?
      @line.include?('mixed') && @line.include?('juice')
    end

    def fanta?
      @line.include?('fanta')
    end

    def jungle_juice?
      @line.include?('jungle') && @line.include?('jc')
    end

    def nestle_water?
      @line.include?('nestle') && @line.include?('600ml')
    end

    def aqua_water?
      @line.include?('aqua') && @line.include?('water')
    end

    def cheers_water?
      @line.include?('cheers') && @line.include?('water')
    end

    def mango_juice?
      @line.include?('sunfrsh') && @line.any? { |word| word.include?('mango') }
    end

    def peach_juice?
      @line.include?('compal') && @line.include?('peach')
    end

    def pear_juice?
      @line.include?('pear') && @line.include?('1l')
    end

    def bottle_of_water?
      @line.include?('wtr') && @line.include?('btl')
    end

    def water_soda?
      @line.include?('polaris') && @line.include?('soda')
    end

    def diamond_juice?
      @line.include?('diamnd') && @line.include?('jccrnbrry200m')
    end

    def coconut_water?
      @line.include?('fresh') && @line.include?('ccnutwtr')
    end

    ####

    def spices_and_seasonings?
      cook_cream? || sunflower_oil? || mayonaise? || mustard? || mayonaise_2? || soy_souce? ||
        oil? || sunflower_oil_2? || sugar? || salt? || leaves? || vinegar? || sunflower_oil_3? ||
        mustard_2? || cream_for_cake? || jelly_for_cake? || salted_caramel?
    end

    def cook_cream?
      @line.include?('cook') && @line.include?('cream')
    end

    def sunflower_oil?
      @line.include?('mazola') && (@line.include?('snflwr') || @line.include?('sunflower'))
    end

    def mayonaise?
      @line.include?('mynais') && @line.include?('kewpie')
    end

    def mustard?
      @line.include?('french') && @line.any? { |word| word.include?('mstd') }
    end

    def mayonaise_2?
      @line.include?('mayo') && @line.include?('mamasuka')
    end

    def soy_souce?
      @line.include?('kikkoman')
    end

    def oil?
      @line.include?('filippo') && @line.any? { |word| word.include?('oil') }
    end

    def sunflower_oil_2?
      @line.include?('snflower') && @line.any? { |word| word.include?('oil') }
    end

    def sugar?
      @line.include?('gula')
    end

    def salt?
      @line.include?('pura') && @line.include?('sea') && @line.include?('slt')
    end

    def leaves?
      @line.include?('jays') && @line.include?('bay') && @line.include?('leaves')
    end

    def vinegar?
      @line.include?('wht') && @line.any? { |word| word.include?('vngr') }
    end

    def sunflower_oil_3?
      @line.include?('snflwr') && @line.any? { |word| word.include?('oil') }
    end

    def mustard_2?
      @line.include?('heinz') && @line.include?('mustrd')
    end

    def cream_for_cake?
      @line.include?('hulala') && @line.include?('whip')
    end

    def jelly_for_cake?
      @line.include?('tarami') && @line.include?('jly') && @line.include?('mngo')
    end

    def salted_caramel?
      @line.include?('icelab') && @line.include?('slt')
    end

    ####

    def sweets?
      honey? || oreo? || monggo_chocolate? || icecream? || kinder_joy? || kinder_bueno? ||
        like_m_and_ms? || lindt? || chacha? || poule_de_luxe? || hello_panda? || honey_2? ||
        nutella? || schogetten? || cookies? || kit_kat? || kitkat? || hershey? || promo_pack? ||
        dark_chocolate? || haribo? || icecream_2? || excellence_chocolate? || bon_bon? ||
        kinder_schokobon? || deka? || ritter? || toblerone? || silver_queen? || jam? ||
        jelly? || kit_kat_2?
    end

    def honey?
      @line.include?('shifa') && @line.include?('acacia')
    end

    def oreo?
      @line.include?('oreo')
    end

    def monggo_chocolate?
      @line.include?('monggo')
    end

    def icecream?
      @line.include?('walls')
    end

    def kinder_joy?
      @line.include?('kinder') && @line.include?('joy')
    end

    def kinder_bueno?
      @line.include?('kinder') && @line.include?('bueno')
    end

    def like_m_and_ms?
      @line.include?('delfi')
    end

    def lindt?
      @line.include?('lindt')
    end

    def chacha?
      @line.include?('chacha')
    end

    def poule_de_luxe?
      @line.include?('poule') && @line.include?('de')
    end

    def hello_panda?
      @line.include?('hello') && @line.include?('panda')
    end

    def honey_2?
      @line.include?('ldm') && @line.include?('squeezy')
    end

    def nutella?
      @line.include?('nutella')
    end

    def schogetten?
      @line.include?('schogtn')
    end

    def cookies?
      @line.include?('hllo') && @line.include?('pnda')
    end

    def kit_kat?
      @line.include?('kit') && @line.include?('kat')
    end

    def kitkat?
      @line.include?('kitkat')
    end

    def hershey?
      @line.include?('hershey') && @line.any? { |word| word.include?('crm') }
    end

    def promo_pack?
      @line.include?('promo') && @line.include?('pack')
    end

    def dark_chocolate?
      @line.include?('dark') && @line.include?('milkcho')
    end

    def haribo?
      @line.include?('haribo')
    end

    def icecream_2?
      @line.include?('haagendazs')
    end

    def excellence_chocolate?
      @line.include?('excellence') && @line.include?('ex')
    end

    def bon_bon?
      @line.include?('bonbon')
    end

    def kinder_schokobon?
      @line.include?('kinder') && @line.include?('schokobon')
    end

    def deka?
      @line.include?('deka') && @line.include?('btsch080')
    end

    def ritter?
      @line.include?('ritter')
    end

    def toblerone?
      @line.include?('toblerone')
    end

    def silver_queen?
      @line.include?('silver') && @line.include?('queen')
    end

    def jam?
      @line.include?('bonne') && @line.include?('blckbry')
    end

    def jelly?
      @line.include?('nutrijell') && @line.include?('delima15gr')
    end

    def kit_kat_2?
      @line.include?('nstl') && @line.include?('ktkt')
    end

    ####

    def tea_or_coffee?
      coffee?
    end

    def coffee?
      @line.include?('nescafe')
    end

    ####

    def fruits?
      banana? || apple? || melon? || pineapple? || watermelon? || mango? || cherry? ||
        strawberry? || blueberry? || pear? || papaya? || raspberry? || grape? || green_grape? ||
        grape_2? || mangosteen? || strawberry_2? || peas?
    end

    def banana?
      @line.include?('banana') && @line.include?('sunpride')
    end

    def apple?
      @line.include?('apple')
    end

    def melon?
      @line.include?('melon')
    end

    def pineapple?
      @line.include?('pineapple')
    end

    def watermelon?
      @line.include?('watermelon') || @line.include?('waterme_on')
    end

    def mango?
      @line.include?('mango')
    end

    def cherry?
      @line.include?('cherry') && !@line.include?('tomato')
    end

    def strawberry?
      @line.include?('strawberry')
    end

    def blueberry?
      @line.include?('blueberry')
    end

    def pear?
      @line.include?('pear') && @line.include?('honey')
    end

    def papaya?
      @line.include?('pepaya') && @line.include?('california')
    end

    def raspberry?
      @line.include?('raspberry')
    end

    def grape?
      @line.include?('anggur') && @line.include?('bali')
    end

    def green_grape?
      @line.include?('grape') && @line.include?('green')
    end

    def grape_2?
      @line.include?('grape') && (@line.include?('calmeria') || @line.include?('mus'))
    end

    def mangosteen?
      @line.include?('mangosteen')
    end

    def strawberry_2?
      @line.include?('straw') && @line.include?('fresa')
    end

    def peas?
      @line.include?('kapri')
    end

    ####

    def vegetables?
      potato? || pepper? || zucchini? || tomato? || parsley? || carrot? || sault_cucumbers? ||
        bonduel_peas? || avocado? || garlic? || rucola? || cabbage_chinese? || herb? ||
        eggplant_purple? || cucumber? || asparagus? || green_onion? || zucchini_2? || radish? ||
        red_onion? || corn? || broccoli? || corn_2? || champignon? || herb_2? || corn_3? ||
        parsley_2? || pumpkin? || onion? || tomato_2? || beetroot? || cabbage_white?
    end

    def potato?
      @line.include?('potato')
    end

    def pepper?
      @line.include?('capsicum') && @line.include?('hidropo')
    end

    def zucchini?
      @line.include?('timun') && @line.include?('jepang')
    end

    def tomato?
      @line.include?('tomato')
    end

    def parsley?
      @line.include?('parsley')
    end

    def carrot?
      @line.include?('carrot')
    end

    def sault_cucumbers?
      @line.include?('kuhne') && @line.include?('feine')
    end

    def bonduel_peas?
      @line.include?('bonduel') && @line.include?('peas')
    end

    def avocado?
      @line.include?('avocado')
    end

    def garlic?
      @line.include?('garlic')
    end

    def rucola?
      @line.include?('rucola')
    end

    def cabbage_chinese?
      @line.include?('cabbage') && @line.include?('chinese')
    end

    def herb?
      @line.any? { |word| word.include?('dill') }
    end

    def eggplant_purple?
      @line.include?('eggplant') && @line.include?('purple')
    end

    def cucumber?
      @line.include?('kyuri')
    end

    def asparagus?
      @line.include?('asparagus')
    end

    def green_onion?
      @line.include?('daun') && @line.include?('bawang')
    end

    def zucchini_2?
      @line.include?('zucchini') && @line.include?('green')
    end

    def radish?
      @line.include?('red') && @line.include?('radish')
    end

    def red_onion?
      @line.include?('red') && @line.include?('onion')
    end

    def corn?
      @line.include?('daucy') && @line.any? { |word| word.include?('swtcorn') }
    end

    def broccoli?
      @line.include?('broccoli')
    end

    def corn_2?
      @line.include?('chile') && @line.include?('corn')
    end

    def champignon?
      @line.include?('champignon')
    end

    def herb_2?
      # but should recognize as dill, not oill
      @line.include?('leaf') && @line.any? { |word| word.include?('oill') }
    end

    def corn_3?
      @line.include?('corn') && @line.include?('sweet')
    end

    def parsley_2?
      @line.include?('puri') && @line.include?('cheery')
    end

    def pumpkin?
      @line.include?('kabocha') && @line.include?('red')
    end

    def onion?
      @line.include?('oni') && @line.include?('bom') && @line.include?('sunrise')
    end

    def tomato_2?
      @line.include?('tom') && @line.include?('chr')
    end

    def beetroot?
      @line.include?('beetroot')
    end

    def cabbage_white?
      @line.include?('cabbage') && @line.include?('white')
    end

    ####

    def dairy?
      cheese? || butter? || milk? || sour_cream? || kefir? || sour_cream_2? ||
        plain_yogurt? || sour_cream_3? || butter_2? || biokul_yogurt? || yummy_yogurt? ||
        greenfield_yogurt? || butter_3?
    end

    def cheese?
      ricotta? || slices? || mozarella? || yummy_chese? || block? || president_gouda? ||
        bel_cheese? || baros_gouda? || ricta? || bega? || smoked_cheese? || kiri? ||
        laughing_cow_cheese? || cottage_cheese? || sweet_cheese? || paysan? || mini_cheese? ||
        cottage_cheese_2? || arla?
    end

    def ricotta?
      @line.include?('fresh') && @line.include?('ricotta')
    end

    def slices?
      @line.include?('kraft') && @line.include?('singles')
    end

    def mozarella?
      (@line.include?('bella') && @line.include?('mozza')) || @line.include?('mozarella')
    end

    def yummy_chese?
      @line.include?('yummy') && @line.any? { |word| word.include?('chese') }
    end

    def block?
      @line.include?('emmental') && @line.include?('block')
    end

    def president_gouda?
      @line.include?('president') && @line.include?('gouda')
    end

    def bel_cheese?
      @line.include?('bel') && @line.include?('chese')
    end

    def baros_gouda?
      @line.include?('baros') && @line.include?('gouda')
    end

    def ricta?
      @line.include?('yummy') && @line.include?('ricta')
    end

    def bega?
      @line.include?('bega') && @line.any? { |word| word.include?('slices') }
    end

    def smoked_cheese?
      @line.include?('emina') && @line.include?('smok') && @line.include?('ches')
    end

    def kiri?
      @line.include?('kiri') && @line.include?('cheese')
    end

    def laughing_cow_cheese?
      @line.include?('laughng') && @line.any? { |word| word.include?('cw') }
    end

    def cottage_cheese?
      @line.include?('cottage') && @line.include?('cheese')
    end

    def sweet_cheese?
      @line.include?('mascarpn') && @line.any? { |word| word.include?('chsvan') }
    end

    def paysan?
      @line.include?('payson') && @line.include?('breton')
    end

    def mini_cheese?
      @line.include?('babybel') && @line.any? { |word| word.include?('chddr') }
    end

    def butter?
      @line.include?('anchor')
    end

    def milk?
      @line.include?('greenfields')
    end

    def sour_cream?
      @line.include?('sour') && @line.any? { |word| word.include?('cream') }
    end

    def kefir?
      @line.include?('kefir')
    end

    def sour_cream_2?
      @line.include?('yummy') && @line.include?('creme')
    end

    def plain_yogurt?
      @line.include?('plain') && @line.include?('yogurt')
    end

    def sour_cream_3?
      @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('milk') }
    end

    def butter_2?
      @line.include?('metzgr') && @line.include?('cafe')
    end

    def biokul_yogurt?
      @line.include?('biokul') && (@line.include?('yghrt') || @line.include?('yg'))
    end

    def yummy_yogurt?
      @line.include?('yummy') && @line.include?('yog')
    end

    def greenfield_yogurt?
      @line.include?('greenfield') && @line.include?('yg')
    end

    def cottage_cheese_2?
      @line.include?('milkup') && @line.any? { |word| word.include?('cttgch') }
    end

    def butter_3?
      @line.include?('lurpak') && @line.include?('butter')
    end

    def arla?
      @line.include?('arla') && @line.include?('cheese')
    end

    ####

    def bread?
      just_bread? || bread_for_hot_dog? || for_wrap? || flour? || some_bread? || flour_2? ||
        bread_2? || bread_3? || bread_4? || waffles?
    end

    def just_bread?
      @line.include?('bread')
    end

    def bread_for_hot_dog?
      @line.include?('dog') && @line.include?('hot')
    end

    def for_wrap?
      @line.include?('kawan') && @line.include?('roti')
    end

    def flour?
      @line.include?('kunci') && @line.include?('biru')
    end

    def some_bread?
      @line.include?('roti') && @line.include?('bgb')
    end

    def flour_2?
      @line.include?('cakra') && @line.include?('kembar') && @line.any? { |word| word.include?('terigu') }
    end

    def bread_2?
      @line.include?('rumah') && @line.include?('roti') && @line.include?('brown')
    end

    def bread_3?
      @line.include?('bakker') && @line.include?('rosemary')
    end

    def bread_4?
      @line.include?('bakker') && (@line.include?('brea') || @line.include?('br') || @line.include?('champagne'))
    end

    def waffles?
      @line.include?('waffles')
    end

    ####

    def meat?
      chicken? || chicken_leg? || chicken_2? || pork? || bacon? || beef? ||
        pork_slices? || mamas_bacon? || duck?
    end

    def chicken?
      @line.include?('chicken') && !@line.include?('thins')
    end

    def chicken_leg?
      @line.include?('paha') && @line.any? { |word| word.include?('bawa') }
    end

    def chicken_2?
      @line.include?('paha') && @line.include?('atas')
    end

    def pork?
      @line.include?('pork')
    end

    def bacon?
      @line.include?('bacon')
    end

    def beef?
      @line.include?('beef')
    end

    def pork_slices?
      @line.include?('svenschoc') && @line.any? { |word| word.include?('pork') }
    end

    def mamas_bacon?
      @line.include?('mamas') && @line.include?('bcn')
    end

    def duck?
      @line.include?('fume') && @line.include?('duck') && @line.include?('legconfit')
    end

    ####

    def fish?
      tuna? || shrimp? || barramundi? || fish_steak? || canned_fish? || canned_fish_2? ||
        salmon?
    end

    def tuna?
      @line.include?('tuna')
    end

    def shrimp?
      @line.include?('shrimp') && @line.include?('fresh')
    end

    def barramundi?
      @line.include?('barramundi')
    end

    def fish_steak?
      @line.any? { |word| word.include?('fish') } && @line.include?('steak')
    end

    def canned_fish?
      @line.include?('bestanaku') && @line.include?('oil')
    end

    def canned_fish_2?
      @line.include?('sunview') && @line.include?('anchvy')
    end

    def salmon?
      @line.include?('salmon')
    end

    ####

    def sausage_and_sausages?
      bernardi? || el_primo? || ham? || kanzler? || smoke_leg? || salami? || salami_2?
    end

    def bernardi?
      @line.include?('bernardi')
    end

    def el_primo?
      @line.include?('el') && @line.include?('primo')
    end

    def ham?
      @line.include?('ham')
    end

    def kanzler?
      @line.include?('kanzler')
    end

    def smoke_leg?
      @line.any? { |word| word.include?('smoke') } && @line.any? { |word| word.include?('leg') }
    end

    def salami?
      @line.any? { |word| word.include?('mamas') } && (@line.any? { |word| word.include?('salam') } || @line.any? { |word| word.include?('slm') })
    end

    def salami_2?
      @line.any? { |word| word.include?('salami') } && @line.any? { |word| word.include?('italia') }
    end

    ####

    def for_beer?
      pistachios? || thins? || sunflower_seeds? || pringles? || cashewnuts? || some_seeds? ||
        crisps? || like_crisps?
    end

    def pistachios?
      @line.include?('sunkist') && @line.any? { |word| word.include?('rst') }
    end

    def thins?
      @line.include?('thins')
    end

    def sunflower_seeds?
      @line.include?('snflwrs') && @line.any? { |word| word.include?('seed') }
    end

    def pringles?
      @line.include?('pringles')
    end

    def cashewnuts?
      @line.include?('cashewnuts')
    end

    def some_seeds?
      @line.include?('rebo') && @line.include?('kuaci')
    end

    def crisps?
      @line.include?('lorenz') && @line.include?('barbecue')
    end

    def like_crisps?
      @line.include?('finna') && @line.include?('pars') && @line.any? { |word| word.include?('barbeq') }
    end

    ####

    def grocery?
      barilla? || rice? || spaghetti? || oat? || cous_cous? || cereals? || cereals_2?
    end

    def barilla?
      @line.include?('barilla')
    end

    def rice?
      @line.include?('rice')
    end

    def spaghetti?
      @line.include?('spaghetti')
    end

    def oat?
      @line.include?('oat')
    end

    def cous_cous?
      @line.any? { |word| word.include?('couscous') }
    end

    def cereals?
      @line.include?('kelloggs') && @line.include?('frt')
    end

    def cereals_2?
      @line.include?('nstl') && @line.include?('hnystr')
    end

    ####

    def kitchen_stuff?
      tissue? || kitchen_ware? || sponge? || wet_wipes? || bio?
    end

    def tissue?
      @line.include?('paseo')
    end

    def kitchen_ware?
      @line.include?('kitchen') && @line.include?('ware')
    end

    def sponge?
      @line.include?('bagus') && @line.include?('bilas')
    end

    def wet_wipes?
      @line.include?('mitu') && (@line.include?('blue') || @line.include?('white'))
    end

    def bio?
      @line.any? { |word| word.include?('bio') } && @line.include?('jrk')
    end

    ####

    def food_bag_or_delivery?
      bag? || bag_2?
    end

    def bag?
      @line.include?('linds') && @line.include?('tas') && @line.include?('kain')
    end

    def bag_2?
      @line.include?('shopping') && @line.include?('frestive')
    end

    ####

    def bath_stuff?
      toilet_paper? || crystal? || oralb? || for_clothes? || colgate?
    end

    def toilet_paper?
      @line.include?('bagus') && @line.include?('klap')
    end

    def crystal?
      @line.any? { |word| word.include?('crystal') } && @line.include?('proclin')
    end

    def oralb?
      @line.include?('oralb')
    end

    def for_clothes?
      @line.include?('kispray') && @line.include?('gold')
    end

    def colgate?
      @line.include?('colgt') && @line.include?('optic')
    end

    ####

    def pampers?
      @line.include?('makuku') && @line.include?('slim')
    end

    ####

    def home_stuff?
      coal? || antiseptic? || for_ants? || humidity_gathering?
    end

    def coal?
      @line.include?('wood') && @line.include?('charcoal')
    end

    def antiseptic?
      @line.include?('antis') && @line.include?('hs') && @line.include?('jrk')
    end

    def for_ants?
      @line.include?('hit') && @line.include?('jpn') && @line.include?('sakura')
    end

    def humidity_gathering?
      @line.include?('bagus') && ((@line.include?('serap') || @line.include?('air')) || @line.include?('reffil'))
    end

    ####

    def liliia_bath_stuff?
      laurier?
    end

    def laurier?
      @line.include?('laurier')
    end

    ###

    def ready_to_cook?
      french_fries?
    end

    def french_fries?
      @line.include?('golden') && @line.include?('fram')
    end

    ###

    def pharmacy?
      strepsils?
    end

    def strepsils?
      @line.include?('strepsil')
    end
  end
end
