require_relative 'gem_requires'
require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'
require_relative 'prisma_methods.rb'
require_relative 'selver_methods.rb'
require_relative 'rimi_methods.rb'
require_relative 'recipe_search_mode.rb'

interface = Main_Interface.new

loop do
  mode_is = interface.select_mode
  single_search_mode(mode_is)
  list_search_mode(mode_is)
  recipe_search_mode(mode_is) # Hidden mode for personal use
end
