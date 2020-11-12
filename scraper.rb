require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'

interface = Interface.new

loop do
  query = interface.get_search_input
  max_results = interface.get_max_results_input
  coop_results = Search.coop(query, max_results)
  sorted_coop_results = sort_results(coop_results)
  interface.display_results(max_results, sorted_coop_results)
end
