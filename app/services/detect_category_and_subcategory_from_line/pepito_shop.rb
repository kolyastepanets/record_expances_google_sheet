module DetectCategoryAndSubcategoryFromLine
  class PepitoShop < Default
    def initialize(line_from_receipt)
      @line = line_from_receipt.map(&:downcase)
    end

    def alcohol?
      beer? || wine?
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

    ####

    def eggs?
      @line.include?('telur')
    end

    ####

    def water?
      green_tea? || cherry_juice? || cola? || fruit_juice? || andros_juice? || happy_day_juice? ||
        berri_juice? || bottle_of_water? || mineral_water?
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

    ####

    def spices_and_seasonings?
      kikko_soy_souce? || mayonaise? || soy_souce? || french_mustard? || vinegar? || sugar? ||
        oil? || sugar_2?
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
      @line.include?('ext') && @line.include?('virgin')
    end

    def sugar_2?
      @line.include?('segitiga') && @line.include?('biru')
    end

    ####

    def sweets?
      magnum_icecream? || oreo_cake? || lindt? || kit_kat? || oreo_biscuit? || milk_chocolate? ||
        like_m_and_ms? || kinder? || schogetten? || nutella? || zaini? || halls? || peachy? ||
        super_shrooms? || hello_kitty? || jelly? || honey?
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
      @line.any? { |word| word.include?('kit') } && @line.include?('kat')
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
      @line.include?('kinder')
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

    ####

    def tea_or_coffee?
      nescafe? || chococino? || day?
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

    ####

    def fruits?
      pineapple? || mango? || dragon_fruit? || watermelon? || banana? || grape? ||
        corn? || red_apple? || pear? || plum? || orange?
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

    ####

    def vegetables?
      cucumber? || pepper? || tomato? || avocado? || brokoli? || potato? || canned_pepper? ||
        carrot? || kale? || onion? || herb? || tomat_cherry? || parsley? || daun_dill? ||
        tomat_gondol? || zuchini? || red_onion? || beans? || radish?
    end

    def cucumber?
      @line.any? { |word| word.include?('kyuri') }
    end

    def pepper?
      @line.include?('paprika')
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
      @line.include?('wortel') && @line.any? { |word| word.include?('medan') }
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
      @line.include?('tomat') && @line.include?('cherry')
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
      @line.include?('red') && @line.include?('radish')
    end

    ####

    def dairy?
      milk? || greenfields_milk? || kin_milk? || greenfields_yog? || biokul_yog? || kin_yog? ||
        delicyo_yog? || cimory_yog? || j_j_cheese? || laughing_cow_cheese? || ricotta_cheese? ||
        diamond_cheddar? || sour_cream?
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
      @line.any? { |word| word.include?('laughing') } && @line.any? { |word| word.include?('co') } &&
        @line.any? { |word| word.include?('chee') }
    end

    def ricotta_cheese?
      @line.include?('ricotta')
    end

    def diamond_cheddar?
      @line.include?('diamond') && @line.include?('cheddar')
    end

    def sour_cream?
      @line.include?('yummy') && @line.include?('sour') && @line.include?('cream')
    end

    ####

    def bread?
      donut? || bread_sticks? || toast? || wrap?
    end

    def donut?
      @line.any? { |word| word.include?('onut') } && (@line.include?('sprinkle') || @line.include?('tripple'))
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

    ####

    def meat?
      chicken_breast? || chicken?
    end

    def chicken_breast?
      @line.include?('chic') && @line.include?('breast')
    end

    def chicken?
      @line.include?('chicken')
    end

    ####

    def fish?
      marlin? || gravad? || mahi?
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

    ####

    def sausage_and_sausages?
      mamas_ham? || mamas_pork? || sausages? || cooked_ham? || bacon? || smith_field_ham? ||
        mamas_salami? || triple_ham? || bernardi_beef? || nurnberg?
    end

    def mamas_ham?
      @line.include?('mamas') && @line.include?('ham')
    end

    def mamas_pork?
      @line.include?('mamas') && @line.include?('pork')
    end

    def sausages?
      @line.include?('kanzler') && @line.include?('original')
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
      @line.include?('mamas') && @line.include?('salami')
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

    ####

    def for_beer?
      lays? || pistachios? || pringles? || thins_chips? || corn_sticks?
    end

    def lays?
      @line.include?('lays') || (@line.include?('lay') && @line.include?('chips'))
    end

    def pistachios?
      @line.include?('pistachios') || @line.include?('pischio')
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

    ####

    def grocery?
      rice? || barilla? || oats? || peas? || vermicelli?
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

    ####

    def kitchen_stuff?
      paseo? || some_stuff? || sponge? || montis? || soap? || handsoap? || another_soap?
    end

    def paseo?
      @line.include?('paseo')
    end

    def some_stuff?
      @line.any? { |word| word.include?('youth') } && @line.include?('kitchen')
    end

    def sponge?
      @line.include?('polytex') && @line.include?('sponge')
    end

    def montis?
      @line.include?('montiss') && @line.include?('tissu')
    end

    def soap?
      @line.include?('sunlight') && @line.include?('korean')
    end

    def handsoap?
      @line.include?('dettol') && @line.include?('energi')
    end

    def another_soap?
      @line.include?('lifebuoy') && @line.include?('soap')
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
      clear_gel? || colgate? || local_vanish? || vanish?
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

    ####

    def home_stuff?
      bataries? || baby_wipes? || another_baby_wipes? || energizer? || baterai?
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

    ####

    def pampers?
      sweety? || merries?
    end

    def sweety?
      @line.include?('sweety') && @line.include?('pant')
    end

    def merries?
      @line.include?('merries') && @line.any? { |word| word.include?('good') }
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
  end
end
