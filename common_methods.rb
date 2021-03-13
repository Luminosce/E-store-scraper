class Main_Interface
  def select_mode
    mode_is = nil
    while mode_is == nil
      puts ""
      puts "Enter 'single' to run a single-item search or enter 'list' to run a list-based search.".colorize(:green)
      mode_input = gets.chomp.downcase
      if mode_input == 'single' || mode_input == 'list'
        mode_is = mode_input
      else
        puts ""
        puts "Invalid input.".colorize(:red)
      end
    end
    mode_is
  end
end

class Single_Search_Interface
  def get_search_input
    puts ""
    puts "Enter search term(s).".colorize(:green)
    gets.chomp
  end

  def get_max_retrieve_input
    max_retrieve_input = nil
    while(max_retrieve_input.nil? || max_retrieve_input < 1)
      puts ""
      puts "Enter maximum number of results to retrieve for sorting from each store. Must be at least 1. (Recommended: 5 to 10)".colorize(:green)
      max_retrieve_input = gets.chomp.to_i
      if max_retrieve_input < 1
        puts ""
        puts "Invalid input.".colorize(:red)
      end
    end
    max_retrieve_input
  end

  def get_max_display_input
    max_display_input = nil
    while(max_display_input.nil?)
      puts ""
      puts "Enter maximum number of results to display for all stores combined after sorting. Must be at least 1.".colorize(:green)
      puts "To display all retrieved results, enter 'all'.".colorize(:green)
      max_display_input = gets.chomp
      if max_display_input.downcase == "all"
        max_display_input = max_display_input.downcase
      else
        max_display_input = max_display_input.to_i
        if max_display_input < 1
          puts ""
          puts "Invalid input.".colorize(:red)
          max_display_input = nil
        end
      end
    end
    max_display_input
  end

  def display_results(limited_sorted_results)
    puts ''
    puts ''
    puts ''
    puts "Displaying #{limited_sorted_results.length} lowest-priced item(s) from retrieved results, ordered by price (ascending):".colorize(:color => :cyan, :background => :black)
    puts ''
    puts '--Start of list--'.colorize(:color => :cyan, :background => :black)
    puts ''
    limited_sorted_results.each do |key, value|
      if key.include? 'Coop'
        puts key.colorize(:cyan)
        puts (value[0].to_s + value[1]).colorize(:cyan)
        puts ''
      elsif key.include? 'Prisma'
        puts key.colorize(:green)
        puts (value[0].to_s + value[1]).colorize(:green)
        puts ''
      elsif key.include? 'Selver'
        puts key
        puts (value[0].to_s + value[1])
        puts ''
      elsif key.include? 'Rimi'
        puts key.colorize(:red)
        puts (value[0].to_s + value[1]).colorize(:red)
        puts ''
      end
    end
    puts '--End of list--'.colorize(:color => :cyan, :background => :black)
    puts ''
    puts ''
  end
end

def combine_results(coop_results = {}, prisma_results = {}, selver_results = {}, rimi_results = {})
  puts ""
  puts "Total results retrieved: #{coop_results.length + prisma_results.length + selver_results.length + rimi_results.length}."
  puts ""
  puts "Combining all retrieved results..."
  combined_results = coop_results.merge(prisma_results, selver_results, rimi_results)
end

def sort_and_limit_results(grouped_results, max_display)
  puts ""
  puts "Sorting combined results by price and limiting to the specified number..."
  sorted_results = grouped_results.sort_by {|key, value| value[0]}.to_h
  if max_display == "all"
    limited_sorted_results = sorted_results
  else
    limited_sorted_results = sorted_results.to_a[0...max_display].to_h
  end
  limited_sorted_results
end

def single_search_mode(mode_is)
  if mode_is == 'single'
    interface = Single_Search_Interface.new

    query = interface.get_search_input
    max_retrieve = interface.get_max_retrieve_input
    max_display = interface.get_max_display_input

    coop_results = Search.coop(query, max_retrieve)
    prisma_results = Search.prisma(query, max_retrieve)
    selver_results = Search.selver(query, max_retrieve)
    rimi_results = Search.rimi(query, max_retrieve)

    combined_results = combine_results(coop_results, prisma_results, selver_results, rimi_results)
    limited_sorted_results = sort_and_limit_results(combined_results, max_display)

    interface.display_results(limited_sorted_results)
    mode_is == nil
  end
end

class WebInterface
  def self.searchForm
      "<form method='post' style='margin: 20px auto; width: 50%'>
      <h1>Mille hinda soovid teada?</h1>
      <input type='text' name='product' />
      <input style='color:blue;' type='submit' value='Otsi' />
      </form>"
  end

  def self.searchResults(results)
    htmlResults = results.map do|(name, price)|
      "<div><h3>#{name}</h3><p>#{price.join(' ')}</p></div>"
    end

    "<div style='margin: 20px auto;  width: 50%'><h1>Otsingu tulemused</h1>#{htmlResults.join(' ')}</div>"
  end
end

