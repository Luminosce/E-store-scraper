class MakeResults
  def self.forSelver(names:, prices:)
    grouped_selver_results = {}
    for i in 0...names.length do
      grouped_selver_results['Selver: ' + names[i].text] = [prices[i].text.split(' ')[0].gsub(',', '.').to_f,
                                               (' ' + (prices[i]).text.split(' ')[1])]
    end
    grouped_selver_results
  end
end

class Search
  def self.selver(query, max_results)
    puts ""
    puts "Retrieving first #{max_results} results from Selver..."
    begin
      page = Nokogiri::HTML(URI.open(BuildSearchUrl.forSelver(query)))
      names = page.css("h5.product-name")[0..max_results-1]
      prices =  page.css("span.unit-price")[0..max_results-1]
      if names.length == 0
        puts ''
        puts "No such items found for Selver.".colorize(:red)
      end
      MakeResults.forSelver(names: names, prices: prices)
    rescue NoMethodError
      selver_results = {}
    end
  end
end

class BuildSearchUrl
  SELVER_BASE_URL = "https://www.selver.ee/catalogsearch/result/"

  def self.forSelver(query)
    url = URI(SELVER_BASE_URL)
    url.query = URI.encode_www_form([["q", query ]])
    url
  end
end
