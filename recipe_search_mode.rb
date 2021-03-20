class Recipe

  attr_accessor :name, :ingredients

  def initialize(name, ingredients)
    @name = name
    @ingredients = ingredients
  end
end

e1 = {             "punane riis" => 185,
                   "neitsioliiviõli" => 15,
                   "paprika" => 200,
                   "porgand" => 120,
                   "mugulsibul" => 150,
                   "küüslauk" => 6,
                   "oregano" => 3,
                   "jahvatatud vürtskoomned" => 4,
                   "tomat" => 400,
                   "mustad oad" => 240,
                   "aedviljapuljong" => 10,
                   "tume šokolaad" => 20,
                   "roheline sibul" => 15 }

t1 = {             "penne pasta" => 300,
                   "või" => 15,
                   "muna" => 2,
                   "parmesan" => 80,
                   "vahukoor" => 200,
                   "sidrun" => 120 }

k1 = {             "külmutatud aeduba" => 400,
                   "punane sibul" => 300,
                   "neitsioliiviõli" => 15,
                   "tomat" => 300,
                   "oregano" => 2,
                   "feta juust" => 125,
                   "basmati riis" => 185 }

n1 = {             "spagetid" => 200,
                   "kapsas" => 500,
                   "pesto" => 100,
                   "parmesan" => 40,
                   "feta juust" => 75,
                   "tomat" => 250,
                   "vahemere ürdisegu" => 2,
                   "või" => 25,
                   "neitsioliiviõli" => 25}


r1 = {             "seesamiõli" => 30,
                   "tofu" => 250,
                   "ingver" => 10,
                   "mugulsibul" => 150,
                   "sojakaste" => 45,
                   "paprika" => 200,
                   "hiina kapsas" => 50,
                   "šampinjonid" => 125,
                   "nuudlid" => 200,
                   "porgand" => 120,
                   "roheline sibul" => 20,
                   "seesamiseemned" => 5 }

l1 = {             "paprika" => 800,
                   "punane sibul" => 750,
                   "neitsioliiviõli" => 15,
                   "veini äädikas" => 20,
                   "pruun suhkur" => 40,
                   "kapparid" => 20,
                   "penne pasta" => 300 }

p1 = {             "seesamiõli" => 15,
                   "ingver" => 10,
                   "küüslauk" => 8,
                   "sojakaste" => 15,
                   "riisiäädika" => 10,
                   "aedviljapuljong" => 20,
                   "šampinjonid" => 75,
                   "nuudlid" => 300,
                   "nori lehed" => 2.8,
                   "roheline sibul" => 20,
                   "porgand" => 120,
                   "seesamiseemned" => 5 }

# 2. nädal:

e2 = {             "basmati riis" => 185,
                   "neitsioliiviõli" => 15,
                   "kookospiim" => 400,
                   "ingver" => 10,
                   "mugulsibul" => 150,
                   "küüslauk" => 6,
                   "kurkum" => 2,
                   "vürtsköömen" => 2,
                   "jahvatatud koriander" => 1,
                   "jahvatatud kaneel" => 2,
                   "aedviljapuljong" => 10,
                   "punased läätsed" => 150,
                   "laimimahl" => 10,
                   "hakitud spinat" => 50 }

t2 = {             "penne pasta" => 300,
                   "neitsioliiviõli" => 15,
                   "küüslauk" => 4,
                   "tomat" => 250,
                   "vahukoor" => 200,
                   "šampinjonid" => 175,
                   "jahvatatud kaneel" => 2,
                   "maitsepärm" => 4 }

k2 = {             "pruun riis" => 125,
                   "neitsioliiviõli" => 15,
                   "wokisegu" => 400,
                   "küüslauk" => 4,
                   "vürtsköömen" => 4,
                   "oad tomatikastmes" => 415,
                   "tomat" => 250,
                   "laimimahl" => 10 }


