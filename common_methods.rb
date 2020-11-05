require 'colorize'

def get_search_input
  puts("")
  puts("Enter search term(s).".colorize(:green))
  $search_input = gets.chomp
end

def get_max_results_input
  max_results_input_entered = false
  while defined?($max_results_input).nil? || $max_results_input < 1 || max_results_input_entered == false
    puts("")
    puts("Enter maximum number of results to display. Must be at least 1.".colorize(:green))
    $max_results_input = gets.chomp.to_i
    max_results_input_entered = true
    if $max_results_input < 1
      puts("")
      puts("Invalid input.".colorize(:red))
    end
  end
end

def display_results_listing_text(determined_results_to_display)
  puts("")
  puts("Displaying #{determined_results_to_display} first item(s) in results, ordered by price (ascending):".colorize(:cyan))
  puts("")
end
