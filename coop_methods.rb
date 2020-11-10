require 'nokogiri'
require 'open-uri'
require 'uri'

class MakeResults
  # Incase you haven't seen this syntax yet for arguments: 
  # these are called named arguments and they are nice because the 
  # order of the arguments doesn't matter
  def self.forCoop(names:, prices:)
    grouped_coop_results = {}
    for i in 0...names.length do
      # Occasionally throws errors where using .text here:
      grouped_coop_results[names[i].text] = [prices[i].text.split(' · ')[1].split('€')[0].to_f,
                                                  (' €' + (prices[i]).text.split(' · ')[1].split('€')[1])]
    end
    grouped_coop_results
  end
end

class Search
  def self.coop(query, max_results)
    page = Nokogiri::HTML(URI.open(BuildSearchUrl.forCoop(query)))
    names = page.css("div.item-name")[0..max_results-1]
    prices =  page.css("div.item-count")[0..max_results-1]
    # Named arguments
    # can also write like this:
    # MakeResults.forCoop({names: names, prices: prices})
    MakeResults.forCoop(names: names, prices: prices)
  end
end

class BuildSearchUrl
  COOP_BASE_URL = "https://ecoop.ee/et/otsing/"

  def self.forCoop(query)
    url = URI(COOP_BASE_URL)
    url.query = URI.encode_www_form([["otsing", query ]])
    url
  end
end
# This looks like a common method for normalized results.
def sort_coop_results
  $sorted_coop_results = $grouped_coop_results.sort_by {|key, value| value[0]}.to_h
end

