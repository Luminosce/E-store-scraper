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
    puts "Attempting to retrieve first #{max_results} results from Coop..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'log-level=2'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forCoop(query)
    driver.get(url)

    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => 1)
      wait.until { driver.find_element(:css, "app-product-card:nth-child(1) > div > a > div.prices-info > div.text-right") }

      for i in 0...max_results do
        name_element = driver.find_element(:css, "app-product-card:nth-child(#{i+1}) > div > a > p")
        price_element = driver.find_element(:css, "app-product-card:nth-child(#{i+1}) > div > a > div.prices-info > div.text-right")
        if name_element.displayed? && price_element.displayed?
          name = name_element.text
          names.push(name)
          price = price_element.text
          prices.push(price)
        end
      end

    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
    end

    if names.length == 0
      puts ""
      puts "No such items found for Coop.".colorize(:red)
    else
      puts ""
      puts "Successfully retrieved #{names.length} result(s) from Coop.".colorize(:cyan)
    end

    driver.quit
    MakeResults.forCoop(names: names, prices: prices)
  end
end

class BuildSearchUrl
  COOP_BASE_URL = "https://ecoop.ee/et/otsing"

  def self.forCoop(query)
    url = URI(COOP_BASE_URL)
    url.query = URI.encode_www_form([["query", query ]])
    url
  end
end
