
def single_search_mode(mode_is)
  if mode_is == 'single'
    interface = Single_Search_Interface.new

    query = interface.get_search_input
    max_retrieve = interface.get_max_retrieve_input
    max_display = interface.get_max_display_input

    coop_results = Search.coop(query, max_retrieve)
    prisma_results = Search.prisma(query, max_retrieve)
    rimi_results = Search.rimi(query, max_retrieve)
    selver_results = Search.selver(query, max_retrieve)

    combined_results = combine_results(coop_results, prisma_results, selver_results, rimi_results)
    limited_sorted_results = sort_and_limit_results(combined_results, max_display)

    interface.display_results(limited_sorted_results)
    mode_is = nil
  end
end

def list_search_mode(mode_is)
  if mode_is == 'list'
    interface = List_Search_Interface.new

    search_list = interface.build_search_list
    quantities_list = interface.build_quantities_list(search_list)
    max_retrieve = interface.get_max_retrieve_input

    coop_results = List_Search.coop(search_list, max_retrieve)
    prisma_results = List_Search.prisma(search_list, max_retrieve)
    rimi_results = List_Search.rimi(search_list, max_retrieve)
    selver_results = List_Search.selver(search_list, max_retrieve)

    coop_cheapest = List_Search.found_cheapest_items_lister(coop_results)
    prisma_cheapest = List_Search.found_cheapest_items_lister(prisma_results)
    rimi_cheapest = List_Search.found_cheapest_items_lister(rimi_results)
    selver_cheapest = List_Search.found_cheapest_items_lister(selver_results)

    coop_missing = List_Search.missing_items_lister(coop_results)
    prisma_missing = List_Search.missing_items_lister(prisma_results)
    rimi_missing = List_Search.missing_items_lister(rimi_results)
    selver_missing = List_Search.missing_items_lister(selver_results)

    coop_successful_queries = List_Search.successful_query_lister(coop_missing, search_list)
    prisma_successful_queries = List_Search.successful_query_lister(prisma_missing, search_list)
    rimi_successful_queries = List_Search.successful_query_lister(rimi_missing, search_list)
    selver_successful_queries = List_Search.successful_query_lister(selver_missing, search_list)

    coop_cheapest_items_names = cheapest_items_names_lister(coop_cheapest)
    prisma_cheapest_items_names = cheapest_items_names_lister(prisma_cheapest)
    rimi_cheapest_items_names = cheapest_items_names_lister(rimi_cheapest)
    selver_cheapest_items_names = cheapest_items_names_lister(selver_cheapest)

    coop_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, coop_successful_queries)
    prisma_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, prisma_successful_queries)
    rimi_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, rimi_successful_queries)
    selver_found_items_quantities = found_items_quantities_lister(search_list, quantities_list, selver_successful_queries)

    coop_total = calculate_totals(coop_cheapest, quantities_list)
    prisma_total = calculate_totals(prisma_cheapest, quantities_list)
    rimi_total = calculate_totals(rimi_cheapest, quantities_list)
    selver_total = calculate_totals(selver_cheapest, quantities_list)

    coop_incomplete_total = calculate_incomplete_cart_totals(coop_cheapest, coop_found_items_quantities, quantities_list)
    prisma_incomplete_total = calculate_incomplete_cart_totals(prisma_cheapest, prisma_found_items_quantities, quantities_list)
    rimi_incomplete_total = calculate_incomplete_cart_totals(rimi_cheapest, rimi_found_items_quantities, quantities_list)
    selver_incomplete_total = calculate_incomplete_cart_totals(selver_cheapest, selver_found_items_quantities, quantities_list)

    interface.sort_and_display_list_search_results(coop_total, prisma_total, rimi_total, selver_total)
    interface.display_detailed_list_search_results(coop_cheapest, prisma_cheapest, rimi_cheapest, selver_cheapest,
                                                   coop_cheapest_items_names, prisma_cheapest_items_names, rimi_cheapest_items_names, selver_cheapest_items_names,
                                                   coop_found_items_quantities, prisma_found_items_quantities, rimi_found_items_quantities, selver_found_items_quantities,
                                                   coop_successful_queries, prisma_successful_queries, rimi_successful_queries, selver_successful_queries,
                                                   coop_total, prisma_total, rimi_total, selver_total,
                                                   coop_incomplete_total, prisma_incomplete_total, rimi_incomplete_total, selver_incomplete_total,
                                                   coop_missing, prisma_missing, rimi_missing, selver_missing)
    mode_is = nil
  end
end