n2 = {             "punased läätsed" => 125,
                   "ingver" => 10,
                   "mugulsibul" => 150,
                   "küüslauk" => 2,
                   "neitsioliiviõli" => 15,
                   "aedviljapuljong" => 10,
                   "kurkum" => 2,
                   "tomat" => 300,
                   "kookospiim" => 400 }

r2 = {             "tatar" => 300,
                   "tomat" => 300,
                   "porrulauk" => 200,
                   "neitsioliiviõli" => 15,
                   "sojakaste" => 15,
                   "riisiäädika" => 15 }

l2 = {             "basmati riis" => 120,
                   "neitsioliiviõli" => 15,
                   "punane sibul" => 150,
                   "tomat" => 250,
                   "sakilised friikartulid" => 450,
                   "veini äädikas" => 20,
                   "tofu" => 250,
                   "sojakaste" => 15,
                   "ingver" => 10,
                   "küüslauk" => 4,
                   "roheline sibul" => 20 }

p2 = {             "külmutatud herned" => 600,
                   "neitsioliiviõli" => 30,
                   "mugulsibul" => 150,
                   "küüslauk" => 4,
                   "hiina kapsas" => 100,
                   "aedviljapuljong" => 10,
                   "vahukoor" => 200,
                   "india pähkel" => 50,
                   "maitsepärm" => 6 }

# 3. nädal:

e3 = {             "suvikõrvits" => 300,
                   "parmesan" => 80,
                   "risoto riis" => 250,
                   "aedviljapuljong" => 10,
                   "mugulsibul" => 150,
                   "kuivatatud tüümian" => 4,
                   "päikesekuivatatud tomat" => 70,
                   "või" => 50}

t3 = {             "penne pasta" => 300,
                   "neitsioliiviõli" => 15,
                   "punane sibul" => 100,
                   "paprika" => 200,
                   "mustad oliivid" => 110,
                   "tomat" => 125,
                   "feta juust" => 200,
                   "aedviljapuljong" => 5,
                   "oregano" => 4,
                   "sidrun" => 60 }

k3 = {             "mugulsibul" => 150,
                   "vürtsköömen" => 2,
                   "neitsioliiviõli" => 15,
                   "jahvatatud karri" => 4,
                   "punased läätsed" => 100,
                   "bataat" => 400,
                   "aedviljapuljong" => 10,
                   "tomat" => 200,
                   "kikerherned" => 400,
                   "jahvatatud koriander" => 2,
                   "kolme riisi segu" => 125 }

n3 = {             "neitsioliiviõli" => 15,
                   "punane sibul" => 400,
                   "kartul" => 300,
                   "tomat" => 400,
                   "päikesekuivatatud tomat" => 60,
                   "sulajuust" => 200,
                   "aedviljapuljong" => 20 }

r3 = {             "šampinjonid" => 125,
                   "pärlsibul" => 40,
                   "kuivatatud tüümian" => 2,
                   "või" => 20,
                   "pitsapõhja" => 400,
                   "neitsioliiviõli" => 50,
                   "tomatikaste ürtidega" => 250,
                   "riivjuust" => 100 }

l3 = {             "täisteratortilla" => 320,
                   "frillice" => 100,
                   "neitsioliiviõli" => 10,
                   "paprika" => 400,
                   "oad tomatikastmes" => 415,
                   "punane sibul" => 100,
                   "kolme riisi segu" => 100 }

p3 = {             "tofu" => 250,
                   "nuudlid" => 300,
                   "neitsioliiviõli" => 15,
                   "mugulsibul" => 150,
                   "šampinjonid" => 125,
                   "tom kha supipasta" => 20,
                   "tomat" => 300,
                   "kookospiim" => 400,
                   "sojakaste" => 25,
                   "laimimahl" => 10 }

# 4. nädal:

e4 = {             "basmati riis" => 100,
                   "risoto riis" => 140,
                   "aedviljapuljong" => 5,
                   "või" => 50,
                   "neitsioliiviõli" => 10,
                   "shimeji" => 175,
                   "seesamiseemned" => 10,
                   "riisiäädika" => 25,
                   "sojakaste" => 25,
                   "roheline sibul" => 20 }

