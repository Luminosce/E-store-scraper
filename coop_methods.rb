class MakeResults
  def self.forCoop(names:, prices:)
    grouped_coop_results = {}
    for i in 0...names.length do
      grouped_coop_results['Coop: ' + names[i]] = [prices[i].split(' ')[0].to_f,
                                             (' ' + (prices[i]).split(' ')[1] + (prices[i]).split(' ')[2] + (prices[i]).split(' ')[3])]
    end
    grouped_coop_results
  end
end

class Search
  def self.coop(query, max_results)
    names = Array.new
    prices = Array.new
    puts ""
    puts "Retrieving first #{max_results} results from Coop..."
    begin
      options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
      driver = Selenium::WebDriver.for(:chrome, options: options)
      url = BuildSearchUrl.forCoop(query)
      driver.get(url)
      begin
        wait = Selenium::WebDriver::Wait.new(:timeout => 1)
        wait.until { driver.find_element(:css, "app-product-card:nth-child(1) > div > a > div.prices-info > div.text-right") }

        for i in 0...max_results do
          if driver.find_element(:css, "app-product-card:nth-child(#{i+1}) > div > a > p")
            name = driver.find_element(:css, "app-product-card:nth-child(#{i+1}) > div > a > p").text
            names.push(name)
          end
          if driver.find_element(:css, "app-product-card:nth-child(#{i+1}) > div > a > div.prices-info > div.text-right")
            price = driver.find_element(:css, "app-product-card:nth-child(#{i+1}) > div > a > div.prices-info > div.text-right").text
            prices.push(price)
          end
        end


      rescue Selenium::WebDriver::Error::TimeoutError
        puts "No such items found for Coop.".colorize(:red)
      rescue Selenium::WebDriver::Error::NoSuchElementError
        # puts "No more such items found for Coop.".colorize(:red)
      end
      MakeResults.forCoop(names: names, prices: prices)
    end
  end
end

class BuildSearchUrl
  COOP_BASE_URL = "https://ecoop.ee/et/otsing?query="

  def self.forCoop(query)
    query = query.split(' ').join('%20')
    url = URI(COOP_BASE_URL + query)
    url
  end
end