class List_Search_Interface
    def build_search_list
        search_list = []
        proceed_to_quantities = false
        while proceed_to_quantities == false
            puts ""
            puts "Enter items to add to search list, enter '=' to proceed to entry of quantities, enter 'del' to delete last entered item, or enter 'reset' to reset the list.".colorize(:green)
            item_input = gets.chomp
            if item_input.downcase == 'reset'
                search_list = []
            elsif item_input.downcase == 'del'
                search_list.pop()
            elsif item_input == '='
                proceed_to_quantities = true
            elsif search_list.include? item_input
                puts ""
                puts "Error. Repeat entry of items is not allowed.".colorize(:red)
            else
                search_list.push(item_input)
                puts ""
                puts "Item '#{item_input}' successfully added to list.".colorize(:cyan)
            end
            puts ""
            puts "Items currently in search list:".colorize(:cyan)
            if search_list.length == 0
              puts "None.".colorize(:red)
            else
              puts search_list
            end
        end
        search_list
    end

    def build_quantities_list(search_list)
      quantities_list = []
      begin
        search_list.each do |item|
          quantity_entered = false
          while quantity_entered == false
            puts ""
            puts "Enter quantity for item '#{item}' in grams or millilitres (or pieces for, e.g., eggs), or enter 'reset' to reset the list of quantities.".colorize(:green)
            quantity_input = gets.chomp
            if quantity_input == 'reset'
              quantities_list = []
              puts ""
              puts "Quantities list successfully reset.".colorize(:cyan)
              raise
            elsif quantity_input.to_i < 1
              puts ""
              puts "Invalid input.".colorize(:red)
            else
              quantities_list.push(quantity_input.to_i)
              quantity_entered = true
              puts ""
              puts "Quantity '#{quantity_input} (g, ml, or pcs)' successfully added for item '#{item}'.".colorize(:cyan)
            end
          end
        end
      rescue
        retry
      end
      quantities_list
    end

    def get_max_retrieve_input
        max_retrieve_input = nil
        while(max_retrieve_input.nil? || max_retrieve_input < 1)
          puts ""
          puts "Enter maximum number of results to retrieve for each item from each store. Must be at least 1. (Recommended: 5 to 10)".colorize(:green)
          max_retrieve_input = gets.chomp.to_i
          if max_retrieve_input < 1
            puts ""
            puts "Invalid input.".colorize(:red)
          end
        end
        max_retrieve_input
    end

    def sort_and_display_list_search_results(coop_total, prisma_total, rimi_total, selver_total)
      total_sorter = {}
      display_coop_total = true
      display_prisma_total = true
      display_rimi_total = true
      display_selver_total = true

      if coop_total == 0
        display_coop_total = false
        puts ""
        puts "Coop shopping cart total has been discarded from results, because one or more items were not found for Coop.".colorize(:red)
      else
        total_sorter["Coop shopping cart total:"] = coop_total
      end

      if prisma_total == 0
        display_prisma_total = false
        puts ""
        puts "Prisma shopping cart total has been discarded from results, because one or more items were not found for Prisma.".colorize(:red)
      else
        total_sorter["Prisma shopping cart total:"] = prisma_total
      end

      if rimi_total == 0
        display_rimi_total = false
        puts ""
        puts "Rimi shopping cart total has been discarded from results, because one or more items were not found for Rimi.".colorize(:red)
      else
        total_sorter["Rimi shopping cart total:"] = rimi_total
      end

      if selver_total == 0
        display_selver_total = false
        puts ""
        puts "Selver shopping cart total has been discarded from results, because one or more items were not found for Selver.".colorize(:red)
      else
        total_sorter["Selver shopping cart total:"] = selver_total
      end

      total_sorter = total_sorter.sort_by{|key, value| value}.to_h

      puts ""
      puts "Displaying shopping cart totals in ascending order: ".colorize(:color => :cyan, :background => :black)
      puts ''
      puts '--Start of list--'.colorize(:color => :cyan, :background => :black)
      puts ''

      total_sorter.each do |key, value|
        if key.include? 'Coop'
          puts "#{key} €#{value}".colorize(:cyan)
        elsif key.include? 'Prisma'
          puts "#{key} €#{value}".colorize(:green)
        elsif key.include? 'Rimi'
          puts "#{key} €#{value}".colorize(:red)
        elsif key.include? 'Selver'
          puts "#{key} €#{value}"
        end
      end

      puts ''
      puts '--End of list--'.colorize(:color => :cyan, :background => :black)
      puts ''
    end

    def display_detailed_list_search_results(coop_cheapest, prisma_cheapest, rimi_cheapest, selver_cheapest, quantities_list)
      new_entered = false
      while new_entered == false
        puts ""
        puts "Enter name of store to see detailed results for that store, or enter 'new' to run a new search.".colorize(:green)
        input = gets.chomp.downcase
        if input == "coop"
          i = 0
          coop_cheapest.each do |key, value|
            puts ""
            puts key.colorize(:color => :cyan, :background => :black)
            puts (value[0].to_s + value[1]).colorize(:color => :cyan, :background => :black)
            puts "Value of this item in searched for quantity (#{quantities_list[i]} g, ml, or pcs): €#{(value[0] * quantities_list[i]/1000).round(2)}".colorize(:cyan)
            i += 1
          end
        elsif input == "prisma"
          i = 0
          prisma_cheapest.each do |key, value|
            puts ""
            puts key.colorize(:color => :green, :background => :black)
            puts (value[0].to_s + value[1]).colorize(:color => :green, :background => :black)
            puts "Value of this item in searched for quantity (#{quantities_list[i]} g, ml, or pcs): €#{(value[0] * quantities_list[i]/1000).round(2)}".colorize(:green)
            i += 1
          end
        elsif input == "rimi"
          i = 0
          rimi_cheapest.each do |key, value|
            puts ""
            puts key.colorize(:color => :red, :background => :black)
            puts (value[0].to_s + value[1]).colorize(:color => :red, :background => :black)
            puts "Value of this item in searched for quantity (#{quantities_list[i]} g, ml, or pcs): €#{(value[0] * quantities_list[i]/1000).round(2)}".colorize(:red)
            i += 1
          end
        elsif input == "selver"
          i = 0
          selver_cheapest.each do |key, value|
            puts ""
            puts key.colorize(:color => :white, :background => :black)
            puts (value[0].to_s + value[1]).colorize(:color => :white, :background => :black)
            puts "Value of this item in searched for quantity (#{quantities_list[i]} g, ml, or pcs): €#{(value[0] * quantities_list[i]/1000).round(2)}"
            i += 1
          end
        elsif input != 'new'
          puts ""
          puts "Invalid input.".colorize(:red)
        else
          new_entered = true
        end
      end
    end
