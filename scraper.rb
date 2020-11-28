require_relative 'gem_requires'
require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'
require_relative 'prisma_methods.rb'
require_relative 'selver_methods.rb'

interface = Interface.new

loop do
  query = interface.get_search_input
  max_results = interface.get_max_results_input
  coop_results = Search.coop(query, max_results)
  prisma_results = Search.prisma(query, max_results)
  selver_results = Search.selver(query, max_results)
  combined_results = combine_results(coop_results, prisma_results, selver_results)
  limited_sorted_results = sort_and_limit_results(combined_results, max_results)
  interface.display_results(limited_sorted_results)
end