t4 = {             "pärmi-lehttaigen" => 500,
                   "või" => 25,
                   "cheddar juust" => 100,
                   "päikesekuivatatud tomat" => 60,
                   "kuivatatud tüümian" => 4,
                   "seesamiseemned" => 25 }

k4 = {             "nuudlid" => 300,
                   "seesamiõli" => 15,
                   "mugulsibul" => 150,
                   "küüslauk" => 6,
                   "ingver" => 10,
                   "jahvatatud kaneel" => 1,
                   "šampinjonid" => 75,
                   "aedviljapuljong" => 10,
                   "sojakaste" => 15,
                   "soolapähklid" => 100,
                   "porgand" => 120,
                   "roheline sibul" => 20,
                   "lehtsalat" => 100 }

n4 = {             "spagetid" => 300,
                   "neitsioliiviõli" => 15,
                   "küüslauk" => 4,
                   "tomat" => 800,
                   "oregano" => 4,
                   "pruun suhkur" => 8,
                   "maitsepärm" => 4,
                   "tomatikaste ürtidega" => 250 }

r4 = {             "neitsioliiviõli" => 15,
                   "tomat" => 150,
                   "mugulsibul" => 150,
                   "hakitud spinat" => 150,
                   "kikerherned" => 800,
                   "vürtsköömen" => 2,
                   "ingver" => 10,
                   "kurkum" => 2,
                   "pruun riis" => 185 }

l4 = {             "sojakaste" => 35,
                   "apelsin" => 200,
                   "tofu" => 500,
                   "küüslauk" => 4,
                   "ingver" => 10,
                   "seesamiõli" => 15,
                   "riisiäädika" => 10,
                   "maisitärklis" => 4,
                   "apelsinimarmelaad" => 600,
                   "basmati riis" => 220 }

p4 = {             "kartul" => 1000,
                   "küüslauk" => 8,
                   "neitsioliiviõli" => 30,
                   "rosmariin" => 4,
                   "mustad oliivid" => 110,
                   "kurk" => 300,
                   "tomat" => 250,
                   "punane sibul" => 100,
                   "õunaäädikas" => 5 }

$w1 = {}
$w1 = $w1.merge(e1, t1, k1, n1, r1, l1, p1) {|key, val1, val2| val1 + val2}

$w2 = {}
$w2 = $w2.merge(e2, t2, k2, n2, r2, l2, p2) {|key, val1, val2| val1 + val2}

$w3 = {}
$w3 = $w3.merge(e3, t3, k3, n3, r3, l3, p3) {|key, val1, val2| val1 + val2}

$w4 = {}
$w4 = $w4.merge(e4, t4, k4, n4, r4, l4, p4) {|key, val1, val2| val1 + val2}

$mth = {}
$mth = $mth.merge($w1, $w2, $w3, $w4) {|key, val1, val2| val1 + val2}

E1 = Recipe.new("E1: oatšilli", e1)
T1 = Recipe.new("T1: sidrunipasta", t1)
K1 = Recipe.new("K1: Kreeka oapada", k1)
N1 = Recipe.new("N1: spagetid röstitud kapsa, pesto ja fetaga", n1)
R1 = Recipe.new("R1: Aasia nuudlid praetud köögiviljadega", r1)
L1 = Recipe.new("L1: peperonata", l1)
P1 = Recipe.new("P1: vege-ramen", p1)

E2 = Recipe.new("E2: läätse-dal", e2)
T2 = Recipe.new("T2: seene-kaneeli pasta", t2)
K2 = Recipe.new("K2: Mehhiko oa-riisipada", k2)
N2 = Recipe.new("N2: läätsesupp kookospiimaga", n2)
R2 = Recipe.new("R2: tatar sojakastme ja porrulauguga", r2)
L2 = Recipe.new("L2: tofuribad äädikaste friikartulitega", l2)
P2 = Recipe.new("P2: kreemine hernesupp", p2)

