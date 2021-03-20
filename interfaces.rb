class Main_Interface
  def select_mode
    mode_is = nil
    while mode_is == nil
      puts ""
      puts "Enter 'single' to run a single-item search or enter 'list' to run a list-based search.".colorize(:green)
      mode_input = gets.chomp.downcase
      if mode_input == 'single' || mode_input == 'list' || mode_input == 'recipe'
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
    search_input = gets.chomp.force_encoding("windows-1257").encode("utf-8", replace: nil)
    search_input
  end

  def get_max_retrieve_input
    max_retrieve_input = nil
    while(max_retrieve_input.nil? || max_retrieve_input < 1)
      puts ""
      puts "Enter maximum number of results to retrieve for sorting from each store. Must be at least 1. (Recommended: 3 to 6)".colorize(:green)
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

class List_Search_Interface
    def build_search_list
        search_list = []
        proceed_to_quantities = false
        while proceed_to_quantities == false
            puts ""
            puts "Enter items to add to search list, enter '=' to proceed to entry of quantities, enter 'del' to delete last entered item, or enter 'reset' to reset the list.".colorize(:green)
            item_input = gets.chomp.force_encoding("windows-1257").encode("utf-8", replace: nil)
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
          puts "Enter maximum number of results to retrieve for each item from each store. Must be at least 1. (Recommended: 3 to 6)".colorize(:green)
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
        puts "Coop shopping cart total has been discarded from results, because one or more items could not be found.".colorize(:red)
      else
        total_sorter["Coop shopping cart total:"] = coop_total
      end

      if prisma_total == 0
        display_prisma_total = false
        puts ""
        puts "Prisma shopping cart total has been discarded from results, because one or more items could not be found.".colorize(:red)
      else
        total_sorter["Prisma shopping cart total:"] = prisma_total
      end

      if rimi_total == 0
        display_rimi_total = false
        puts ""
        puts "Rimi shopping cart total has been discarded from results, because one or more items could not be found.".colorize(:red)
      else
        total_sorter["Rimi shopping cart total:"] = rimi_total
      end

      if selver_total == 0
        display_selver_total = false
        puts ""
        puts "Selver shopping cart total has been discarded from results, because one or more items could not be found.".colorize(:red)
      else
        total_sorter["Selver shopping cart total:"] = selver_total
      end

      total_sorter = total_sorter.sort_by{|key, value| value}.to_h

      puts ""
      puts "Displaying totals for complete shopping carts in ascending order: ".colorize(:color => :cyan, :background => :black)
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

    def display_detailed_list_search_results(coop_cheapest, prisma_cheapest, rimi_cheapest, selver_cheapest,
                                             coop_cheapest_items_names, prisma_cheapest_items_names, rimi_cheapest_items_names, selver_cheapest_items_names,
                                             coop_found_items_quantities, prisma_found_items_quantities, rimi_found_items_quantities, selver_found_items_quantities,
                                             coop_successful_queries, prisma_successful_queries, rimi_successful_queries, selver_successful_queries,
                                             coop_total, prisma_total, rimi_total, selver_total,
                                             coop_incomplete_total, prisma_incomplete_total, rimi_incomplete_total, selver_incomplete_total,
                                             coop_missing, prisma_missing, rimi_missing, selver_missing)
      new_entered = false
      while new_entered == false
        puts ""
        puts "Enter name of store to see detailed results for that store, or enter 'new' to run a new search.".colorize(:green)
        puts "(Details can also be viewed for stores not included in the cart total value results for complete carts above.)".colorize(:green)
        input = gets.chomp.downcase
        if input == "coop"
          i = 0
          coop_cheapest.each do |item|
            puts ""
            puts "#{i+1}. Cheapest item found in Coop's search results for '#{coop_successful_queries[i]}':".colorize(:color => :cyan, :background => :black)
            puts coop_cheapest_items_names[i].colorize(:cyan)
            puts (item[1].to_s + item[2]).colorize(:cyan)
            puts "Value of this item in searched for quantity (#{coop_found_items_quantities[i]} g, ml, or pcs): ".colorize(:color => :cyan, :background => :black)
            if item[2].include?('tk') || item[2].include?('pcs')
              puts "€#{(item[1] * coop_found_items_quantities[i]).round(2)}".colorize(:color => :cyan, :background => :black)
            else
              puts "€#{(item[1] * coop_found_items_quantities[i]/1000).round(2)}".colorize(:color => :cyan, :background => :black)
            end
            i += 1
          end
          if coop_cheapest.length == 0
            puts ""
            puts "No items found from Coop.".colorize(:red)
          elsif coop_total > 0
            puts ""
            puts "Total value of this shopping cart (complete): €#{coop_total}".colorize(:color => :cyan, :background => :black)
          elsif coop_incomplete_total > 0
            puts ""
            puts "Total value of this shopping cart (incomplete): €#{coop_incomplete_total}".colorize(:color => :red, :background => :black)
            puts "Missing items: #{coop_missing.join(', ')}".colorize(:color => :red, :background => :black)
          end
        elsif input == "prisma"
          i = 0
          prisma_cheapest.each do |item|
            puts ""
            puts "#{i+1}. Cheapest item found in Prisma's search results for '#{prisma_successful_queries[i]}':".colorize(:color => :green, :background => :black)
            puts prisma_cheapest_items_names[i].colorize(:green)
            puts (item[1].to_s + item[2]).colorize(:green)
            puts "Value of this item in searched for quantity (#{prisma_found_items_quantities[i]} g, ml, or pcs): ".colorize(:color => :green, :background => :black)
            if item[2].include?('tk') || item[2].include?('pcs')
              puts "€#{(item[1] * prisma_found_items_quantities[i]).round(2)}".colorize(:color => :green, :background => :black)
            else
              puts "€#{(item[1] * prisma_found_items_quantities[i]/1000).round(2)}".colorize(:color => :green, :background => :black)
            end
            i += 1
          end
          if prisma_cheapest.length == 0
            puts ""
            puts "No items found from Prisma.".colorize(:red)
          elsif prisma_total > 0
            puts ""
            puts "Total value of this shopping cart (complete): €#{prisma_total}".colorize(:color => :green, :background => :black)
          elsif prisma_incomplete_total > 0
            puts ""
            puts "Total value of this shopping cart (incomplete): €#{prisma_incomplete_total}".colorize(:color => :red, :background => :black)
            puts "Missing items: #{prisma_missing.join(', ')}".colorize(:color => :red, :background => :black)
          end
        elsif input == "rimi"
          i = 0
          rimi_cheapest.each do |item|
            puts ""
            puts "#{i+1}. Cheapest item found in Rimi's search results for '#{rimi_successful_queries[i]}':".colorize(:color => :red, :background => :black)
            puts rimi_cheapest_items_names[i].colorize(:red)
            puts (item[1].to_s + item[2]).colorize(:red)
            puts "Value of this item in searched for quantity (#{rimi_found_items_quantities[i]} g, ml, or pcs): ".colorize(:color => :red, :background => :black)
            if item[2].include?('tk') || item[2].include?('pcs')
              puts "€#{(item[1] * rimi_found_items_quantities[i]).round(2)}".colorize(:color => :red, :background => :black)
            else
              puts "€#{(item[1] * rimi_found_items_quantities[i]/1000).round(2)}".colorize(:color => :red, :background => :black)
            end
            i += 1
          end
          if rimi_cheapest.length == 0
            puts ""
            puts "No items found from Rimi.".colorize(:red)
          elsif rimi_total > 0
            puts ""
            puts "Total value of this shopping cart (complete): €#{rimi_total}".colorize(:color => :red, :background => :black)
          elsif rimi_incomplete_total > 0
            puts ""
            puts "Total value of this shopping cart (incomplete): €#{rimi_incomplete_total}".colorize(:color => :red, :background => :black)
            puts "Missing items: #{rimi_missing.join(', ')}".colorize(:color => :red, :background => :black)
          end
        elsif input == "selver"
          i = 0
          selver_cheapest.each do |item|
            puts ""
            puts "#{i+1}. Cheapest item found in Selver's search results for '#{selver_successful_queries[i]}':".colorize(:color => :white, :background => :black)
            puts selver_cheapest_items_names[i]
            puts (item[1].to_s + item[2])
            puts "Value of this item in searched for quantity (#{selver_found_items_quantities[i]} g, ml, or pcs): ".colorize(:color => :white, :background => :black)
            if item[2].include?('tk') || item[2].include?('pcs')
              puts "€#{(item[1] * selver_found_items_quantities[i]).round(2)}".colorize(:color => :white, :background => :black)
            else
              puts "€#{(item[1] * selver_found_items_quantities[i]/1000).round(2)}".colorize(:color => :white, :background => :black)
            end
            i += 1
          end
          if selver_cheapest.length == 0
            puts ""
            puts "No items found from Selver.".colorize(:red)
          elsif selver_total > 0
            puts ""
            puts "Total value of this shopping cart (complete): €#{selver_total}".colorize(:color => :white, :background => :black)
          elsif selver_incomplete_total > 0
            puts ""
            puts "Total value of this shopping cart (incomplete): €#{selver_incomplete_total}".colorize(:color => :red, :background => :black)
            puts "Missing items: #{selver_missing.join(', ')}".colorize(:color => :red, :background => :black)
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
