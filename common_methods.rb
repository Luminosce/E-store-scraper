def combine_results(coop_results = {}, prisma_results = {}, selver_results = {}, rimi_results = {})
  successful_coop_results = {}
  coop_results.each do |key, value|
    if key.include?('(not found)') == false
      successful_coop_results[key] = [value[0], value[1]]
    end
  end

  successful_prisma_results = {}
  prisma_results.each do |key, value|
    if key.include?('(not found)') == false
      successful_prisma_results[key] = [value[0], value[1]]
    end
  end

  successful_selver_results = {}
  selver_results.each do |key, value|
    if key.include?('(not found)') == false
      successful_selver_results[key] = [value[0], value[1]]
    end
  end

  successful_rimi_results = {}
  rimi_results.each do |key, value|
    if key.include?('(not found)') == false
      successful_rimi_results[key] = [value[0], value[1]]
    end
  end

  puts ""
  puts "Total results retrieved: #{successful_coop_results.length + successful_prisma_results.length + successful_selver_results.length + successful_rimi_results.length}."
  puts ""
  puts "Combining all retrieved results..."
  combined_results = {}

  successful_coop_results.each do |key, value|
    combined_results[key] = [value[0], value[1]]
  end

  successful_prisma_results.each do |key, value|
    combined_results[key] = [value[0], value[1]]
  end

  successful_rimi_results.each do |key, value|
    combined_results[key] = [value[0], value[1]]
  end

  successful_selver_results.each do |key, value|
    combined_results[key] = [value[0], value[1]]
  end

  combined_results
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
    found_cheapest_items = []
    store_results.each do |item|
      if item[0].include?('(not found)') == false
        found_cheapest_items.push(item)
      end
    end
    found_cheapest_items
  end

  def self.missing_items_lister(store_results)
    missing_items = []
    missing_items_names = []

    store_results.each do |item|
      if item[0].include?('(not found)')
        missing_items.push(item)
      end
    end

    missing_items.each do |item|
        item[0] = item[0].gsub(' (not found)', '')
        item[0] = item[0].gsub('Coop: ', '')
        item[0] = item[0].gsub('Prisma: ', '')
        item[0] = item[0].gsub('Rimi: ', '')
        item[0] = item[0].gsub('Selver: ', '')
        missing_items_names.push(item[0])
    end

    missing_items_names
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
    results = []
    search_list.each do |item|
      coop_results = Search.coop(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(coop_results)
      cheapest_or_unfound_item.each do |key, value|
        results.push([key, value[0], value[1]])
      end
    end
    results
  end

  def self.prisma(search_list, max_retrieve)
    results = []
    search_list.each do |item|
      prisma_results = Search.prisma(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(prisma_results)
      cheapest_or_unfound_item.each do |key, value|
        results.push([key, value[0], value[1]])
      end
    end
    results
  end

  def self.selver(search_list, max_retrieve)
    results = []
    search_list.each do |item|
      selver_results = Search.selver(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(selver_results)
      cheapest_or_unfound_item.each do |key, value|
        results.push([key, value[0], value[1]])
      end
    end
    results
  end

  def self.rimi(search_list, max_retrieve)
    results = []
    search_list.each do |item|
      rimi_results = Search.rimi(item, max_retrieve)
      cheapest_or_unfound_item = sort_and_limit_results_for_list(rimi_results)
      cheapest_or_unfound_item.each do |key, value|
        results.push([key, value[0], value[1]])
      end
    end
    results
  end
end

def calculate_totals(store_found_cheapest_items, quantities_list)
  i = 0
  shopping_cart_total = 0
  if store_found_cheapest_items.length == quantities_list.length
    store_found_cheapest_items.each do |item|
      if item[2].include?('tk') || item[2].include?('pcs')
        item_quantity_price = item[1] * quantities_list[i]
        shopping_cart_total += item_quantity_price
        i += 1
      else
        item_quantity_price = item[1] * quantities_list[i]/1000
        shopping_cart_total += item_quantity_price
        i += 1
      end
    end
  end
  shopping_cart_total.round(2)
end

def cheapest_items_names_lister(store_found_cheapest_items)
  cheapest_items_names = []

  store_found_cheapest_items.each do |item|
    cheapest_items_names.push(item[0])
  end

  cheapest_items_names.each do |name|
    name = name.gsub('Coop: ', '')
    name = name.gsub('Prisma: ', '')
    name = name.gsub('Rimi: ', '')
    name = name.gsub('Selver: ', '')
  end

  cheapest_items_names
end

def found_items_quantities_lister(search_list, quantities_list, store_successful_queries)
  found_items_quantities = []
  successful_query_indexes = []

  store_successful_queries.each do |query|
    if search_list.index(query) != nil
      successful_query_indexes.push(search_list.index(query))
    end
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
    store_found_cheapest_items.each do |item|
      if item[2].include?('tk') || item[2].include?('pcs')
        item_quantity_price = item[1] * store_found_items_quantities[i]
        incomplete_cart_total += item_quantity_price
        i += 1
      else
        item_quantity_price = item[1] * store_found_items_quantities[i]/1000
        incomplete_cart_total += item_quantity_price
        i += 1
      end
    end
  end
  incomplete_cart_total.round(2)
end
