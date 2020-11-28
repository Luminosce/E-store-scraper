class Interface
  def get_search_input
    puts("")
    puts("Enter search term(s).".colorize(:green))
    gets.chomp
  end

  def get_max_results_input
    max_results_input = nil
    while(max_results_input.nil? || max_results_input < 1)
      puts("")
      puts("Enter maximum number of results to display. Must be at least 1.".colorize(:green))
      max_results_input = gets.chomp.to_i
      if max_results_input < 1
        puts("")
        puts("Invalid input.".colorize(:red))
      end
    end
    max_results_input
  end

  def display_results(limited_sorted_results)
    puts ''
    puts ''
    puts ''
    puts("Displaying #{limited_sorted_results.length} lowest-priced item(s) from retrieved results, ordered by price (ascending):".colorize(:cyan))
    puts ''
    puts '--Start of list--'
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
        puts key.colorize(:red)
        puts (value[0].to_s + value[1]).colorize(:red)
        puts ''
      end
    end
    puts '--End of list--'
    puts ''
    puts ''
  end
end

def combine_results(coop_results = {}, prisma_results = {}, selver_results = {})
  puts ""
  puts "Total results retrieved: #{coop_results.length + prisma_results.length + selver_results.length}."
  puts ""
  puts "Combining all retrieved results..."
  combined_results = coop_results.merge(prisma_results, selver_results)
end

def sort_and_limit_results(grouped_results, max_results)
  puts ""
  puts "Sorting results by price and limiting to the specified number..."
  sorted_results = grouped_results.sort_by {|key, value| value[0]}.to_h
  limited_sorted_results = sorted_results.to_a[0...max_results].to_h
end
