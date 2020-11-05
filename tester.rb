require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'

loop do
  get_max_results_input()
  reset_input($max_results_input)
  puts($max_results_input)
end
