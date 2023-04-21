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
      @line.any? { |word| word.include?('bintang') } && @line.include?('crystal')
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
      @line.include?('telur')
    end

    ####

    def water?
      green_tea? || cherry_juice? || cola? || fruit_juice? || andros_juice? || happy_day_juice? ||
        berri_juice? || bottle_of_water? || mineral_water? || aqua_click? || coconut_drink? ||
        mango_juice? || snake_fruit?
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

    ####

    def spices_and_seasonings?
      kikko_soy_souce? || mayonaise? || soy_souce? || french_mustard? || vinegar? || sugar? ||
        oil? || sugar_2? || tomat_for_borsch? || soda? || rosemary? || sunflower_oil? ||
        sunflower_oil_2? || garlic_powder? || yellow_mustard? || sunflower_oil_3?
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
      @line.include?('soda')
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
      @line.include?('magnum')
    end

    def oreo_cake?
      @line.include?('oreo') && @line.include?('cakes')
    end

    def lindt?
      @line.any? { |word| word.include?('lindt') }
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
      @line.include?('honey')
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
      @line.include?('chomp') && @line.include?('mrsmlw')
    end

    def dilan?
      @line.include?('dilan') && @line.include?('crnchy')
    end

    def ice_cream?
      @line.include?('walls') && (@line.include?('crnt') || @line.include?('strw'))
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

    ####

    def tea_or_coffee?
      nescafe? || chococino? || day? || boncafe? || for_coffee_machine?
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

    ####

    def fruits?
      pineapple? || mango? || dragon_fruit? || watermelon? || banana? || grape? ||
        corn? || red_apple? || pear? || plum? || orange? || lemon? || blueberries? ||
        green_peas? || pepaya?
    end

    def pineapple?
      @line.any? { |word| word.include?('nanas') } && @line.include?('honi')
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
      @line.include?('green') && @line.include?('grape')
    end

    def corn?
      @line.include?('jagung') && @line.include?('manis')
    end

    def red_apple?
      @line.include?('red') && @line.include?('apel')
    end

    def pear?
      @line.include?('pear')
    end

    def plum?
      @line.include?('red') && @line.include?('plum')
    end

    def orange?
      @line.include?('jeruk') && @line.include?('murcot')
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
      @line.include?('pepaya') && @line.include?('calina')
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
      @line.include?('beef') && @line.include?('tomato')
    end

    def avocado?
      @line.any? { |word| word.include?('alpukat') }
    end

    def brokoli?
      @line.include?('brokoli')
    end

    def potato?
      @line.include?('kentang') && @line.include?('besar')
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
      @line.include?('tomat') && @line.any? { |word| word.include?('cher') }
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
      @line.include?('baby') && @line.include?('gherkin')
    end

    def cabbage_2?
      @line.include?('romana') && @line.include?('lettuce')
    end

    def asparagus?
      @line.include?('asparagus')
    end

    def kailan?
      @line.include?('kailan')
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
      @line.include?('milk') && @line.include?('life')
    end

    def greenfields_milk?
      @line.any? { |word| word.include?('greenfield') } && @line.include?('milk')
    end

    def kin_milk?
      @line.include?('kin') && @line.include?('freshmilk')
    end

    def greenfields_yog?
      @line.include?('greenfields') && @line.include?('yog')
    end

    def biokul_yog?
      @line.any? { |word| word.include?('iokul') } && @line.include?('yog')
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
      @line.include?('milk') && @line.include?('sour') && @line.include?('cream')
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

    ####

    def bread?
      donut? || bread_sticks? || toast? || wrap? || yeast? || waffels? || flour? ||
        batard? || just_bread? || sourdough? || flour_2? || bun? || donut_chocolate? ||
        croissant? || cinamon?
    end

    def donut?
      @line.any? { |word| word.include?('onut') } && (@line.include?('sprinkle') || @line.include?('tripple') || @line.include?('icing'))
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
      @line.include?('cinamon') && @line.include?('roll')
    end

    ####

    def meat?
      chicken_breast? || chicken? || pork? || beef? || pork_2?
    end

    def chicken_breast?
      @line.include?('chic') && @line.include?('breast')
    end

    def chicken?
      @line.include?('chicken')
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

    ####

    def fish?
      marlin? || gravad? || mahi? || tuna? || salmon?
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
      @line.include?('tuna')
    end

    def salmon?
      @line.include?('salmon')
    end

    ####

    def sausage_and_sausages?
      mamas_ham? || mamas_pork? || sausages? || cooked_ham? || bacon? || smith_field_ham? ||
        mamas_salami? || triple_ham? || bernardi_beef? || nurnberg? || smoke_ham? ||
        mamas_sausage? || sausage? || bratwurst? || breakfast_ham? || danish_ham? ||
        nice_sausage? || aroma_pork? || turkey_sausages?
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

    ####

    def for_beer?
      lays? || pistachios? || pringles? || thins_chips? || corn_sticks? || crisps? ||
        lorenz? || loren? || chitato? || cashew?
    end

    def lays?
      @line.include?('lays') || (@line.include?('lay') && @line.include?('chips'))
    end

    def pistachios?
      @line.include?('pistachios') || @line.include?('pischio') || @line.include?('pistacio')
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

    ####

    def grocery?
      rice? || barilla? || oats? || peas? || vermicelli? || some_porridge? ||
        rice_noodle? || oats_2? || red_lentils? || conhiglie? || farfalle? ||
        granola? || cous_cous?
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
      @line.include?('yava') && @line.include?('granola')
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
      @line.include?('sunlight') && @line.include?('korean')
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
        shampoo? || shampoo_2? || to_clean_smth? || sensodyne? || vitamin_for_hair?
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
      @line.include?('proc') && @line.include?('wht') && @line.include?('crti')
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

    ####

    def home_stuff?
      bataries? || baby_wipes? || another_baby_wipes? || energizer? || baterai? ||
        some_spray? || wet_wipes? || raincoat? || glue? || humidity_gathering?
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

    ####

    def pampers?
      sweety? || merries? || diaper_baby?
    end

    def sweety?
      @line.include?('sweety') && @line.include?('pant')
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
  end
end
