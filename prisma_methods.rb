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
    puts ""
    puts "Retrieving first #{max_results} results from Prisma..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forPrisma(query)
    driver.get(url)
    names = {}
    prices = {}
    begin
      for i in 0...max_results do
        if driver.find_elements(:css, 'div.price-and-quantity')[i+5]
          names[i] = driver.find_elements(:css, 'div.name')[i+6].attribute('textContent') # Because some of Prisma's names/prices are hidden elements
          prices[i] = driver.find_elements(:css, 'div.price-and-quantity > div:nth-child(2)')[i+5].attribute('textContent')
        end
        if names.length == 0
          names[i] = driver.find_elements(:css, 'div.name')[i+1].attribute('textContent')
          prices[i] = driver.find_elements(:css, 'div.price-and-quantity > div:nth-child(2)')[i].attribute('textContent')
        end
      end
      driver.quit
      MakeResults.forPrisma(names: names, prices: prices)
    rescue NoMethodError
      puts ''
      puts "No such items found for Prisma.".colorize(:red)
      prisma_results = {}
    end
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
