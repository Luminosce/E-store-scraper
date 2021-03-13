class MakeResults
  def self.forPrisma(names:, prices:)
    grouped_prisma_results = {}
    for i in 0...names.length do
      grouped_prisma_results['Prisma: ' + names[i]] = [prices[i].split(' ')[0].gsub(',', '.').to_f,
                                          ' ' + prices[i].split(' ')[1]]
    end
    grouped_prisma_results
  end
end

class Search

  # Prisma's website is weird and badly organised for scraping:
  # Search for 'õun', 'tomat', 'viinamari', 'and saib' on the website and compare to see what I mean.
  def self.prisma(query, max_retrieve)
    names = Array.new
    prices = Array.new
    names_low_relevance = Array.new
    prices_low_relevance = Array.new
    puts ""
    puts "Attempting to retrieve first #{max_retrieve} results from Prisma for item '#{query}'..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'log-level=2'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forPrisma(query)
    driver.get(url)

    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => 1)
      wait.until { driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(1) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price") }
      for i in 0...max_retrieve do
        name_element = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.name")
        price_element = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price")
        if name_element.displayed? && price_element.displayed?  # To handle hidden price elements separately
          name = name_element.text
          price = price_element.text
          if (name.downcase.include? query.downcase) && price != ""
            names.push(name)
            prices.push(price)
          elsif price != ""
            names_low_relevance.push(name)
            prices_low_relevance.push(price)
          end
        elsif name_element.displayed? # Hidden price elements handled here
          price_element_1 = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div > div > span.whole-number")
          price_element_2 = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div > div > span.decimal")
          price_element_3 = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div > div > span.unit")
          name = name_element.text
          price = price_element_1.text + "," + price_element_2.text + " €" + price_element_3.text
          if (name.downcase.include? query.downcase) && price.length > 3
            names.push(name)
            prices.push(price)
          elsif price.length > 3
            names_low_relevance.push(name)
            prices_low_relevance.push(price)
          end
        end
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
    end

    begin
      if names.length < max_retrieve
        wait.until { driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(1) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price") }
        for i in 0...(max_retrieve - names.length) do
          name_element = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.name")
          price_element = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price")
          if name_element.displayed? && price_element.displayed? # To handle hidden price elements separately
            name = name_element.text
            price = price_element.text
            if (name.downcase.include? query.downcase) && price != ""
              names.push(name)
              prices.push(price)
            elsif price != ""
              names_low_relevance.push(name)
              prices_low_relevance.push(price)
            end
          elsif name_element.displayed? # Hidden price elements handled here
            price_element_1 = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div > div > span.whole-number")
            price_element_2 = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div > div > span.decimal")
            price_element_3 = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div > div > span.unit")
            name = name_element.text
            price = price_element_1.text + "," + price_element_2.text + " €" + price_element_3.text
            if (name.downcase.include? query.downcase) && price.length > 3
              names.push(name)
              prices.push(price)
            elsif price.length > 3
              names_low_relevance.push(name)
              prices_low_relevance.push(price)
            end
          end
        end
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
    end

    if names.length == 0 && names_low_relevance.length != 0
      for i in 0...max_retrieve do
        if names_low_relevance[i] != nil && prices_low_relevance[i] != nil
          names.push(names_low_relevance[i])
          prices.push(prices_low_relevance[i])
        end
      end
    end

    if names.length == 0
      puts ""
      puts "No such items found for Prisma.".colorize(:red)
    else
      puts ""
      puts "Successfully retrieved #{names.length} result(s) from Prisma.".colorize(:cyan)
    end

    driver.quit
    MakeResults.forPrisma(names: names, prices: prices)
  end
end

class BuildSearchUrl
  PRISMA_BASE_URL = 'https://www.prismamarket.ee/products/search/'

  def self.forPrisma(query)
    # url = URI(PRISMA_BASE_URL + query.split(' ').join('%20'))
    url = PRISMA_BASE_URL + query.split(' ').join('%20')
    url
  end
end
