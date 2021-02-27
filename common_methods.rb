class Single_Search_Interface
  def get_search_input
    puts("")
    puts("Enter search term(s).".colorize(:green))
    gets.chomp
  end

  def get_max_retrieve_input
    max_retrieve_input = nil
    while(max_retrieve_input.nil? || max_retrieve_input < 1)
      puts("")
      puts("Enter maximum number of results to retrieve for sorting from each store. Must be at least 1.".colorize(:green))
      max_retrieve_input = gets.chomp.to_i
      if max_retrieve_input < 1
        puts("")
        puts("Invalid input.".colorize(:red))
      end
    end
    max_retrieve_input
  end

  def get_max_display_input
    max_display_input = nil
    while(max_display_input.nil?)
      puts("")
      puts("Enter maximum number of results to display after sorting. Must be at least 1.".colorize(:green))
      puts("To display all retrieved results, enter 'all'.".colorize(:green))
      max_display_input = gets.chomp
      if max_display_input.downcase == "all"
        max_display_input = max_display_input.downcase
      else
        max_display_input = max_display_input.to_i
        if max_display_input < 1
          puts("")
          puts("Invalid input.".colorize(:red))
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
    puts("Displaying #{limited_sorted_results.length} lowest-priced item(s) from retrieved results, ordered by price (ascending):".colorize(:color => :cyan, :background => :black))
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
        search_initiated = false
        while search_initiated == false
            puts ""
            puts "Enter items to add to search list, enter '=' to initiate search, or enter 'reset' to reset the list".colorize(:green)
            input = gets.chomp
            if input == 'reset'
                search_list = []
            elsif input == '='
                search_initiated = true
            else
                search_list.push(input)
                puts "Items currently in search list: #{search_list}"
            end
        end
        search_list
    end

    def get_max_retrieve_input
        max_retrieve_input = nil
        while(max_retrieve_input.nil? || max_retrieve_input < 1)
          puts("")
          puts("Enter maximum number of results to retrieve from each store. Must be at least 1.".colorize(:green))
          max_retrieve_input = gets.chomp.to_i
          if max_retrieve_input < 1
            puts("")
            puts("Invalid input.".colorize(:red))
          end
        end
        max_retrieve_input
      end
end