E3 = Recipe.new("E3: suvikõrvitsarisoto", e3)
T3 = Recipe.new("T3: Kreeka pasta", t3)
K3 = Recipe.new("K3: läätse-bataadikarri", k3)
N3 = Recipe.new("N3: tomati-sibulasupp", n3)
R3 = Recipe.new("R3: seene-jalapenopitsa", r3)
L3 = Recipe.new("L3: riisi- ja oaburritod", l3)
P3 = Recipe.new("P3: vege-tom kha gai", p3)

E4 = Recipe.new("E4: võis praetud shimeji-seened riisiseguga", e4)
T4 = Recipe.new("T4: juusturullid päikesekuivatatud tomatite ja tüümianiga", t4)
K4 = Recipe.new("K4: Aasia pähkli-nuudlisupp", k4)
N4 = Recipe.new("N4: spagetid marinara kastmega", n4)
R4 = Recipe.new("R4: palak chana", r4)
L4 = Recipe.new("L4: apelsinikastmes tofu riisiga", l4)
P4 = Recipe.new("P4: ahjukartulid rosmariini, oliivide ja värske salatiga", p4)

class Recipe_Search_Interface < List_Search_Interface

    def build_recipe_search_list
        all_recipes = [E1, T1, K1, N1, R1, L1, P1, E2, T2, K2, N2, R2, L2, P2, E3, T3, K3, N3, R3, L3, P3, E4, T4, K4, N4, R4, L4, P4]
        search_list = []
        quantities_list = []
        lists = []
        proceed_to_quantities = false
        while proceed_to_quantities == false
            puts ""
            puts "Enter codes of recipes to add to search list, enter '=' to proceed with the search, or enter 'reset' to reset the list.".colorize(:green)
            recipe_input = gets.chomp.downcase
            if recipe_input == 'reset'
                search_list = []
                quantities_list = []
            elsif recipe_input == '='
                proceed_to_quantities = true
            elsif recipe_input == 'w1'
              $w1.each do |key, value|
                if search_list.include?(key)
                  index = search_list.index(key)
                  quantities_list[index] += value
                else
                  search_list.push(key)
                  quantities_list.push(value)
                end
              end
            elsif recipe_input == 'w2'
              $w2.each do |key, value|
                if search_list.include?(key)
                  index = search_list.index(key)
                  quantities_list[index] += value
                else
                  search_list.push(key)
                  quantities_list.push(value)
                end
              end
            elsif recipe_input == 'w3'
              $w3.each do |key, value|
                if search_list.include?(key)
                  index = search_list.index(key)
                  quantities_list[index] += value
                else
                  search_list.push(key)
                  quantities_list.push(value)
                end
              end
            elsif recipe_input == 'w4'
              $w4.each do |key, value|
                if search_list.include?(key)
                  index = search_list.index(key)
                  quantities_list[index] += value
                else
                  search_list.push(key)
                  quantities_list.push(value)
                end
              end
            elsif recipe_input == 'mth'
              $mth.each do |key, value|
                if search_list.include?(key)
                  index = search_list.index(key)
                  quantities_list[index] += value
                else
                  search_list.push(key)
                  quantities_list.push(value)
                end
              end
            else
              all_recipes.each do |recipe|
                if (recipe_input.include?("1") || recipe_input.include?("2") || recipe_input.include?("3") || recipe_input.include?("4")) && recipe.name.downcase.include?(recipe_input)
                  recipe.ingredients.each do |key, value|
                    if search_list.include?(key)
                      index = search_list.index(key)
                      quantities_list[index] += value
                    else
                      search_list.push(key)
                      quantities_list.push(value)
                    end
                  end
                  puts "Search list successfully updated with ingredients from recipe #{recipe.name}.".colorize(:cyan)
                end
              end
            end
            if recipe_input != '='
              puts ""
              puts "Items currently in search list:".colorize(:cyan)
              if search_list.length == 0
                puts "None.".colorize(:red)
              else
                numerator = 0
                search_list.each do |item|
                  puts "#{numerator+1}. #{item.capitalize} (#{quantities_list[numerator]})"
                  numerator += 1
                end
              end
            end
        end
        lists.push(search_list)
        lists.push(quantities_list)
        lists
    end
