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
  def self.prisma(query, max_results)
    names = Array.new
    prices = Array.new
    puts ""
    puts "Attempting to retrieve first #{max_results} results from Prisma..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'log-level=2'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forPrisma(query)
    driver.get(url)

    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => 1)
      wait.until { driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(1) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price") }
      for i in 0...max_results do
        name_element = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.name")
        price_element = driver.find_element(:css, "div:nth-child(3) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price")
        if name_element.displayed? && price_element.displayed? && (price_element.attribute("hidden") == nil) # Skipping Prisma's hidden price elements because lazy
          name = name_element.text
          names.push(name)
          price = price_element.text
          prices.push(price)
        end
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
    end

    begin
      if names.length < max_results
        wait.until { driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(1) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price") }
        for i in 0...(max_results - names.length) do
          name_element = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.name")
          price_element = driver.find_element(:css, "div:nth-child(2) > ul > li:nth-child(#{i+1}) > div.info.relative.clear > div.price-and-quantity > div.unit-price.clear.js-comp-price")
          if name_element.displayed? && price_element.displayed? && (price_element.attribute("hidden") == nil) # Skipping Prisma's hidden elements because lazy
            name = name_element.text
            names.push(name)
            price = price_element.text
            prices.push(price)
          end
        end
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
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
    query = query.split(' ').join('%20')
    url = URI(PRISMA_BASE_URL + query)
    url
  end
end
