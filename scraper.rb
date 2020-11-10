require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'

interface = Interface.new

loop do
  query = interface.get_search_input
  max_results = interface.get_max_results_input
  results = Search.coop(query, max_results)
  interface.display_results(max_results, results)
end
