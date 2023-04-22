module DetectCategoryAndSubcategoryFromLine
  class PepitoShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine? || wine_2?
    end

    def beer?
      bintang_beer? || bali_hai_beer?
    end

    def bintang_beer?
      @line.any? { |word| word.include?('bintang') } && @line.any? { |word| word.include?('crystal') }
    end

    def bali_hai_beer?
      @line.any? { |word| word.include?('bali') } && @line.any? { |word| word.include?('hai') }
    end

    def wine?
      @line.any? { |word| word.include?('hatten') } || @line.any? { |word| word.include?('plaga') }
    end

    def wine_2?
      @line.any? { |word| word.include?('isola') } || @line.any? { |word| word.include?('bianco') }
    end

    ####

    def eggs?
      @line.any? { |word| word.include?('telur') }
    end

    ####

    def water?
      green_tea? || cherry_juice? || cola? || fruit_juice? || andros_juice? || happy_day_juice? ||
        berri_juice? || bottle_of_water? || mineral_water? || aqua_click? || coconut_drink? ||
        mango_juice? || snake_fruit?
    end

    def green_tea?
      @line.any? { |word| word.include?('green') } && @line.any? { |word| word.include?('tea') } && @line.any? { |word| word.include?('original') }
    end

    def cherry_juice?
      @line.any? { |word| word.include?('clasic') } && @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('chery') }
    end

    def cola?
      @line.any? { |word| word.include?('coca') } && @line.any? { |word| word.include?('cola') }
    end

    def fruit_juice?
      @line.any? { |word| word.include?('fruit') } && @line.any? { |word| word.include?('juice') }
    end

    def andros_juice?
      @line.any? { |word| word.include?('andros') }
    end

    def happy_day_juice?
      @line.any? { |word| word.include?('happy') } && @line.any? { |word| word.include?('day') }
    end

    def berri_juice?
      @line.any? { |word| word.include?('berri') } && @line.any? { |word| word.include?('juice') }
    end

    def bottle_of_water?
      (@line.any? { |word| word.include?('aqua') } && @line.any? { |word| word.include?('btl') }) || (@line.any? { |word| word.include?('crystalline') } && @line.any? { |word| word.include?('pet') })
    end

    def mineral_water?
      @line.any? { |word| word.include?('mineral') } && @line.any? { |word| word.include?('water') }
    end

    def aqua_click?
      @line.any? { |word| word.include?('aqua') } && @line.any? { |word| word.include?('click') }
    end

    def coconut_drink?
      @line.any? { |word| word.include?('bianka') } && @line.any? { |word| word.include?('coconut') }
    end

    def mango_juice?
      @line.any? { |word| word.include?('mango') } && @line.any? { |word| word.include?('jungle') }
    end

    def snake_fruit?
      @line.any? { |word| word.include?('salak') } && @line.any? { |word| word.include?('bali') }
    end

    ####

    def spices_and_seasonings?
      kikko_soy_souce? || mayonaise? || soy_souce? || french_mustard? || vinegar? || sugar? ||
        oil? || sugar_2? || tomat_for_borsch? || soda? || rosemary? || sunflower_oil? ||
        sunflower_oil_2? || garlic_powder? || yellow_mustard? || sunflower_oil_3?
    end

    def kikko_soy_souce?
      @line.any? { |word| word.include?('kikko') } && @line.any? { |word| word.include?('asin') }
    end

    def mayonaise?
      @line.any? { |word| word.include?('mayonais') }
    end

    def soy_souce?
      @line.any? { |word| word.include?('soy') } && (@line.any? { |word| word.include?('sauce') } || @line.any? { |word| word.include?('premium') })
    end

    def french_mustard?
      @line.any? { |word| word.include?('french') } && @line.any? { |word| word.include?('mustard') }
    end

    def vinegar?
      @line.any? { |word| word.include?('heinz') } && @line.any? { |word| word.include?('white') }
    end

    def sugar?
      @line.any? { |word| word.include?('gula') } && @line.any? { |word| word.include?('putih') }
    end

    def oil?
      @line.any? { |word| word.include?('ext') } && @line.any? { |word| word.include?('virgin') }
    end

    def sugar_2?
      @line.any? { |word| word.include?('segitiga') } && @line.any? { |word| word.include?('biru') }
    end

    def tomat_for_borsch?
      @line.any? { |word| word.include?('cirio') } && @line.any? { |word| word.include?('tomat') }
    end

    def soda?
      @line.any? { |word| word.include?('soda') }
    end

    def rosemary?
      @line.any? { |word| word.include?('nat') } && @line.any? { |word| word.include?('rosemry') }
    end

    def sunflower_oil?
      @line.any? { |word| word.include?('sunflower') } && @line.any? { |word| word.include?('borges') }
    end

    def sunflower_oil_2?
      @line.any? { |word| word.include?('mazola') } && @line.any? { |word| word.include?('sunflwr') } && @line.any? { |word| word.include?('oil') }
    end

    def sunflower_oil_3?
      @line.any? { |word| word.include?('sunflow') } && @line.any? { |word| word.include?('gold') }
    end

    def garlic_powder?
      @line.any? { |word| word.include?('garlic') } && @line.any? { |word| word.include?('powder') }
    end

    def yellow_mustard?
      @line.any? { |word| word.include?('yellow') } && @line.any? { |word| word.include?('mustard') }
    end

    ####

    def sweets?
      magnum_icecream? || oreo_cake? || lindt? || kit_kat? || oreo_biscuit? || milk_chocolate? ||
        like_m_and_ms? || kinder? || schogetten? || nutella? || zaini? || halls? || peachy? ||
        super_shrooms? || hello_kitty? || jelly? || honey? || cake? || bar_almond? ||
        bar_cashew? || chic_choc? || bar_bar? || m_and_m? || bruxel_chocolate? ||
        cadbury_lickabler? || marshmallow? || dilan? || ice_cream? || truffle_coconut? ||
        vanila? || bar_bar_2? || berry_bliss? || milka? || haribo? || lindt_2? || bears? ||
        cake_2? || belgian_chocolate? || ice_cream_paletas? || snickers? || twix? ||
        junglegold_coconut? || healthy_bar?
    end

    def magnum_icecream?
      @line.any? { |word| word.include?('magnum') }
    end

    def oreo_cake?
      @line.any? { |word| word.include?('oreo') } && @line.any? { |word| word.include?('cakes') }
    end

    def lindt?
      @line.any? { |word| word.include?('lindt') }
    end

    def kit_kat?
      (@line.any? { |word| word.include?('kit') } && @line.any? { |word| word.include?('kat') }) || @line.any? { |word| word.include?('kitkat') }
    end

    def oreo_biscuit?
      @line.any? { |word| word.include?('oreo') }
    end

    def milk_chocolate?
      @line.any? { |word| word.include?('milk') } && @line.any? { |word| word.include?('chocolate') }
    end

    def like_m_and_ms?
      @line.any? { |word| word.include?('chacha') }
    end

    def kinder?
      @line.any? { |word| word.include?('kinder') }
    end

    def schogetten?
      @line.any? { |word| word.include?('schogetten') }
    end

    def nutella?
      @line.any? { |word| word.include?('nutella') }
    end

    def halls?
      @line.any? { |word| word.include?('halls') }
    end

    def zaini?
      @line.any? { |word| word.include?('zaini') }
    end

    def peachy?
      @line.any? { |word| word.include?('peachy') }
    end

    def super_shrooms?
      @line.any? { |word| word.include?('supershrooms') }
    end

    def hello_kitty?
      @line.any? { |word| word.include?('hello') } && @line.any? { |word| word.include?('kitty') }
    end

    def jelly?
      @line.any? { |word| word.include?('jelly') } && @line.any? { |word| word.include?('berries') }
    end

    def honey?
      @line.any? { |word| word.include?('honey') }
    end

    def cake?
      @line.any? { |word| word.include?('cake') }
    end

    def bar_almond?
      @line.any? { |word| word.include?('bar') } && @line.any? { |word| word.include?('almond') }
    end

    def bar_cashew?
      @line.any? { |word| word.include?('bar') } && @line.any? { |word| word.include?('cashew') }
    end

    def chic_choc?
      @line.any? { |word| word.include?('chic') } && @line.any? { |word| word.include?('choc') }
    end

    def bar_bar?
      @line.any? { |word| word.include?('delfi') }
    end

    def m_and_m?
      @line.any? { |word| word.include?('m') } && @line.any? { |word| word.include?('&') } && @line.any? { |word| word.include?('peanut') }
    end

    def bruxel_chocolate?
      @line.any? { |word| word.include?('bruxel') } && @line.any? { |word| word.include?('chocolate') }
    end

    def cadbury_lickabler?
      @line.any? { |word| word.include?('cadbury') } && @line.any? { |word| word.include?('lickabler') }
    end

    def marshmallow?
      @line.any? { |word| word.include?('chomp') } && @line.any? { |word| word.include?('mrsmlw') }
    end

    def dilan?
      @line.any? { |word| word.include?('dilan') } && @line.any? { |word| word.include?('crnchy') }
    end

    def ice_cream?
      @line.any? { |word| word.include?('walls') } && (@line.any? { |word| word.include?('crnt') } || @line.any? { |word| word.include?('strw') })
    end

    def truffle_coconut?
      @line.any? { |word| word.include?('truffle') } && @line.any? { |word| word.include?('coconut') }
    end

    def vanila?
      @line.any? { |word| word.include?('gelato') } && @line.any? { |word| word.include?('vanilla') }
    end

    def bar_bar_2?
      @line.any? { |word| word.include?('bar') } && @line.any? { |word| word.include?('share') } && @line.any? { |word| word.include?('pack') }
    end

    def berry_bliss?
      @line.any? { |word| word.include?('berry') } && @line.any? { |word| word.include?('bliss') }
    end

    def milka?
      @line.any? { |word| word.include?('milka') }
    end

    def haribo?
      @line.any? { |word| word.include?('haribo') }
    end

    def lindt_2?
      @line.any? { |word| word.include?('lin') } && @line.any? { |word| word.include?('whole') }
    end

    def bears?
      @line.any? { |word| word.include?('bears') }
    end

    def cake_2?
      @line.any? { |word| word.include?('mini') } && @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('velvet') }
    end

    def belgian_chocolate?
      @line.any? { |word| word.include?('belgian') } && @line.any? { |word| word.include?('milk') } && @line.any? { |word| word.include?('hazel') }
    end

    def ice_cream_paletas?
      @line.any? { |word| word.include?('paletas') } && @line.any? { |word| word.include?('strawberry') }
    end

    def snickers?
      @line.any? { |word| word.include?('snickers') }
    end

    def twix?
      @line.any? { |word| word.include?('twix') } && @line.any? { |word| word.include?('crml') }
    end

    def junglegold_coconut?
      @line.any? { |word| word.include?('junglegold') } && @line.any? { |word| word.include?('coconut') }
    end

    def healthy_bar?
      @line.any? { |word| word.include?('healthy') } && @line.any? { |word| word.include?('bar') }
    end

    ####

    def tea_or_coffee?
      nescafe? || chococino? || day? || boncafe? || for_coffee_machine?
    end

    def nescafe?
      @line.any? { |word| word.include?('nescafe') }
    end

    def chococino?
      @line.any? { |word| word.include?('chococino') }
    end

    def day?
      @line.any? { |word| word.include?('day') } && (@line.any? { |word| word.include?('original') } || @line.any? { |word| word.include?('moca') })
    end

    def boncafe?
      @line.any? { |word| word.include?('boncafe') } && @line.any? { |word| word.include?('coffe') }
    end

    def for_coffee_machine?
      @line.any? { |word| word.include?('indonesso') }
    end

    ####

    def fruits?
      pineapple? || mango? || dragon_fruit? || watermelon? || banana? || grape? ||
        corn? || red_apple? || pear? || plum? || orange? || lemon? || blueberries? ||
        green_peas? || pepaya?
    end

    def pineapple?
      @line.any? { |word| word.include?('nanas') } && @line.any? { |word| word.include?('honi') }
    end

    def mango?
      @line.any? { |word| word.include?('mangga') }
    end

    def dragon_fruit?
      @line.any? { |word| word.include?('dragon') } && @line.any? { |word| word.include?('fruit') }
    end

    def watermelon?
      @line.any? { |word| word.include?('semangka') } && @line.any? { |word| word.include?('merah') }
    end

    def banana?
      @line.any? { |word| word.include?('unpride') } && @line.any? { |word| word.include?('pisang') }
    end

    def grape?
      @line.any? { |word| word.include?('green') } && @line.any? { |word| word.include?('grape') }
    end

    def corn?
      @line.any? { |word| word.include?('jagung') } && @line.any? { |word| word.include?('manis') }
    end

    def red_apple?
      @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('apel') }
    end

    def pear?
      @line.any? { |word| word.include?('pear') }
    end

    def plum?
      @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('plum') }
    end

    def orange?
      @line.any? { |word| word.include?('jeruk') } && @line.any? { |word| word.include?('murcot') }
    end

    def lemon?
      @line.any? { |word| word.include?('lemon') } && !@line.any? { |word| word.include?('soap') }
    end

    def blueberries?
      @line.any? { |word| word.include?('blueberries') }
    end

    def green_peas?
      @line.any? { |word| word.include?('green') } && @line.any? { |word| word.include?('peas') } && !@line.any? { |word| word.include?('canned') }
    end

    def pepaya?
      @line.any? { |word| word.include?('pepaya') } && @line.any? { |word| word.include?('calina') }
    end

    ####

    def vegetables?
      cucumber? || pepper? || tomato? || avocado? || brokoli? || potato? || canned_pepper? ||
        carrot? || kale? || onion? || herb? || tomat_cherry? || parsley? || daun_dill? ||
        tomat_gondol? || zuchini? || red_onion? || beans? || radish? || rucola? ||
        beetroot? || cabbage? || solt_cucumber? || canned_peas? || bond_peas? ||
        mushroom? || chinese_cabbage? || baby_cucumber? || cabbage_2? || asparagus? ||
        kailan?
    end

    def cucumber?
      @line.any? { |word| word.include?('kyuri') }
    end

    def pepper?
      @line.any? { |word| word.include?('paprika') }
    end

    def tomato?
      @line.any? { |word| word.include?('beef') } && @line.any? { |word| word.include?('tomato') }
    end

    def avocado?
      @line.any? { |word| word.include?('alpukat') }
    end

    def brokoli?
      @line.any? { |word| word.include?('brokoli') }
    end

    def potato?
      @line.any? { |word| word.include?('kentang') } && @line.any? { |word| word.include?('besar') }
    end

    def canned_pepper?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('pepper') } && @line.any? { |word| word.include?('roast') }
    end

    def carrot?
      @line.any? { |word| word.include?('wortel') } && @line.any? { |word| word.include?('medan') }
    end

    def kale?
      @line.any? { |word| word.include?('kale') }
    end

    def onion?
      @line.any? { |word| word.include?('bawang') }
    end

    def red_onion?
      @line.any? { |word| word.include?('onion') } && @line.any? { |word| word.include?('red') }
    end

    def herb?
      @line.any? { |word| word.include?('herb') } && @line.any? { |word| word.include?('dill') }
    end

    def tomat_cherry?
      @line.any? { |word| word.include?('tomat') } && @line.any? { |word| word.include?('cher') }
    end

    def parsley?
      @line.any? { |word| word.include?('parsley') }
    end

    def daun_dill?
      @line.any? { |word| word.include?('daun') } && @line.any? { |word| word.include?('diil') }
    end

    def tomat_gondol?
      @line.any? { |word| word.include?('tomat') } && @line.any? { |word| word.include?('gondol') }
    end

    def zuchini?
      @line.any? { |word| word.include?('zuchini') }
    end

    def beans?
      @line.any? { |word| word.include?('buncis') }
    end

    def radish?
      @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('radish') }
    end

    def rucola?
      @line.any? { |word| word.include?('rucola') } || @line.any? { |word| word.include?('rucolla') } || @line.any? { |word| word.include?('rocola') }
    end

    def beetroot?
      @line.any? { |word| word.include?('beetroot') }
    end

    def cabbage?
      @line.any? { |word| word.include?('putih') } && @line.any? { |word| word.include?('bulat') }
    end

    def solt_cucumber?
      @line.any? { |word| word.include?('baby') } && @line.any? { |word| word.include?('dill') }
    end

    def canned_peas?
      @line.any? { |word| word.include?('canned') } && @line.any? { |word| word.include?('peas') }
    end

    def bond_peas?
      @line.any? { |word| word.include?('bond') } && @line.any? { |word| word.include?('peas') }
    end

    def mushroom?
      @line.any? { |word| word.include?('mushroom') }
    end

    def chinese_cabbage?
      @line.any? { |word| word.include?('sawi') } && @line.any? { |word| word.include?('putih') }
    end

    def baby_cucumber?
      @line.any? { |word| word.include?('baby') } && @line.any? { |word| word.include?('gherkin') }
    end

    def cabbage_2?
      @line.any? { |word| word.include?('romana') } && @line.any? { |word| word.include?('lettuce') }
    end

    def asparagus?
      @line.any? { |word| word.include?('asparagus') }
    end

    def kailan?
      @line.any? { |word| word.include?('kailan') }
    end

    ####

    def dairy?
      milk? || greenfields_milk? || kin_milk? || greenfields_yog? || biokul_yog? || kin_yog? ||
        delicyo_yog? || cimory_yog? || j_j_cheese? || laughing_cow_cheese? || ricotta_cheese? ||
        cheddar? || sour_cream? || mini_cheese? || anchor_dairy? || bocconcini? || mozzarela? ||
        yogurt? || sour_cream_2? || greenfields_cheese? || president_cheese? || cheese_2? ||
        greenfields_milk_2? || bega_cheese? || butter_cheese? || greek_fetta? || cream_cheese?
    end

    def milk?
      @line.any? { |word| word.include?('milk') } && @line.any? { |word| word.include?('life') }
    end

    def greenfields_milk?
      @line.any? { |word| word.include?('greenfield') } && @line.any? { |word| word.include?('milk') }
    end

    def kin_milk?
      @line.any? { |word| word.include?('kin') } && @line.any? { |word| word.include?('freshmilk') }
    end

    def greenfields_yog?
      @line.any? { |word| word.include?('greenfields') } && @line.any? { |word| word.include?('yog') }
    end

    def biokul_yog?
      @line.any? { |word| word.include?('iokul') } && @line.any? { |word| word.include?('yog') }
    end

    def kin_yog?
      @line.any? { |word| word.include?('kin') } && @line.any? { |word| word.include?('yog') }
    end

    def delicyo_yog?
      @line.any? { |word| word.include?('del') } && @line.any? { |word| word.include?('icyo') } && @line.any? { |word| word.include?('yog') }
    end

    def cimory_yog?
      @line.any? { |word| word.include?('cimory') } && @line.any? { |word| word.include?('squeeze') }
    end

    def j_j_cheese?
      @line.any? { |word| word.include?('j') } && @line.any? { |word| word.include?('&') } && @line.any? { |word| word.include?('cott') }
    end

    def laughing_cow_cheese?
      @line.any? { |word| word.include?('laughing') } && @line.any? { |word| word.include?('co') }
    end

    def ricotta_cheese?
      @line.any? { |word| word.include?('ricotta') }
    end

    def cheddar?
      @line.any? { |word| word.include?('cheddar') }
    end

    def sour_cream?
      @line.any? { |word| word.include?('yummy') } && @line.any? { |word| word.include?('cream') }
    end

    def mini_cheese?
      @line.any? { |word| word.include?('mini') } && @line.any? { |word| word.include?('cheese') }
    end

    def anchor_dairy?
      @line.any? { |word| word.include?('anchor') }
    end

    def bocconcini?
      @line.any? { |word| word.include?('bocconcini') } && @line.any? { |word| word.include?('fresh') }
    end

    def mozzarela?
      @line.any? { |word| word.include?('mozzarella') }
    end

    def yogurt?
      @line.any? { |word| word.include?('plain') } && (@line.any? { |word| word.include?('yogurt') } || @line.any? { |word| word.include?('yog') })
    end

    def sour_cream_2?
      @line.any? { |word| word.include?('milk') } && @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('cream') }
    end

    def greenfields_cheese?
      @line.any? { |word| word.include?('greenfields') } && @line.any? { |word| word.include?('bocconcini') }
    end

    def president_cheese?
      @line.any? { |word| word.include?('president') } && @line.any? { |word| word.include?('gouda') } && @line.any? { |word| word.include?('tasty') }
    end

    def cheese_2?
      @line.any? { |word| word.include?('rossa') } && @line.any? { |word| word.include?('renkol') }
    end

    def greenfields_milk_2?
      @line.any? { |word| word.include?('greenfield') } && @line.any? { |word| word.include?('fullcream') }
    end

    def bega_cheese?
      @line.any? { |word| word.include?('bega') } && @line.any? { |word| word.include?('super') } && @line.any? { |word| word.include?('slice') }
    end

    def butter_cheese?
      @line.any? { |word| word.include?('butter') } && @line.any? { |word| word.include?('cheese') }
    end

    def greek_fetta?
      @line.any? { |word| word.include?('greek') } && @line.any? { |word| word.include?('fetta') }
    end

    def cream_cheese?
      @line.any? { |word| word.include?('cream') } && @line.any? { |word| word.include?('cheese') }
    end

    ####

    def bread?
      donut? || bread_sticks? || toast? || wrap? || yeast? || waffels? || flour? ||
        batard? || just_bread? || sourdough? || flour_2? || bun? || donut_chocolate? ||
        croissant? || cinamon?
    end

    def donut?
      @line.any? { |word| word.include?('onut') } && (@line.any? { |word| word.include?('sprinkle') } || @line.any? { |word| word.include?('tripple') } || @line.any? { |word| word.include?('icing') })
    end

    def bread_sticks?
      @line.any? { |word| word.include?('grissini') } && @line.any? { |word| word.include?('gluten') }
    end

    def toast?
      @line.any? { |word| word.include?('toast') }
    end

    def wrap?
      @line.any? { |word| word.include?('rositas') } && @line.any? { |word| word.include?('borrito') }
    end

    def yeast?
      @line.any? { |word| word.include?('fermipan') }
    end

    def waffels?
      @line.any? { |word| word.include?('bruxel') } && @line.any? { |word| word.include?('original') }
    end

    def flour?
      @line.any? { |word| word.include?('kunci') } && @line.any? { |word| word.include?('br') }
    end

    def batard?
      @line.any? { |word| word.include?('batard') } && @line.any? { |word| word.include?('bread') }
    end

    def just_bread?
      @line.any? { |word| word.include?('bread') }
    end

    def sourdough?
      @line.any? { |word| word.include?('sour') } && @line.any? { |word| word.include?('dough') }
    end

    def flour_2?
      @line.any? { |word| word.include?('cakra') } && @line.any? { |word| word.include?('terigu') }
    end

    def bun?
      @line.any? { |word| word.include?('roti') } && @line.any? { |word| word.include?('sobek') }
    end

    def donut_chocolate?
      @line.any? { |word| word.include?('donut') } && @line.any? { |word| word.include?('chocolate') }
    end

    def croissant?
      @line.any? { |word| word.include?('croissant') }
    end

    def cinamon?
      @line.any? { |word| word.include?('cinamon') } && @line.any? { |word| word.include?('roll') }
    end

    ####

    def meat?
      chicken_breast? || chicken? || pork? || beef? || pork_2?
    end

    def chicken_breast?
      @line.any? { |word| word.include?('chic') } && @line.any? { |word| word.include?('breast') }
    end

    def chicken?
      @line.any? { |word| word.include?('chicken') }
    end

    def pork?
      @line.any? { |word| word.include?('pork') } && @line.any? { |word| word.include?('fillet') }
    end

    def beef?
      @line.any? { |word| word.include?('prime') } && @line.any? { |word| word.include?('beef') }
    end

    def pork_2?
      @line.any? { |word| word.include?('pork') } && @line.any? { |word| word.include?('roast') }
    end

    ####

    def fish?
      marlin? || gravad? || mahi? || tuna? || salmon?
    end

    def marlin?
      @line.any? { |word| word.include?('marlin') } && @line.any? { |word| word.include?('steak') }
    end

    def gravad?
      @line.any? { |word| word.include?('gravad') } && @line.any? { |word| word.include?('lax') }
    end

    def mahi?
      @line.any? { |word| word.include?('mahi') } && @line.any? { |word| word.include?('fillet') }
    end

    def tuna?
      @line.any? { |word| word.include?('tuna') }
    end

    def salmon?
      @line.any? { |word| word.include?('salmon') }
    end

    ####

    def sausage_and_sausages?
      mamas_ham? || mamas_pork? || sausages? || cooked_ham? || bacon? || smith_field_ham? ||
        mamas_salami? || triple_ham? || bernardi_beef? || nurnberg? || smoke_ham? ||
        mamas_sausage? || sausage? || bratwurst? || breakfast_ham? || danish_ham? ||
        nice_sausage? || aroma_pork? || turkey_sausages?
    end

    def mamas_ham?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('ham') }
    end

    def mamas_pork?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('pork') }
    end

    def sausages?
      @line.any? { |word| word.include?('kanzler') } && (@line.any? { |word| word.include?('original') } || @line.any? { |word| word.include?('singles') })
    end

    def cooked_ham?
      @line.any? { |word| word.include?('ooked') } && @line.any? { |word| word.include?('ham') }
    end

    def bacon?
      @line.any? { |word| word.include?('bacon') }
    end

    def smith_field_ham?
      @line.any? { |word| word.include?('smithfield') } && @line.any? { |word| word.include?('ham') }
    end

    def mamas_salami?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('salami') }
    end

    def triple_ham?
      @line.any? { |word| word.include?('fores') } && @line.any? { |word| word.include?('triple') } && @line.any? { |word| word.include?('black') }
    end

    def bernardi_beef?
      @line.any? { |word| word.include?('bernardi') } && @line.any? { |word| word.include?('beef') }
    end

    def nurnberg?
      @line.any? { |word| word.include?('nuernbrgr') }
    end

    def smoke_ham?
      @line.any? { |word| word.include?('smoke') } && @line.any? { |word| word.include?('ham') }
    end

    def mamas_sausage?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('kalberwurst') }
    end

    def sausage?
      @line.any? { |word| word.include?('sausage') }
    end

    def bratwurst?
      @line.any? { |word| word.include?('garlic') } && @line.any? { |word| word.include?('bratwurs') }
    end

    def breakfast_ham?
      @line.any? { |word| word.include?('breakfast') } && @line.any? { |word| word.include?('ham') }
    end

    def danish_ham?
      @line.any? { |word| word.include?('danish') } && @line.any? { |word| word.include?('ham') }
    end

    def nice_sausage?
      @line.any? { |word| word.include?('nice') } && @line.any? { |word| word.include?('sosis') }
    end

    def aroma_pork?
      @line.any? { |word| word.include?('aroma') } && @line.any? { |word| word.include?('pork') }
    end

    def turkey_sausages?
      @line.any? { |word| word.include?('turkey') } && @line.any? { |word| word.include?('smoked') }
    end

    ####

    def for_beer?
      lays? || pistachios? || pringles? || thins_chips? || corn_sticks? || crisps? ||
        lorenz? || loren? || chitato? || cashew?
    end

    def lays?
      @line.any? { |word| word.include?('lays') } || (@line.any? { |word| word.include?('lay') } && @line.any? { |word| word.include?('chips') })
    end

    def pistachios?
      @line.any? { |word| word.include?('pistachios') } || @line.any? { |word| word.include?('pischio') } || @line.any? { |word| word.include?('pistacio') }
    end

    def pringles?
      @line.any? { |word| word.include?('pringles') }
    end

    def thins_chips?
      @line.any? { |word| word.include?('thins') }
    end

    def corn_sticks?
      @line.any? { |word| word.include?('cheeto') } && @line.any? { |word| word.include?('puffs') }
    end

    def crisps?
      @line.any? { |word| word.include?('lrz') } && @line.any? { |word| word.include?('nat') } && @line.any? { |word| word.include?('classic') }
    end

    def lorenz?
      @line.any? { |word| word.include?('lorenz') } && @line.any? { |word| word.include?('parmesan') }
    end

    def loren?
      @line.any? { |word| word.include?('loren') } && @line.any? { |word| word.include?('brez') }
    end

    def chitato?
      @line.any? { |word| word.include?('chitato') } && @line.any? { |word| word.include?('beef') }
    end

    def cashew?
      @line.any? { |word| word.include?('yava') } && @line.any? { |word| word.include?('sea') } && @line.any? { |word| word.include?('salt') }
    end

    ####

    def grocery?
      rice? || barilla? || oats? || peas? || vermicelli? || some_porridge? ||
        rice_noodle? || oats_2? || red_lentils? || conhiglie? || farfalle? ||
        granola? || cous_cous?
    end

    def rice?
      @line.any? { |word| word.include?('basmati') } && @line.any? { |word| word.include?('rice') }
    end

    def barilla?
      @line.any? { |word| word.include?('barilla') }
    end

    def oats?
      @line.any? { |word| word.include?('australia') } && @line.any? { |word| word.include?('harvest') }
    end

    def peas?
      @line.any? { |word| word.include?('mckenzies') } && @line.any? { |word| word.include?('yellow') }
    end

    def vermicelli?
      @line.any? { |word| word.include?('rice') } && @line.any? { |word| word.include?('vermicelli') }
    end

    def some_porridge?
      @line.any? { |word| word.include?('organico') } && @line.any? { |word| word.include?('quinoa') }
    end

    def rice_noodle?
      @line.any? { |word| word.include?('rice') } && @line.any? { |word| word.include?('noodle') }
    end

    def oats_2?
      @line.any? { |word| word.include?('oats') } && @line.any? { |word| word.include?('quick') } && @line.any? { |word| word.include?('cooking') }
    end

    def red_lentils?
      @line.any? { |word| word.include?('red') } && @line.any? { |word| word.include?('lentils') }
    end

    def conhiglie?
      @line.any? { |word| word.include?('conhiglie') } && @line.any? { |word| word.include?('rigate') }
    end

    def farfalle?
      @line.any? { |word| word.include?('farfalle') }
    end

    def granola?
      @line.any? { |word| word.include?('yava') } && @line.any? { |word| word.include?('granola') }
    end

    def cous_cous?
      grouped_words_by_count = @line.tally
      grouped_words_by_count['cous'] == 2
    end

    ####

    def kitchen_stuff?
      paseo? || some_stuff? || sponge? || montis? || soap? || handsoap? || another_soap? ||
        dove? || to_wash_plates?
    end

    def paseo?
      @line.any? { |word| word.include?('paseo') }
    end

    def some_stuff?
      @line.any? { |word| word.include?('youth') } && @line.any? { |word| word.include?('kitchen') }
    end

    def sponge?
      @line.any? { |word| word.include?('polytex') } && @line.any? { |word| word.include?('spo') }
    end

    def montis?
      @line.any? { |word| word.include?('montiss') } && @line.any? { |word| word.include?('tissu') }
    end

    def soap?
      @line.any? { |word| word.include?('sunlight') } && @line.any? { |word| word.include?('korean') }
    end

    def handsoap?
      @line.any? { |word| word.include?('dettol') }
    end

    def another_soap?
      @line.any? { |word| word.include?('lifebuoy') } && @line.any? { |word| word.include?('soap') }
    end

    def dove?
      @line.any? { |word| word.include?('dove') }
    end

    def to_wash_plates?
      @line.any? { |word| word.include?('sunlight') } && @line.any? { |word| word.include?('mint') }
    end

    ####

    def food_bag_or_delivery?
      bag?
    end

    def bag?
      @line.any? { |word| word.include?('pepito') } && @line.any? { |word| word.include?('bag') } && !@line.any? { |word| word.include?('bagus') }
    end

    ####

    def bath_stuff?
      clear_gel? || colgate? || local_vanish? || vanish? || luquid_soap? || colgate_2? ||
        kids_toothpaste? || floss? || local_vanish_2? || luquid_soap_2? || tooth_brush? ||
        shampoo? || shampoo_2? || to_clean_smth? || sensodyne? || vitamin_for_hair?
    end

    def clear_gel?
      @line.any? { |word| word.include?('clear') } && @line.any? { |word| word.include?('active') }
    end

    def colgate?
      @line.any? { |word| word.include?('colgate') }
    end

    def local_vanish?
      @line.any? { |word| word.include?('proclin') }
    end

    def vanish?
      @line.any? { |word| word.include?('vanish') }
    end

    def luquid_soap?
      @line.any? { |word| word.include?('j') } && @line.any? { |word| word.include?('&') } && @line.any? { |word| word.include?('bath') }
    end

    def colgate_2?
      @line.any? { |word| word.include?('colg') } && @line.any? { |word| word.include?('whitenning') }
    end

    def kids_toothpaste?
      @line.any? { |word| word.include?('kids') } && @line.any? { |word| word.include?('toothpaste') }
    end

    def floss?
      @line.any? { |word| word.include?('dental') } && @line.any? { |word| word.include?('floss') }
    end

    def local_vanish_2?
      @line.any? { |word| word.include?('proc') } && @line.any? { |word| word.include?('wht') } && @line.any? { |word| word.include?('crti') }
    end

    def luquid_soap_2?
      @line.any? { |word| word.include?('j') } && @line.any? { |word| word.include?('&') } && @line.any? { |word| word.include?('wash') }
    end

    def tooth_brush?
      @line.any? { |word| word.include?('tbrush') } && @line.any? { |word| word.include?('sanrio') }
    end

    def shampoo?
      @line.any? { |word| word.include?('shampoo') } && @line.any? { |word| word.include?('ginseng') }
    end

    def shampoo_2?
      @line.any? { |word| word.include?('tea') } && @line.any? { |word| word.include?('tree') } && @line.any? { |word| word.include?('oil') }
    end

    def to_clean_smth?
      @line.any? { |word| word.include?('bayclin') } && @line.any? { |word| word.include?('regular') }
    end

    def sensodyne?
      @line.any? { |word| word.include?('sensodyne') }
    end

    def vitamin_for_hair?
      @line.any? { |word| word.include?('ellips') } && @line.any? { |word| word.include?('nutri') } && @line.any? { |word| word.include?('blister') }
    end

    ####

    def home_stuff?
      bataries? || baby_wipes? || another_baby_wipes? || energizer? || baterai? ||
        some_spray? || wet_wipes? || raincoat? || glue? || humidity_gathering?
    end

    def bataries?
      @line.any? { |word| word.include?('panasonic') } && @line.any? { |word| word.include?('alk') }
    end

    def baby_wipes?
      @line.any? { |word| word.include?('baby') } && @line.any? { |word| word.include?('wipes') }
    end

    def another_baby_wipes?
      @line.any? { |word| word.include?('etkins') } && @line.any? { |word| word.include?('clean') }
    end

    def energizer?
      @line.any? { |word| word.include?('energizer') }
    end

    def baterai?
      @line.any? { |word| word.include?('baterai') } && @line.any? { |word| word.include?('biru') }
    end

    def some_spray?
      @line.any? { |word| word.include?('phrn') } && @line.any? { |word| word.include?('merah') }
    end

    def wet_wipes?
      @line.any? { |word| word.include?('neppi') } && @line.any? { |word| word.include?('baby') } && !@line.any? { |word| word.include?('diaper') }
    end

    def raincoat?
      @line.any? { |word| word.include?('hujan') } && @line.any? { |word| word.include?('ponco') }
    end

    def glue?
      @line.any? { |word| word.include?('castol') } && @line.any? { |word| word.include?('besar') }
    end

    def humidity_gathering?
      @line.any? { |word| word.include?('bagus') } && ((@line.any? { |word| word.include?('serap') } && @line.any? { |word| word.include?('air') }) || @line.any? { |word| word.include?('reffil') })
    end

    ####

    def pampers?
      sweety? || merries? || diaper_baby?
    end

    def sweety?
      @line.any? { |word| word.include?('sweety') } && @line.any? { |word| word.include?('pant') }
    end

    def merries?
      @line.any? { |word| word.include?('merries') } && @line.any? { |word| word.include?('good') }
    end

    def diaper_baby?
      @line.any? { |word| word.include?('diaper') } && @line.any? { |word| word.include?('baby') }
    end

    ####

    def ready_to_cook?
      @line.any? { |word| word.include?('sora') } && @line.any? { |word| word.include?('mozzarela') }
    end

    ####

    def mark_toys?
      bubbles?
    end

    def bubbles?
      @line.any? { |word| word.include?('yasuka') }
    end

    ####

    def liliia_bath_stuff?
      carefree_fresh? || laurier?
    end

    def carefree_fresh?
      @line.any? { |word| word.include?('carefree') } && @line.any? { |word| word.include?('fresh') }
    end

    def laurier?
      @line.any? { |word| word.include?('laurier') }
    end

    ####

    def liliia_clothes?
      for_hair?
    end

    def for_hair?
      @line.any? { |word| word.include?('jepit') } && @line.any? { |word| word.include?('rambut') }
    end

    ####

    def mykola_bath_stuff?
      foam?
    end

    def foam?
      @line.any? { |word| word.include?('gillete') }
    end
  end
end