end

def sort_and_limit_results_for_list(grouped_results)
  sorted_results = grouped_results.sort_by {|key, value| value[0]}.to_h
  limited_sorted_results = sorted_results.to_a[0...1].to_h
  limited_sorted_results
end

class List_Search
  def self.coop(search_list, max_retrieve)
    cheapest_items = {}
    search_list.each do |item|
      coop_results = Search.coop(item, max_retrieve)
      cheapest_item = sort_and_limit_results_for_list(coop_results)
      cheapest_items = cheapest_items.merge(cheapest_item)
    end
    cheapest_items
  end

  def self.prisma(search_list, max_retrieve)
    cheapest_items = {}
    search_list.each do |item|
      prisma_results = Search.prisma(item, max_retrieve)
      cheapest_item = sort_and_limit_results_for_list(prisma_results)
      cheapest_items = cheapest_items.merge(cheapest_item)
    end
    cheapest_items
  end

  def self.selver(search_list, max_retrieve)
    cheapest_items = {}
    search_list.each do |item|
      selver_results = Search.selver(item, max_retrieve)
      cheapest_item = sort_and_limit_results_for_list(selver_results)
      cheapest_items = cheapest_items.merge(cheapest_item)
    end
    cheapest_items
  end

  def self.rimi(search_list, max_retrieve)
    cheapest_items = {}
    search_list.each do |item|
      rimi_results = Search.rimi(item, max_retrieve)
      cheapest_item = sort_and_limit_results_for_list(rimi_results)
      cheapest_items = cheapest_items.merge(cheapest_item)
    end
    cheapest_items
  end
end

def calculate_totals(cheapest_items, quantities_list)
  i = 0
  shopping_cart_total = 0
  if cheapest_items.length == quantities_list.length
    cheapest_items.each do |key, value|
      if value[1] == '€/tk' || value[1] == '€/pcs'
        item_quantity_price = value[0] * quantities_list[i]
        shopping_cart_total += item_quantity_price
        i += 1
      else
        item_quantity_price = value[0] * quantities_list[i]/1000
        shopping_cart_total += item_quantity_price
        i += 1
      end
    end
  end
  shopping_cart_total.round(2)
end

def list_search_mode(mode_is)
  if mode_is == 'list'
    interface = List_Search_Interface.new

    search_list = interface.build_search_list
    quantities_list = interface.build_quantities_list(search_list)
    max_retrieve = interface.get_max_retrieve_input

    coop_cheapest = List_Search.coop(search_list, max_retrieve)
    prisma_cheapest = List_Search.prisma(search_list, max_retrieve)
    selver_cheapest = List_Search.selver(search_list, max_retrieve)
    rimi_cheapest = List_Search.rimi(search_list, max_retrieve)

    coop_total = calculate_totals(coop_cheapest, quantities_list)
    prisma_total = calculate_totals(prisma_cheapest, quantities_list)
    selver_total = calculate_totals(selver_cheapest, quantities_list)
    rimi_total = calculate_totals(rimi_cheapest, quantities_list)

    interface.sort_and_display_list_search_results(coop_total, prisma_total, rimi_total, selver_total)
    interface.display_detailed_list_search_results(coop_cheapest, prisma_cheapest, rimi_cheapest, selver_cheapest, quantities_list)
    mode_is == nil
  end
end
