require_relative 'gem_requires'
require_relative 'common_methods.rb'
# require_relative 'coop_methods.rb'
require_relative 'prisma_methods.rb'

interface = Interface.new

loop do
  query = interface.get_search_input
  max_results = interface.get_max_results_input
  # coop_results = Search.coop(query, max_results)
  # sorted_coop_results = sort_results(coop_results)
  # interface.display_results(max_results, sorted_coop_results)
  prisma_results = Search.prisma(query, max_results)
  sorted_prisma_results = sort_results(prisma_results)
  interface.display_results(max_results, sorted_prisma_results)
end
