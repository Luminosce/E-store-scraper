class BuildSearchUrl
  PRISMA_BASE_URL = 'https://www.prismamarket.ee/products/search/'

  def self.forPrisma(query)
    query = query.split(' ').join('%20')
    url = URI(PRISMA_BASE_URL + query)
    url
  end
end

class Search
  def self.prisma(query, max_results)
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forPrisma(query)
    driver.get(url)
    names = {}
    prices = {}
    for i in 0...max_results do
      names[i] = driver.find_elements(:css, 'div.name')[i+6].text
      prices[i] = driver.find_elements(:css, 'div.unit-price.clear.js-comp-price')[i+6].text
    end
    driver.quit
    MakeResults.forPrisma(names: names, prices: prices)
  end
end

class MakeResults
  def self.forPrisma(names:, prices:)
    grouped_prisma_results = {}
    for i in 0...names.length do
      grouped_prisma_results[names[i]] = [prices[i].split(' ')[0].gsub(',', '.').to_f,
                                                  ' ' + prices[i].split(' ')[1]]
    end
    grouped_prisma_results
  end
end
