# This is the single/unorganised draft file I started out with (for reference and maybe a simpler overview of everything)

require 'nokogiri'
require 'open-uri'

puts("")
puts("Enter search term(s).")
search = gets.chomp.split(' ').join('+')

puts("")
puts("Enter maximum number of results to display. Must be at least 1.")
max_results = gets.chomp.to_i

coop = Nokogiri::HTML(open("https://ecoop.ee/et/otsing/?otsing=#{search}"))
coop_results_name = coop.css('div.item-name')
coop_results_price = coop.css('div.item-count')

results_hash = {}

for i in 0...max_results do
  results_hash[(coop_results_name[i].text)] = [(coop_results_price[i].text.split(' · ')[1].split('€')[0].to_f),
                                             (' €' + (coop_results_price[i].text.split(' · ')[1].split('€')[1]))]
end

sorted_results_hash = results_hash.sort_by {|k, v| v[0]}.to_h

sorted_results_hash.each {|k, v|
    puts k
    puts v[0].to_s + v[1]
    puts ''
  }
