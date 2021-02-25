class MakeResults
  def self.forRimi(names:, prices:)
    grouped_rimi_results = {}
    for i in 0...names.length do
      grouped_rimi_results['Rimi: ' + names[i]] = [prices[i].split(' ')[0].gsub(',', '.').to_f,
                                               (' ' + (prices[i]).split(' ')[1] + (prices[i]).split(' ')[2])]
    end
    grouped_rimi_results
  end
end

class Search
  def self.rimi(query, max_results)
    names = Array.new
    prices = Array.new
    puts ""
    puts "Attempting to retrieve first #{max_results} results from Rimi..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'log-level=2'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forRimi(query)
    driver.get(url)

    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => 1)
      wait.until { driver.find_element(:css, "li:nth-child(1) > div > div.card__details > div > div > div:nth-child(2) > p") }

      for i in 0...max_results do
        name_element = driver.find_element(:css, "li:nth-child(#{i+1}) > div > div.card__details > p.card__name")
        price_element = driver.find_element(:css, "li:nth-child(#{i+1}) > div > div.card__details > div > div > div:nth-child(2) > p")
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
      puts "No such items found for Rimi.".colorize(:red)
    else
      puts ""
      puts "Successfully retrieved #{names.length} result(s) from Rimi.".colorize(:cyan)
    end

    driver.quit
    MakeResults.forRimi(names: names, prices: prices)
  end
end

class BuildSearchUrl
  RIMI_BASE_URL = "https://www.rimi.ee/epood/ee/otsing"

  def self.forRimi(query)
    url = URI(RIMI_BASE_URL)
    url.query = URI.encode_www_form([["query", query ]])
    url
  end
end
