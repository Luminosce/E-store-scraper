class List_Search_Interface
    def build_search_list
        search_list = []
        search_initiated = false
        while search_initiated == false
            puts ""
            puts "Enter items to add to search list, enter '=' to initiate search, or enter 'reset' to reset the list".colorize(:green))
            input = gets.chomp
            if input == 'reset'
                search_list = []
            elsif input == '='
                search_initiated = true
            else
                search_list.push(input)
                puts "Items currently in search list: #{search_list}"
            end
        end
        search_list
    end

    def get_max_results_input
        max_results_input = nil
        while(max_results_input.nil? || max_results_input < 1)
          puts("")
          puts("Enter maximum number of results to look at for each searched vendor. Must be at least 1.".colorize(:green))
          max_results_input = gets.chomp.to_i
          if max_results_input < 1
            puts("")
            puts("Invalid input.".colorize(:red))
          end
        end
        max_results_input
      end
end

class MakeResults
    def self.forCoop(names:, prices:)
      grouped_coop_results = {}
      for i in 0...names.length do
        grouped_coop_results['Coop: ' + names[i].text] = [prices[i].text.split(' · ')[1].split('€')[0].to_f,
                                               (' €' + (prices[i]).text.split(' · ')[1].split('€')[1])]
      end
      grouped_coop_results
    end
end
  
class Search
    def self.coop(query, max_results)
      begin
        page = Nokogiri::HTML(URI.open(BuildSearchUrl.forCoop(query)))
        names = page.css("div.item-name")[0..max_results-1]
        prices =  page.css("div.item-count")[0..max_results-1]
        MakeResults.forCoop(names: names, prices: prices)
      rescue NoMethodError
        puts ''
        puts "Item '#{query}' not found for Coop."
      end
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