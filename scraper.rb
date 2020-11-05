require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'

loop do
  get_search_input()
  get_max_results_input()
  run_coop_search()
  determine_coop_results_to_display()
  group_coop_results()
  sort_coop_results()
  display_coop_results()
end
