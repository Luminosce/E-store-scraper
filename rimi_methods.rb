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
  def self.rimi(query, max_retrieve)
    names = Array.new
    prices = Array.new
    names_low_relevance = Array.new
    prices_low_relevance = Array.new
    puts ""
    puts "Attempting to retrieve first #{max_retrieve} results from Rimi for item '#{query}'..."
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'log-level=2'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    url = BuildSearchUrl.forRimi(query)
    driver.get(url)

    retries = 0
    failures = 0
    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => 2)
      wait.until { driver.find_element(:css, "li:nth-child(1) > div > div.card__details > div > div > div:nth-child(2) > p") }

      for i in 0...max_retrieve do
        name_element = driver.find_element(:css, "li:nth-child(#{i+1}) > div > div.card__details > p.card__name")
        price_element = driver.find_element(:css, "li:nth-child(#{i+1}) > div > div.card__details > div > div > div:nth-child(2) > p")
        if name_element.displayed? && price_element.displayed?
          name = name_element.text
          price = price_element.text
          if name.downcase.include?(query.downcase) && price != ""
            names.push(name)
            prices.push(price)
          elsif price != ""
            names_low_relevance.push(name)
            prices_low_relevance.push(price)
          end
        end
      end

    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      failures += 1
      puts "Something went wrong. Will try again up to two times. Retries so far: #{retries}.".colorize(:red)
      retry if (retries += 1) < 3
    rescue Selenium::WebDriver::Error::NoSuchElementError
    rescue Selenium::WebDriver::Error::TimeoutError
    end

    if retries > 0 && failures < 3
      puts "Retry was successful.".colorize(:green)
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
      puts "No such items found for Rimi.".colorize(:red)
      names.push("#{query} (not found)")
      prices.push("99999,0 € /kg")
    else
      puts ""
      puts "Successfully retrieved #{names.length} result(s) from Rimi.".colorize(:cyan)
    end

    driver.quit
    MakeResults.forRimi(names: names, prices: prices)
  end
end

class BuildSearchUrl
  RIMI_BASE_URL = "https://www.rimi.ee/epood/ee/otsing?query="

  def self.forRimi(query)
    url = RIMI_BASE_URL + query
    url
  end
end
