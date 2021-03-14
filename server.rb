require 'sinatra'
require_relative 'gem_requires'
require_relative 'common_methods.rb'
require_relative 'coop_methods.rb'
require_relative 'prisma_methods.rb'
require_relative 'selver_methods.rb'
require_relative 'rimi_methods.rb'
require_relative 'recipe_search_mode.rb'

get '/' do
    "<div style='background-color:seagreen; height: 100vh; width: 100vw; text-align:center; position:absolute; top:0; left:0;'>
        #{WebInterface.searchForm()}
    </div>"
end

post '/' do
    max_results = 3
    coop_results = Search.coop(params['product'], max_results)
    "<div style='background-color:tomato; height: 100vh; width: 100vw; text-align:center; position:absolute; top:0; left:0;'>
    #{WebInterface.searchForm()}
    #{WebInterface.searchResults(coop_results)}
    <a href='/hey/this/is/another/path'>Click me</a>
    </div>"
end

get '/hey/this/is/another/path' do
    "<div style='background-color:tomato; height: 100vh; width: 100vw; text-align:center; position:absolute; top:0; left:0;'>
        <h1>This is just another example path</h1>
    </div>"
end
