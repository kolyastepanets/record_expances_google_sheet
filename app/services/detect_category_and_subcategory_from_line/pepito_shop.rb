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
      @line.any? { |word| word.include?('bintang') }
    end

    def bali_hai_beer?
      @line.include?('bali') && @line.include?('hai')
    end

    def wine?
      @line.include?('hatten') || @line.include?('plaga')
    end

    def wine_2?
      @line.include?('isola') || @line.include?('bianco')
    end

    ####

    def eggs?
      eggs_1? || eggs_2?
    end

    def eggs_1?
      @line.include?('telur')
    end

    def eggs_2?
      @line.include?('ayam') && @line.include?('negeri') && @line.include?('orange')
    end

    ####

    def water?
      green_tea? || cherry_juice? || cola? || fruit_juice? || andros_juice? || happy_day_juice? ||
        berri_juice? || bottle_of_water? || mineral_water? || aqua_click? || coconut_drink? ||
        mango_juice? || snake_fruit? || apple_juice? || coconut_drink_2? || ice? ||
        kombucha? || diamond_juice? || soda_water? || pepsi_cola? || pomegranate_juice?
    end

    def green_tea?
      @line.include?('green') && @line.include?('tea') && @line.include?('original')
    end

    def cherry_juice?
      @line.include?('clasic') && @line.include?('sour') && @line.include?('chery')
    end

    def cola?
      @line.include?('coca') && @line.include?('cola')
    end

    def fruit_juice?
      @line.include?('fruit') && @line.include?('juice')
    end

    def andros_juice?
      @line.any? { |word| word.include?('andros') }
    end

    def happy_day_juice?
      @line.include?('happy') && @line.include?('day')
    end

    def berri_juice?
      @line.include?('berri') && @line.include?('juice')
    end

    def bottle_of_water?
      (@line.include?('aqua') && @line.include?('btl')) || (@line.include?('crystalline') && @line.include?('pet'))
    end

    def mineral_water?
      @line.include?('mineral') && @line.include?('water')
    end

    def aqua_click?
      @line.include?('aqua') && @line.include?('click')
    end

    def coconut_drink?
      @line.include?('bianka') && @line.include?('coconut')
    end

    def mango_juice?
      @line.include?('mango') && @line.any? { |word| word.include?('jungle') }
    end

    def snake_fruit?
      @line.any? { |word| word.include?('salak') } && @line.include?('bali')
    end

    def apple_juice?
      @line.include?('juice') && (@line.include?('apl') || @line.include?('apple'))
    end

    def coconut_drink_2?
      @line.include?('hydro') && @line.include?('coco')
    end

    def ice?
      @line.include?('ice') && @line.include?('cube')
    end

    def kombucha?
      @line.include?('kombucha')
    end

    def diamond_juice?
      @line.include?('diamond') && @line.include?('juice')
    end

    def soda_water?
      @line.include?('soda') && @line.include?('water')
    end

    def pepsi_cola?
      @line.include?('pepsi') && @line.include?('cola')
    end

    def pomegranate_juice?
      @line.include?('pome') && @line.include?('nectar') && @line.any? { |word| word.include?('lt') }
    end

    ####

    def spices_and_seasonings?
      kikko_soy_souce? || mayonaise? || soy_souce? || french_mustard? || vinegar? || sugar? ||
        oil? || sugar_2? || tomat_for_borsch? || soda? || rosemary? || sunflower_oil? ||
        sunflower_oil_2? || garlic_powder? || yellow_mustard? || sunflower_oil_3? || salt? ||
        baking_powder? || black_pepper? || jay_leaves? || sugar_3? || cocoa? || sugar_powder?
    end

    def kikko_soy_souce?
      @line.include?('kikko') && @line.include?('asin')
    end

    def mayonaise?
      @line.any? { |word| word.include?('mayonais') }
    end

    def soy_souce?
      @line.include?('soy') && (@line.include?('sauce') || @line.include?('premium'))
    end

    def french_mustard?
      @line.include?('french') && @line.include?('mustard')
    end

    def vinegar?
      @line.include?('heinz') && @line.include?('white')
    end

    def sugar?
      @line.include?('gula') && @line.include?('putih')
    end

    def oil?
      @line.any? { |word| word.include?('ext') } && @line.include?('virgin')
    end

    def sugar_2?
      @line.include?('segitiga') && @line.include?('biru')
    end

    def tomat_for_borsch?
      @line.include?('cirio') && @line.include?('tomat')
    end

    def soda?
      @line.include?('soda') && !@line.include?('water')
    end

    def rosemary?
      @line.include?('nat') && @line.include?('rosemry')
    end

    def sunflower_oil?
      @line.include?('sunflower') && @line.any? { |word| word.include?('borges') }
    end

    def sunflower_oil_2?
      @line.include?('mazola') && @line.include?('sunflwr') && @line.include?('oil')
    end

    def sunflower_oil_3?
      @line.include?('sunflow') && @line.include?('gold')
    end

    def garlic_powder?
      @line.include?('garlic') && @line.include?('powder')
    end

    def yellow_mustard?
      @line.include?('yellow') && @line.include?('mustard')
    end

    def salt?
      @line.include?('garam')
    end

    def baking_powder?
      @line.include?('bkng') && @line.include?('pwd')
    end

    def black_pepper?
      @line.include?('black') && @line.include?('papper')
    end

    def jay_leaves?
      @line.include?('jays') && @line.include?('leaves')
    end

    def sugar_3?
      @line.include?('gulaku') && @line.any? { |word| word.include?('kg') }
    end

    def cocoa?
      @line.include?('houten') && @line.include?('powder')
    end

    def sugar_powder?
      @line.include?('rose') && @line.include?('brand') && @line.include?('gula') && @line.include?('halus')
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
        junglegold_coconut? || healthy_bar? || bar_cashew_2? || tobleron? ||
        condensed_milk? || belgian_chocolate_2? || big_babol? || tougri? || ritter? ||
        chocolate_stick_biscuite? || monggo? || some_chocolate? || popcorn? || jika? ||
        reeses_nut_bar? || fullo? || milk_stick? || haribo_2? || sweet_seed? || local_sweet? ||
        lolylop? || dark_chocolate?
    end

    def magnum_icecream?
      @line.include?('magnum')
    end

    def oreo_cake?
      @line.include?('oreo') && @line.include?('cakes')
    end

    def lindt?
      @line.any? { |word| word.include?('lindt') } || (@line.include?('indt') && @line.any? { |word| word.include?('wholealmon') })
    end

    def kit_kat?
      (@line.any? { |word| word.include?('kit') } && @line.include?('kat')) || @line.any? { |word| word.include?('kitkat') }
    end

    def oreo_biscuit?
      @line.include?('oreo')
    end

    def milk_chocolate?
      @line.include?('milk') && @line.include?('chocolate')
    end

    def like_m_and_ms?
      @line.include?('chacha')
    end

    def kinder?
      @line.include?('kinder') || @line.any? { |word| word.include?('kinder') }
    end

    def schogetten?
      @line.include?('schogetten')
    end

    def nutella?
      @line.include?('nutella')
    end

    def halls?
      @line.include?('halls')
    end

    def zaini?
      @line.any? { |word| word.include?('zaini') }
    end

    def peachy?
      @line.include?('peachy')
    end

    def super_shrooms?
      @line.include?('supershrooms')
    end

    def hello_kitty?
      @line.include?('hello') && @line.include?('kitty')
    end

    def jelly?
      @line.include?('jelly') && @line.include?('berries')
    end

    def honey?
      @line.include?('honey') && !@line.include?('ha')
    end

    def cake?
      @line.include?('cake')
    end

    def bar_almond?
      @line.include?('bar') && @line.include?('almond')
    end

    def bar_cashew?
      @line.include?('bar') && @line.include?('cashew')
    end

    def chic_choc?
      @line.include?('chic') && @line.include?('choc')
    end

    def bar_bar?
      @line.include?('delfi')
    end

    def m_and_m?
      @line.include?('m') && @line.include?('&') && @line.include?('peanut')
    end

    def bruxel_chocolate?
      @line.include?('bruxel') && @line.include?('chocolate')
    end

    def cadbury_lickabler?
      @line.include?('cadbury') && @line.include?('lickabler')
    end

    def marshmallow?
      @line.include?('chomp') && (@line.include?('mrsmlw') || @line.include?('mllw') || @line.include?('mallow'))
    end

    def dilan?
      @line.include?('dilan') && (@line.include?('crnchy') || @line.include?('crunch'))
    end

    def ice_cream?
      @line.include?('walls') && (@line.include?('crnt') || @line.include?('strw') || @line.include?('creamy') || @line.include?('rnbw'))
    end

    def truffle_coconut?
      @line.include?('truffle') && @line.include?('coconut')
    end

    def vanila?
      @line.include?('gelato') && @line.include?('vanilla')
    end

    def bar_bar_2?
      @line.include?('bar') && @line.include?('share') && @line.include?('pack')
    end

    def berry_bliss?
      @line.include?('berry') && @line.include?('bliss')
    end

    def milka?
      @line.any? { |word| word.include?('milka') }
    end

    def haribo?
      @line.include?('haribo')
    end

    def lindt_2?
      @line.any? { |word| word.include?('lin') } && @line.any? { |word| word.include?('whole') }
    end

    def bears?
      @line.include?('bears')
    end

    def cake_2?
      @line.include?('mini') && @line.include?('red') && @line.include?('velvet')
    end

    def belgian_chocolate?
      @line.include?('belgian') && @line.include?('milk') && @line.include?('hazel')
    end

    def ice_cream_paletas?
      @line.include?('paletas') && @line.include?('strawberry')
    end

    def snickers?
      @line.include?('snickers')
    end

    def twix?
      @line.include?('twix') && @line.include?('crml')
    end

    def junglegold_coconut?
      @line.any? { |word| word.include?('junglegold') } && @line.include?('coconut')
    end

    def healthy_bar?
      @line.include?('healthy') && @line.include?('bar')
    end

    def bar_cashew_2?
      @line.include?('cashew') && @line.include?('50gr')
    end

    def tobleron?
      @line.include?('tobl') && @line.include?('cho')
    end

    def condensed_milk?
      @line.include?('indomilk') && @line.include?('plain')
    end

    def belgian_chocolate_2?
      @line.include?('belgian') && @line.include?('white')
    end

    def big_babol?
      @line.include?('big') && @line.include?('babol')
    end

    def tougri?
      @line.include?('cho') && @line.include?('milk') && @line.include?('tougri')
    end

    def ritter?
      @line.include?('ritter') && @line.any? { |word| word.include?('gr') }
    end

    def chocolate_stick_biscuite?
      @line.include?('pocky') && @line.include?('choc')
    end

    def monggo?
      @line.include?('monggo')
    end

    def some_chocolate?
      @line.include?('cho') && @line.include?('milk')
    end

    def reeses_nut_bar?
      @line.include?('reeses') && @line.include?('nut') && @line.include?('bar')
    end

    def popcorn?
      @line.include?('sugarays') && @line.include?('nuttela') && @line.include?('butter')
    end

    def jika?
      @line.include?('jika') && @line.include?('chocolat')
    end

    def fullo?
      @line.include?('fullo') && @line.include?('bitz') && @line.include?('vanilla')
    end

    def milk_stick?
      @line.include?('milk') && @line.include?('stick')
    end

    def haribo_2?
      @line.include?('hrb') && @line.include?('cmlw')
    end

    def sweet_seed?
      @line.include?('kacang') && @line.include?('ting')
    end

    def local_sweet?
      @line.include?('gepuk') && @line.include?('ting')
    end

    def lolylop?
      @line.include?('lollypop')
    end

    def dark_chocolate?
      @line.include?('dark') && @line.include?('choco')
    end

    ####

    def tea_or_coffee?
      nescafe? || chococino? || day? || boncafe? || for_coffee_machine? || some_tea?
    end

    def nescafe?
      @line.include?('nescafe')
    end

    def chococino?
      @line.include?('chococino')
    end

    def day?
      @line.include?('day') && (@line.include?('original') || @line.include?('moca'))
    end

    def boncafe?
      @line.include?('boncafe') && @line.include?('coffe')
    end

    def for_coffee_machine?
      @line.include?('indonesso')
    end

    def some_tea?
      @line.include?('chrysanthemum') && @line.include?('cryst')
    end

    ####

    def fruits?
      pineapple? || mango? || dragon_fruit? || watermelon? || banana? || grape? ||
        corn? || red_apple? || pear? || plum? || orange? || lemon? || blueberries? ||
        green_peas? || pepaya? || strawberry? || yellow_watermelon? || cherries? ||
        mixed_berries? || apple? || kiwi? || raspberry? || melon? || pamelo? ||
        lime? || pomegranate? || sweet_apricot?
    end

    def pineapple?
      @line.any? { |word| word.include?('nanas') } && (@line.include?('honi') || @line.include?('slice') || @line.include?('kupas'))
    end

    def mango?
      @line.include?('mangga')
    end

    def dragon_fruit?
      @line.include?('dragon') && @line.include?('fruit')
    end

    def watermelon?
      @line.any? { |word| word.include?('semangka') } && @line.include?('merah')
    end

    def banana?
      @line.any? { |word| word.include?('unpride') } && @line.include?('pisang')
    end

    def grape?
      @line.include?('grape') && (@line.include?('green') || @line.include?('red'))
    end

    def corn?
      @line.include?('jagung') && @line.include?('manis')
    end

    def red_apple?
      @line.include?('red') && @line.include?('apel')
    end

    def pear?
      @line.any? { |word| word.include?('pear') }
    end

    def plum?
      @line.include?('red') && @line.include?('plum')
    end

    def orange?
      @line.include?('jeruk') && (@line.include?('murcot') || @line.include?('shantang') || @line.include?('clement'))
    end

    def lemon?
      @line.include?('lemon')
    end

    def blueberries?
      @line.include?('blueberries')
    end

    def green_peas?
      @line.include?('green') && @line.include?('peas') && !@line.include?('canned')
    end

    def pepaya?
      @line.include?('pepaya') && (@line.include?('calina') || @line.include?('red'))
    end

    def strawberry?
      @line.include?('strawberry') && @line.any? { |word| word.include?('gr') }
    end

    def yellow_watermelon?
      @line.include?('semangka') && @line.include?('kuning')
    end

    def cherries?
      @line.include?('cherries') && @line.include?('kg')
    end

    def mixed_berries?
      @line.include?('mixed') && @line.include?('berries')
    end

    def apple?
      @line.include?('apel') && (@line.include?('grany') || @line.include?('royal') || @line.include?('futi') || @line.include?('malang'))
    end

    def kiwi?
      @line.include?('kiwi') && (@line.include?('green') || @line.include?('golden'))
    end

    def raspberry?
      (@line.include?('raspberry') && @line.include?('local')) || (@line.include?('freshtable') && @line.include?('raspberries'))
    end

    def melon?
      @line.include?('melon') && @line.include?('golden')
    end

    def pamelo?
      @line.include?('pamelo')
    end

    def lime?
      @line.include?('jeruk') && @line.include?('nipis')
    end

    def pomegranate?
      @line.include?('delima') && @line.include?('import')
    end

    def sweet_apricot?
      @line.include?('sweet') && @line.include?('apricot')
    end

    ####

    def vegetables?
      cucumber? || pepper? || tomato? || avocado? || brokoli? || potato? || canned_pepper? ||
        carrot? || kale? || onion? || herb? || tomat_cherry? || parsley? || daun_dill? ||
        tomat_gondol? || zuchini? || red_onion? || beans? || radish? || rucola? ||
        beetroot? || cabbage? || solt_cucumber? || canned_peas? || bond_peas? ||
        mushroom? || chinese_cabbage? || baby_cucumber? || cabbage_2? || asparagus? ||
        kailan? || canned_cucumber? || pumpkin?
    end

    def cucumber?
      @line.any? { |word| word.include?('kyuri') }
    end

    def pepper?
      @line.any? { |word| word.include?('paprika') }
    end

    def tomato?
      @line.include?('beef') && @line.include?('tomato')
    end

    def avocado?
      @line.any? { |word| word.include?('alpukat') }
    end

    def brokoli?
      @line.include?('brokoli')
    end

    def potato?
      @line.include?('kentang')
    end

    def canned_pepper?
      @line.include?('mamas') && @line.include?('pepper') && @line.include?('roast')
    end

    def carrot?
      @line.any? { |word| word.include?('wortel') } && @line.any? { |word| word.include?('medan') }
    end

    def kale?
      @line.include?('kale')
    end

    def onion?
      @line.include?('bawang')
    end

    def red_onion?
      @line.include?('onion') && @line.include?('red')
    end

    def herb?
      @line.any? { |word| word.include?('herb') } && @line.any? { |word| word.include?('dill') }
    end

    def tomat_cherry?
      @line.any? { |word| word.include?('tomat') }&& @line.any? { |word| word.include?('cher') }
    end

    def parsley?
      @line.include?('parsley')
    end

    def daun_dill?
      @line.include?('daun') && @line.any? { |word| word.include?('diil') }
    end

    def tomat_gondol?
      @line.include?('tomat') && @line.include?('gondol')
    end

    def zuchini?
      @line.include?('zuchini')
    end

    def beans?
      @line.include?('buncis')
    end

    def radish?
      @line.include?('red') && @line.any? { |word| word.include?('radish') }
    end

    def rucola?
      @line.include?('rucola') || @line.include?('rucolla') || @line.include?('rocola')
    end

    def beetroot?
      @line.include?('beetroot')
    end

    def cabbage?
      @line.include?('putih') && @line.include?('bulat')
    end

    def solt_cucumber?
      @line.include?('baby') && @line.any? { |word| word.include?('dill') }
    end

    def canned_peas?
      @line.include?('canned') && @line.include?('peas')
    end

    def bond_peas?
      @line.include?('bond') && @line.include?('peas')
    end

    def mushroom?
      @line.include?('mushroom')
    end

    def chinese_cabbage?
      @line.include?('sawi') && @line.include?('putih')
    end

    def baby_cucumber?
      (@line.any? { |word| word.include?('baby') } || @line.include?('big')) && @line.include?('gherkin')
    end

    def cabbage_2?
      @line.include?('romana') && @line.include?('lettuce')
    end

    def asparagus?
      @line.any? { |word| word.include?('asparagus') }
    end

    def kailan?
      @line.include?('kailan')
    end

    def canned_cucumber?
      @line.include?('timun') && @line.include?('acar')
    end

    def pumpkin?
      @line.include?('kabocha') && @line.include?('yellow')
    end

    ####

    def dairy?
      milk? || greenfields_milk? || kin_milk? || greenfields_yog? || biokul_yog? || kin_yog? ||
        delicyo_yog? || cimory_yog? || j_j_cheese? || laughing_cow_cheese? || ricotta_cheese? ||
        cheddar? || sour_cream? || mini_cheese? || anchor_dairy? || bocconcini? || mozzarela? ||
        yogurt? || sour_cream_2? || greenfields_cheese? || president_cheese? || cheese_2? ||
        greenfields_milk_2? || bega_cheese? || butter_cheese? || greek_fetta? || cream_cheese? ||
        heavenly_yog? || butter? || cottage_cheese? || cheese_3? || kid_yog? || yummy_yog? ||
        kefir? || arla_cheese? || milk_up? || parmesan? || mascarpone? || lactima?
    end

    def milk?
      @line.include?('milk') && (@line.include?('life') || @line.any? { |word| word.include?('ltr') })
    end

    def greenfields_milk?
      @line.any? { |word| word.include?('greenfield') } && @line.include?('milk')
    end

    def kin_milk?
      @line.include?('kin') && @line.include?('freshmilk')
    end

    def greenfields_yog?
      @line.include?('greenfields') && (@line.include?('yog') || @line.include?('yg'))
    end

    def biokul_yog?
      @line.any? { |word| word.include?('iokul') } && (@line.include?('yog') || @line.include?('greek') || @line.any? { |word| word.include?('ml') })
    end

    def kin_yog?
      @line.include?('kin') && @line.include?('yog')
    end

    def delicyo_yog?
      @line.any? { |word| word.include?('del') } && @line.any? { |word| word.include?('icyo') } && @line.include?('yog')
    end

    def cimory_yog?
      @line.include?('cimory') && @line.include?('squeeze')
    end

    def j_j_cheese?
      @line.include?('j') && @line.include?('&') && @line.include?('cott')
    end

    def laughing_cow_cheese?
      @line.any? { |word| word.include?('laughing') } && @line.any? { |word| word.include?('co') }
    end

    def ricotta_cheese?
      @line.include?('ricotta')
    end

    def cheddar?
      @line.include?('cheddar')
    end

    def sour_cream?
      @line.any? { |word| word.include?('yummy') } && @line.include?('cream')
    end

    def mini_cheese?
      @line.include?('mini') && @line.include?('cheese')
    end

    def anchor_dairy?
      @line.any? { |word| word.include?('anchor') }
    end

    def bocconcini?
      @line.include?('bocconcini') && @line.include?('fresh')
    end

    def mozzarela?
      @line.include?('mozzarella')
    end

    def yogurt?
      @line.include?('plain') && (@line.include?('yogurt') || @line.include?('yog'))
    end

    def sour_cream_2?
      @line.any? { |word| word.include?('milk') } && @line.include?('sour') && @line.include?('cream')
    end

    def greenfields_cheese?
      @line.include?('greenfields') && @line.include?('bocconcini')
    end

    def president_cheese?
      @line.include?('president') && @line.include?('gouda') && @line.include?('tasty')
    end

    def cheese_2?
      @line.include?('rossa') && @line.include?('renkol')
    end

    def greenfields_milk_2?
      @line.include?('greenfield') && @line.include?('fullcream')
    end

    def bega_cheese?
      @line.include?('bega') && @line.include?('super') && @line.include?('slice')
    end

    def butter_cheese?
      @line.include?('butter') && @line.include?('cheese')
    end

    def greek_fetta?
      @line.include?('greek') && @line.include?('fetta')
    end

    def cream_cheese?
      @line.include?('cream') && @line.include?('cheese')
    end

    def heavenly_yog?
      @line.include?('heavenly') && @line.include?('yog')
    end

    def butter?
      (@line.include?('salt') && @line.include?('butter')) || (@line.include?('btr') && @line.include?('unlstd'))
    end

    def cottage_cheese?
      @line.include?('cottage') && @line.include?('cheese')
    end

    def cheese_3?
      @line.include?('emmental') && @line.include?('breton')
    end

    def kid_yog?
      @line.include?('greenfields') && @line.include?('kds')
    end

    def yummy_yog?
      @line.include?('yummy') && @line.include?('yog')
    end

    def kefir?
      @line.include?('kefir') && @line.include?('milk')
    end

    def arla_cheese?
      @line.include?('arla') && (@line.include?('cheese') || @line.include?('sticks'))
    end

    def milk_up?
      @line.include?('milk') && @line.include?('up') && (@line.include?('yogurt') || @line.include?('yoghurt'))
    end

    def parmesan?
      @line.include?('alba') && @line.include?('parmesan')
    end

    def mascarpone?
      @line.include?('yummy') && @line.include?('mascarpone')
    end

    def lactima?
      @line.include?('lactima') && @line.include?('chee')
    end

    ####

    def bread?
      donut? || bread_sticks? || toast? || wrap? || yeast? || waffels? || flour? ||
        batard? || just_bread? || sourdough? || flour_2? || bun? || donut_chocolate? ||
        croissant? || cinamon? || wrap_2? || hamburger_bun?
    end

    def donut?
      @line.any? { |word| word.include?('onut') } && (@line.include?('sprinkle') || @line.include?('tripple') || @line.include?('icing') || @line.include?('blueberry'))
    end

    def bread_sticks?
      @line.include?('grissini') && @line.include?('gluten')
    end

    def toast?
      @line.any? { |word| word.include?('toast') }
    end

    def wrap?
      @line.include?('rositas') && @line.include?('borrito')
    end

    def yeast?
      @line.include?('fermipan')
    end

    def waffels?
      @line.include?('bruxel') && @line.include?('original')
    end

    def flour?
      @line.include?('kunci') && @line.include?('br')
    end

    def batard?
      @line.include?('batard') && @line.include?('bread')
    end

    def just_bread?
      @line.include?('bread')
    end

    def sourdough?
      @line.include?('sour') && @line.include?('dough')
    end

    def flour_2?
      @line.include?('cakra') && @line.include?('terigu')
    end

    def bun?
      @line.include?('roti') && @line.include?('sobek')
    end

    def donut_chocolate?
      @line.include?('donut') && @line.include?('chocolate')
    end

    def croissant?
      @line.include?('croissant')
    end

    def cinamon?
      @line.any? { |word| word.include?('cinamon') } && @line.include?('roll')
    end

    def wrap_2?
      @line.include?('mission') && @line.include?('tortilla')
    end

    def hamburger_bun?
      @line.include?('hamburger') && @line.include?('bun')
    end

    ####

    def meat?
      chicken_breast? || chicken? || pork? || beef? || pork_2? || chicken_broiler? || duck? ||
        smoked_duck?
    end

    def chicken_breast?
      @line.include?('chic') && @line.include?('breast')
    end

    def chicken?
      @line.include?('chicken') && !(@line.include?('thins') || @line.include?('halal'))
    end

    def pork?
      @line.include?('pork') && @line.include?('fillet')
    end

    def beef?
      @line.include?('prime') && @line.include?('beef')
    end

    def pork_2?
      @line.include?('pork') && @line.include?('roast')
    end

    def chicken_broiler?
      @line.any? { |word| word.include?('chicken') } && @line.include?('broiler')
    end

    def duck?
      @line.include?('duck') && @line.include?('leg')
    end

    def smoked_duck?
      @line.include?('duck') && @line.include?('smoked')
    end

    ####

    def fish?
      marlin? || gravad? || mahi? || tuna? || salmon? || canned_fish?
    end

    def marlin?
      @line.include?('marlin') && @line.include?('steak')
    end

    def gravad?
      @line.include?('gravad') && @line.include?('lax')
    end

    def mahi?
      @line.include?('mahi') && @line.include?('fillet')
    end

    def tuna?
      @line.any? { |word| word.include?('tuna') }
    end

    def salmon?
      @line.include?('salmon')
    end

    def canned_fish?
      @line.include?('sunbell') && @line.include?('chunks')
    end

    ####

    def sausage_and_sausages?
      mamas_ham? || mamas_pork? || sausages? || cooked_ham? || bacon? || smith_field_ham? ||
        mamas_salami? || triple_ham? || bernardi_beef? || nurnberg? || smoke_ham? ||
        mamas_sausage? || sausage? || bratwurst? || breakfast_ham? || danish_ham? ||
        nice_sausage? || aroma_pork? || turkey_sausages? || chicken_sausage? || bernardi? ||
        triple_ham_2?
    end

    def mamas_ham?
      @line.include?('mamas') && @line.include?('ham')
    end

    def mamas_pork?
      @line.include?('mamas') && @line.include?('pork')
    end

    def sausages?
      @line.include?('kanzler') && (@line.include?('original') || @line.include?('singles'))
    end

    def cooked_ham?
      @line.any? { |word| word.include?('ooked') } && @line.include?('ham')
    end

    def bacon?
      @line.include?('bacon')
    end

    def smith_field_ham?
      @line.any? { |word| word.include?('smithfield') } && @line.include?('ham')
    end

    def mamas_salami?
      @line.any? { |word| word.include?('mamas') } && @line.include?('salami')
    end

    def triple_ham?
      @line.include?('fores') && @line.include?('triple') && @line.include?('black')
    end

    def bernardi_beef?
      @line.include?('bernardi') && @line.include?('beef')
    end

    def nurnberg?
      @line.include?('nuernbrgr')
    end

    def smoke_ham?
      @line.include?('smoke') && @line.include?('ham')
    end

    def mamas_sausage?
      @line.any? { |word| word.include?('mamas') } && @line.any? { |word| word.include?('kalberwurst') }
    end

    def sausage?
      @line.include?('sausage')
    end

    def bratwurst?
      @line.include?('garlic') && @line.include?('bratwurs')
    end

    def breakfast_ham?
      @line.include?('breakfast') && @line.include?('ham')
    end

    def danish_ham?
      @line.include?('danish') && @line.include?('ham')
    end

    def nice_sausage?
      @line.include?('nice') && @line.include?('sosis')
    end

    def aroma_pork?
      @line.include?('aroma') && @line.include?('pork')
    end

    def turkey_sausages?
      @line.include?('turkey') && @line.include?('smoked')
    end

    def chicken_sausage?
      @line.include?('chicken') && @line.include?('halal')
    end

    def bernardi?
      @line.include?('bernardi') && @line.include?('chick')
    end

    def triple_ham_2?
      @line.include?('triple') && @line.include?('three') && (@line.include?('ha') || @line.include?('ham'))
    end

    ####

    def for_beer?
      lays? || pistachios? || pringles? || thins_chips? || corn_sticks? || crisps? ||
        lorenz? || loren? || chitato? || cashew? || cashew_2? || nori? || cashew_3? ||
        cashew_4?
    end

    def lays?
      @line.include?('lays') || (@line.include?('lay') && @line.include?('chips'))
    end

    def pistachios?
      @line.include?('pistachios') || @line.include?('pischio') || @line.include?('pistacio') || @line.include?('pistac')
    end

    def pringles?
      @line.include?('pringles')
    end

    def thins_chips?
      @line.include?('thins')
    end

    def corn_sticks?
      @line.include?('cheeto') && @line.any? { |word| word.include?('puffs') }
    end

    def crisps?
      @line.include?('lrz') && @line.include?('nat') && @line.include?('classic')
    end

    def lorenz?
      @line.include?('lorenz') && @line.include?('parmesan')
    end

    def loren?
      @line.include?('loren') && @line.include?('brez')
    end

    def chitato?
      @line.include?('chitato') && @line.include?('beef')
    end

    def cashew?
      @line.include?('yava') && @line.include?('sea') && @line.include?('salt')
    end

    def cashew_2?
      @line.include?('yava') && @line.include?('cashew') && @line.include?('roasted')
    end

    def nori?
      @line.include?('nori') && @line.include?('crispy')
    end

    def cashew_3?
      @line.include?('meman') && @line.include?('kacang')
    end

    def cashew_4?
      @line.include?('matahari')
    end

    ####

    def grocery?
      rice? || barilla? || oats? || peas? || vermicelli? || some_porridge? ||
        rice_noodle? || oats_2? || red_lentils? || conhiglie? || farfalle? ||
        granola? || cous_cous? || oats_3? || rice_2? || oats_4?
    end

    def rice?
      @line.include?('basmati') && @line.include?('rice')
    end

    def barilla?
      @line.include?('barilla')
    end

    def oats?
      @line.include?('australia') && @line.include?('harvest')
    end

    def peas?
      @line.include?('mckenzies') && @line.include?('yellow')
    end

    def vermicelli?
      @line.include?('rice') && @line.include?('vermicelli')
    end

    def some_porridge?
      @line.include?('organico') && @line.include?('quinoa')
    end

    def rice_noodle?
      @line.include?('rice') && @line.include?('noodle')
    end

    def oats_2?
      @line.include?('oats') && @line.include?('quick') && @line.include?('cooking')
    end

    def red_lentils?
      @line.include?('red') && @line.include?('lentils')
    end

    def conhiglie?
      @line.include?('conhiglie') && @line.include?('rigate')
    end

    def farfalle?
      @line.include?('farfalle')
    end

    def granola?
      @line.include?('yava') && @line.any? { |word| word.include?('granol') }
    end

    def cous_cous?
      grouped_words_by_count = @line.tally
      grouped_words_by_count['cous'] == 2
    end

    def oats_3?
      @line.include?('oat') && @line.include?('quaker')
    end

    def rice_2?
      @line.include?('riso') && @line.any? { |word| word.include?('gr') }
    end

    def oats_4?
      @line.include?('dat') && @line.include?('whole') && @line.include?('rolled')
    end

    ####

    def kitchen_stuff?
      paseo? || some_stuff? || sponge? || montis? || soap? || handsoap? || another_soap? ||
        dove? || to_wash_plates? || plastic_bag? || candles_for_cake? || sticks_for_food? ||
        to_wash_plates_2? || sponge_2? || trash_bag? || to_wash_plates_3? || to_wash_plates_4?
    end

    def paseo?
      @line.include?('paseo')
    end

    def some_stuff?
      @line.any? { |word| word.include?('youth') } && @line.include?('kitchen')
    end

    def sponge?
      @line.include?('polytex') && @line.any? { |word| word.include?('spo') }
    end

    def montis?
      @line.include?('montiss') && @line.include?('tissu')
    end

    def soap?
      @line.include?('sunlight')
    end

    def handsoap?
      @line.include?('dettol')
    end

    def another_soap?
      @line.include?('lifebuoy') && @line.include?('soap')
    end

    def dove?
      @line.include?('dove')
    end

    def to_wash_plates?
      @line.include?('sunlight') && @line.include?('mint')
    end

    def plastic_bag?
      @line.include?('klinpak') && @line.include?('sampah')
    end

    def candles_for_cake?
      @line.include?('son') && @line.include?('lin') && @line.include?('angka') && @line.include?('emas')
    end

    def sticks_for_food?
      @line.include?('tusuk') && @line.include?('gigi') && @line.include?('naomi')
    end

    def to_wash_plates_2?
      @line.include?('phg') && @line.include?('pch800ml')
    end

    def sponge_2?
      @line.include?('polytx') && @line.include?('serap')
    end

    def trash_bag?
      @line.include?('trash') && @line.include?('bag')
    end

    def to_wash_plates_3?
      @line.include?('dishash') && @line.include?('jeruknipis') && @line.include?('bot')
    end

    def to_wash_plates_4?
      @line.include?('lavd') && @line.include?('violet') && @line.include?('ref')
    end

    ####

    def food_bag_or_delivery?
      bag?
    end

    def bag?
      @line.include?('pepito') && @line.include?('bag')
    end

    ####

    def bath_stuff?
      clear_gel? || colgate? || local_vanish? || vanish? || luquid_soap? || colgate_2? ||
        kids_toothpaste? || floss? || local_vanish_2? || luquid_soap_2? || tooth_brush? ||
        shampoo? || shampoo_2? || to_clean_smth? || sensodyne? || vitamin_for_hair? ||
        toothpaste?
    end

    def clear_gel?
      @line.include?('clear') && @line.include?('active')
    end

    def colgate?
      @line.include?('colgate')
    end

    def local_vanish?
      @line.include?('proclin')
    end

    def vanish?
      @line.include?('vanish')
    end

    def luquid_soap?
      @line.include?('j') && @line.include?('&') && @line.include?('bath')
    end

    def colgate_2?
      @line.any? { |word| word.include?('colg') } && @line.any? { |word| word.include?('whitenning') }
    end

    def kids_toothpaste?
      @line.include?('kids') && @line.include?('toothpaste')
    end

    def floss?
      @line.include?('dental') && @line.any? { |word| word.include?('floss') }
    end

    def local_vanish_2?
      @line.include?('proc') && @line.include?('wht')
    end

    def luquid_soap_2?
      @line.include?('j') && @line.include?('&') && @line.any? { |word| word.include?('wash') }
    end

    def tooth_brush?
      @line.include?('tbrush') && @line.include?('sanrio')
    end

    def shampoo?
      @line.include?('shampoo') && @line.include?('ginseng')
    end

    def shampoo_2?
      @line.include?('tea') && @line.include?('tree') && @line.include?('oil')
    end

    def to_clean_smth?
      @line.include?('bayclin') && @line.include?('regular')
    end

    def sensodyne?
      @line.include?('sensodyne')
    end

    def vitamin_for_hair?
      @line.include?('ellips') && @line.include?('nutri') && @line.include?('blister')
    end

    def toothpaste?
      @line.include?('darlie') && @line.any? { |word| word.include?('mint') }
    end

    ####

    def home_stuff?
      bataries? || baby_wipes? || another_baby_wipes? || energizer? || baterai? ||
        some_spray? || wet_wipes? || raincoat? || glue? || humidity_gathering? ||
        for_furniture? || antis? || for_ants?
    end

    def bataries?
      @line.include?('panasonic') && @line.include?('alk')
    end

    def baby_wipes?
      @line.include?('baby') && @line.include?('wipes')
    end

    def another_baby_wipes?
      @line.any? { |word| word.include?('etkins') } && @line.include?('clean')
    end

    def energizer?
      @line.include?('energizer')
    end

    def baterai?
      @line.include?('baterai') && @line.include?('biru')
    end

    def some_spray?
      @line.include?('phrn') && @line.include?('merah')
    end

    def wet_wipes?
      @line.include?('neppi') && @line.include?('baby') && !@line.include?('diaper')
    end

    def raincoat?
      @line.include?('hujan') && @line.include?('ponco')
    end

    def glue?
      @line.include?('castol') && @line.include?('besar')
    end

    def humidity_gathering?
      @line.include?('bagus') && ((@line.include?('serap') && @line.include?('air')) || @line.include?('reffil'))
    end

    def for_furniture?
      @line.any? { |word| word.include?('lmnpladge') } && @line.any? { |word| word.include?('liq') }
    end

    def antis?
      @line.include?('antis') && @line.include?('spray')
    end

    def for_ants?
      @line.include?('hit') && @line.include?('aerosol')
    end

    ####

    def pampers?
      sweety? || merries? || diaper_baby?
    end

    def sweety?
      @line.any? { |word| word.include?('sweety') } && @line.include?('pant')
    end

    def merries?
      @line.include?('merries') && @line.any? { |word| word.include?('good') }
    end

    def diaper_baby?
      @line.include?('diaper') && @line.include?('baby')
    end

    ####

    def ready_to_cook?
      @line.include?('sora') && @line.include?('mozzarela')
    end

    ####

    def mark_toys?
      bubbles?
    end

    def bubbles?
      @line.include?('yasuka')
    end

    ####

    def liliia_bath_stuff?
      carefree_fresh? || laurier?
    end

    def carefree_fresh?
      @line.include?('carefree') && @line.include?('fresh')
    end

    def laurier?
      @line.include?('laurier')
    end

    ####

    def liliia_clothes?
      for_hair?
    end

    def for_hair?
      @line.include?('jepit') && @line.include?('rambut')
    end

    ####

    def mykola_bath_stuff?
      foam?
    end

    def foam?
      @line.include?('gillete')
    end

    ####

    def party_in_restraunt_or_birthday?
    end
  end
end
