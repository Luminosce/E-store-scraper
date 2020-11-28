class MakeResults
  def self.forRimi(names:, prices:)
    grouped_rimi_results = {}
    for i in 0...names.length do
      grouped_rimi_results['Rimi: ' + names[i].text] = [prices[i].text.split(' ')[0].gsub(',', '.').to_f,
                                               (' ' + (prices[i]).text.split(' ')[1])]
    end
    grouped_rimi_results
  end
end

class Search
  def self.rimi(query, max_results)
    puts ""
    puts "Retrieving first #{max_results} results from Rimi..."
    begin
      page = Nokogiri::HTML(URI.open(BuildSearchUrl.forRimi(query)))
      names = page.css("p.card__name")[0..max_results-1]
      prices =  page.css("p.card__price-per")[0..max_results-1]
      MakeResults.forRimi(names: names, prices: prices)
    rescue NoMethodError
      puts ''
      puts 'No such items found for Rimi.'
      rimi_results = {}
    end
  end
end

class BuildSearchUrl
  RIMI_BASE_URL = "https://www.rimi.ee/epood/ee/otsing"

  def self.forRimi(query)
    url = URI(RIMI_BASE_URL)
    url.query = URI.encode_www_form([["query", query ]])
    url
  end
end
