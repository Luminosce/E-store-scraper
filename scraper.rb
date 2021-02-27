require_relative 'gem_requires'
require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'
require_relative 'prisma_methods.rb'
require_relative 'selver_methods.rb'
require_relative 'rimi_methods.rb'

interface = Single_Search_Interface.new

loop do
  query = interface.get_search_input
  max_retrieve = interface.get_max_retrieve_input
  max_display = interface.get_max_display_input
  coop_results = Search.coop(query, max_retrieve)
  prisma_results = Search.prisma(query, max_retrieve)
  selver_results = Search.selver(query, max_retrieve)
  rimi_results = Search.rimi(query, max_retrieve)
  combined_results = combine_results(coop_results, prisma_results, selver_results, rimi_results)
  limited_sorted_results = sort_and_limit_results(combined_results, max_display)
  interface.display_results(limited_sorted_results)
end