end

def recipe_search_mode(mode_is) # Hidden mode for personal use
  if mode_is == 'recipe'
    interface = Recipe_Search_Interface.new

    lists = interface.build_recipe_search_list
    search_list = lists[0]
    quantities_list = lists[1]
    max_retrieve = interface.get_max_retrieve_input

    coop_results = List_Search.coop(search_list, max_retrieve)
    prisma_results = List_Search.prisma(search_list, max_retrieve)
    rimi_results = List_Search.rimi(search_list, max_retrieve)
    selver_results = List_Search.selver(search_list, max_retrieve)

    coop_cheapest = List_Search.found_cheapest_items_lister(coop_results)
    prisma_cheapest = List_Search.found_cheapest_items_lister(prisma_results)
    rimi_cheapest = List_Search.found_cheapest_items_lister(rimi_results)
    selver_cheapest = List_Search.found_cheapest_items_lister(selver_results)

    coop_missing = List_Search.missing_items_lister(coop_results)
    prisma_missing = List_Search.missing_items_lister(prisma_results)
    rimi_missing = List_Search.missing_items_lister(rimi_results)
    selver_missing = List_Search.missing_items_lister(selver_results)

    coop_successful_queries = List_Search.successful_query_lister(coop_missing, search_list)
    prisma_successful_queries = List_Search.successful_query_lister(prisma_missing, search_list)
    rimi_successful_queries = List_Search.successful_query_lister(rimi_missing, search_list)
    selver_successful_queries = List_Search.successful_query_lister(selver_missing, search_list)

    coop_cheapest_items_names = cheapest_items_names_lister(coop_cheapest)
    prisma_cheapest_items_names = cheapest_items_names_lister(prisma_cheapest)
    rimi_cheapest_items_names = cheapest_items_names_lister(rimi_cheapest)
    selver_cheapest_items_names = cheapest_items_names_lister(selver_cheapest)

    coop_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, coop_successful_queries)
    prisma_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, prisma_successful_queries)
    rimi_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, rimi_successful_queries)
    selver_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, selver_successful_queries)

    coop_total = calculate_totals(coop_cheapest, quantities_list)
    prisma_total = calculate_totals(prisma_cheapest, quantities_list)
    rimi_total = calculate_totals(rimi_cheapest, quantities_list)
    selver_total = calculate_totals(selver_cheapest, quantities_list)

    coop_incomplete_total = calculate_incomplete_cart_totals(coop_cheapest, coop_found_items_quantities, quantities_list)
    prisma_incomplete_total = calculate_incomplete_cart_totals(prisma_cheapest, prisma_found_items_quantities, quantities_list)
    rimi_incomplete_total = calculate_incomplete_cart_totals(rimi_cheapest, rimi_found_items_quantities, quantities_list)
    selver_incomplete_total = calculate_incomplete_cart_totals(selver_cheapest, selver_found_items_quantities, quantities_list)

    interface.sort_and_display_list_search_results(coop_total, prisma_total, rimi_total, selver_total)
    interface.display_detailed_list_search_results(coop_cheapest, prisma_cheapest, rimi_cheapest, selver_cheapest,
                                                   coop_cheapest_items_names, prisma_cheapest_items_names, rimi_cheapest_items_names, selver_cheapest_items_names,
                                                   coop_found_items_quantities, prisma_found_items_quantities, rimi_found_items_quantities, selver_found_items_quantities,
                                                   coop_successful_queries, prisma_successful_queries, rimi_successful_queries, selver_successful_queries,
                                                   coop_total, prisma_total, rimi_total, selver_total,
                                                   coop_incomplete_total, prisma_incomplete_total, rimi_incomplete_total, selver_incomplete_total,
                                                   coop_missing, prisma_missing, rimi_missing, selver_missing)
    mode_is = nil
  end
end
