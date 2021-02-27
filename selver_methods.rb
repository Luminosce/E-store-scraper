class MakeResults
  def self.forSelver(names:, prices:)
    grouped_selver_results = {}
    for i in 0...names.length do
      grouped_selver_results['Selver: ' + names[i]] = [prices[i].split(' ')[0].gsub(',', '.').to_f,
                                               (' ' + (prices[i]).split(' ')[1])]
    end
    grouped_selver_results
  end
end

class Search
  def self.selver(query, max_retrieve)
    names = Array.new
    prices = Array.new
    names_low_relevance = Array.new
    prices_low_relevance = Array.new
    puts ""
    puts "Attempting to retrieve first #{max_retrieve} results from Selver..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'log-level=2'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forSelver(query)
    driver.get(url)

    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => 1)
      wait.until { driver.find_element(:css, "span.unit-price") }

      for i in 0...max_retrieve do
        name_element = driver.find_elements(:css, "h5.product-name")[i]
        price_element = driver.find_elements(:css, "span.unit-price")[i]
        if name_element && price_element
          name = name_element.text
          price = price_element.text
          if name.downcase.include? query.downcase
            names.push(name)
            prices.push(price)
          else
            names_low_relevance.push(name)
            prices_low_relevance.push(price)
          end
        end
      end

    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
    end

    if names.length == 0 && names_low_relevance.length != 0
      names.concat names_low_relevance
      prices.concat prices_low_relevance
    end

    if names.length == 0
      puts ""
      puts "No such items found for Selver.".colorize(:red)
    else
      puts ""
      puts "Successfully Retrieved #{names.length} result(s) from Selver.".colorize(:cyan)
    end

    driver.quit
    MakeResults.forSelver(names: names, prices: prices)
  end
end

class BuildSearchUrl
  SELVER_BASE_URL = "https://www.selver.ee/catalogsearch/result/"

  def self.forSelver(query)
    url = URI(SELVER_BASE_URL)
    url.query = URI.encode_www_form([["q", query ]])
    url
  end
end
