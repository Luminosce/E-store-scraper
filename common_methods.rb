require 'colorize'

# This looks like the user interface
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

  def display_results(determined_results_to_display, results)
    puts("")
    puts("Displaying #{determined_results_to_display} first item(s) in results, ordered by price (ascending):".colorize(:cyan))
    puts("")
    results.each do |key, value|
        puts key
        puts value[0].to_s + value[1]
        puts ''
    end
  end
end

def sort_results(grouped_results)
  grouped_results.sort_by {|key, value| value[0]}.to_h
end
