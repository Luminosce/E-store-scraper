def combine_results(coop_results = {}, prisma_results = {}, selver_results = {}, rimi_results = {})
  successful_coop_results = {}
  successful_coop_results = successful_coop_results.merge(coop_results)
  coop_results.each do |key, value|
    if key.include?('(not found)')
      successful_coop_results.delete(key)
    end
  end

  successful_prisma_results = {}
  successful_prisma_results = successful_prisma_results.merge(prisma_results)
  prisma_results.each do |key, value|
    if key.include?('(not found)')
      successful_prisma_results.delete(key)
    end
  end

  successful_selver_results = {}
  successful_selver_results = successful_selver_results.merge(selver_results)
  selver_results.each do |key, value|
    if key.include?('(not found)')
      successful_selver_results.delete(key)
    end
  end

  successful_rimi_results = {}
  successful_rimi_results = successful_rimi_results.merge(rimi_results)
  rimi_results.each do |key, value|
    if key.include?('(not found)')
      successful_rimi_results.delete(key)
    end
  end

  puts ""
  puts "Total results retrieved: #{successful_coop_results.length + successful_prisma_results.length + successful_selver_results.length + successful_rimi_results.length}."
  puts ""
  puts "Combining all retrieved results..."
  combined_results = successful_coop_results.merge(successful_prisma_results, successful_selver_results, successful_rimi_results)
end

def sort_and_limit_results(grouped_results, max_display)
  puts ""
  puts "Sorting combined results by price and limiting to the specified number..."
  sorted_results = grouped_results.sort_by {|key, value| value[0]}.to_h
  if max_display == "all"
    limited_sorted_results = sorted_results
  else
    limited_sorted_results = sorted_results.to_a[0...max_display].to_h
  end
  limited_sorted_results
end

def sort_and_limit_results_for_list(grouped_results)
  sorted_results = grouped_results.sort_by {|key, value| value[0]}.to_h
  limited_sorted_results = sorted_results.to_a[0...1].to_h
  limited_sorted_results
end

class List_Search
  def self.found_cheapest_items_lister(store_results)
    found_cheapest_items = {}
    found_cheapest_items = found_cheapest_items.merge(store_results)
    store_results.each do |key, value|
      if key.include?('(not found)')
        found_cheapest_items.delete(key)
      end
    end
    found_cheapest_items
  end

  def self.missing_items_lister(store_results)
    missing_items_hash = {}
    missing_items_hash = missing_items_hash.merge(store_results)
    missing_items = []
    store_results.each do |key, value|
      if key.include?('(not found)') == false
        missing_items_hash.delete(key)
      end
    end

    missing_items_hash.each do |key, value|
      missing_items.push(key)
    end

    if missing_items.length > 0
      missing_items = missing_items.map { |marker| marker.gsub(' (not found)', '') }

      if missing_items[0].include?('Coop: ')
        missing_items = missing_items.map { |marker| marker.gsub('Coop: ', '') }
      elsif missing_items[0].include?('Prisma: ')
        missing_items = missing_items.map { |marker| marker.gsub('Prisma: ', '') }
      elsif missing_items[0].include?('Rimi: ')
        missing_items = missing_items.map { |marker| marker.gsub('Rimi: ', '') }
      elsif missing_items[0].include?('Selver: ')
        missing_items = missing_items.map { |marker| marker.gsub('Selver: ', '') }
      end
    end

    missing_items
  end

  def self.successful_query_lister(store_missing_items, search_list)
    successful_queries = []
    successful_queries += search_list
    store_missing_items.each do |item|
      successful_queries.delete(item)
    end
    successful_queries
  end

  def self.coop(search_list, max_retrieve)
    results = {}
    search_list.each do |item|
      coop_results = Search.coop(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(coop_results)
      results = results.merge(cheapest_or_unfound_item)
    end
    results
  end

  def self.prisma(search_list, max_retrieve)
    results = {}
    search_list.each do |item|
      prisma_results = Search.prisma(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(prisma_results)
      results = results.merge(cheapest_or_unfound_item)
    end
    results
  end

  def self.selver(search_list, max_retrieve)
    results = {}
    search_list.each do |item|
      selver_results = Search.selver(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(selver_results)
      results = results.merge(cheapest_or_unfound_item)
    end
    results
  end

  def self.rimi(search_list, max_retrieve)
    results = {}
    search_list.each do |item|
      rimi_results = Search.rimi(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(rimi_results)
      results = results.merge(cheapest_or_unfound_item)
    end
    results
  end
end

def calculate_totals(store_found_cheapest_items, quantities_list)
  i = 0
  shopping_cart_total = 0
  if store_found_cheapest_items.length == quantities_list.length
    store_found_cheapest_items.each do |key, value|
      if value[1].include?('tk') || value[1].include?('pcs')
        item_quantity_price = value[0] * quantities_list[i]
        shopping_cart_total += item_quantity_price
        i += 1
      else
        item_quantity_price = value[0] * quantities_list[i]/1000
        shopping_cart_total += item_quantity_price
        i += 1
      end
    end
  end
  shopping_cart_total.round(2)
end

def cheapest_items_names_lister(store_found_cheapest_items)
  cheapest_items_names = []

  store_found_cheapest_items.each do |key, value|
    cheapest_items_names.push(key)
  end

  if cheapest_items_names.length > 0
    if cheapest_items_names[0].include?('Coop: ')
      cheapest_items_names = cheapest_items_names.map { |marker| marker.gsub('Coop: ', '') }
    elsif cheapest_items_names[0].include?('Prisma: ')
      cheapest_items_names = cheapest_items_names.map { |marker| marker.gsub('Prisma: ', '') }
    elsif cheapest_items_names[0].include?('Rimi: ')
      cheapest_items_names = cheapest_items_names.map { |marker| marker.gsub('Rimi: ', '') }
    elsif cheapest_items_names[0].include?('Selver: ')
      cheapest_items_names = cheapest_items_names.map { |marker| marker.gsub('Selver: ', '') }
    end
  end

  cheapest_items_names
end

def found_items_quantities_lister(search_list, quantities_list, store_successful_queries)
  found_items_quantities = []
  successful_query_indexes = []

  store_successful_queries.each do |query|
    successful_query_indexes.push(search_list.index(query))
  end

  successful_query_indexes.each do |index|
    found_items_quantities.push(quantities_list[index])
  end

  found_items_quantities
end

def calculate_incomplete_cart_totals(store_found_cheapest_items, store_found_items_quantities, quantities_list)
  i = 0
  incomplete_cart_total = 0
  if store_found_items_quantities.length < quantities_list.length
    store_found_cheapest_items.each do |key, value|
      if value[1].include?('tk') || value[1].include?('pcs')
        item_quantity_price = value[0] * store_found_items_quantities[i]
        incomplete_cart_total += item_quantity_price
        i += 1
      else
        item_quantity_price = value[0] * store_found_items_quantities[i]/1000
        incomplete_cart_total += item_quantity_price
        i += 1
      end
    end
  end
  incomplete_cart_total.round(2)
end
