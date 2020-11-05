require 'nokogiri'
require 'open-uri'
require 'uri'

def run_coop_search
  search_input_converted_for_coop = $search_input.split(' ').join('+')
  coop_search_url =  "https://ecoop.ee/et/otsing/?otsing=" + search_input_converted_for_coop
  # When using special characters in the search input (ö, ä, ü, õ),
  # using only 'Nokogiri::HTML(open($coop_search_url))' here
  # returns some kind of encoding error instead of the internal server error I'm currently getting'
  coop_search_page = Nokogiri::HTML(open(URI.parse(URI.escape(coop_search_url))))
  $coop_results_name = coop_search_page.css('div.item-name') # These are the found product names
  $coop_results_price = coop_search_page.css('div.item-count') # These are the found product prices
end

def determine_coop_results_to_display
  if $max_results_input > $coop_results_name.length
    $coop_results_to_display = $coop_results_name.length
  else
    $coop_results_to_display = $max_results_input
  end
end

def group_coop_results
  $grouped_coop_results = {}
  for i in 0...$coop_results_to_display do
    # Occasionally throws errors where using .text here:
    $grouped_coop_results[$coop_results_name[i].text] = [$coop_results_price[i].text.split(' · ')[1].split('€')[0].to_f,
                                               (' €' + ($coop_results_price[i]).text.split(' · ')[1].split('€')[1])]
  end
end

def sort_coop_results
  $sorted_coop_results = $grouped_coop_results.sort_by {|key, value| value[0]}.to_h
end

def display_coop_results
  display_results_listing_text($coop_results_to_display)
  $sorted_coop_results.each {|key, value|
      puts key
      puts value[0].to_s + value[1]
      puts ''
    }
end
