require_relative 'lib/scrapper'

URL = "http://newyork.craigslist.org/search/roo/mnh?query=&srchType=A&minAsk=1000&maxAsk=1775&nh=160&nh=121&nh=129&nh=133&nh=127&nh=126&nh=131&nh=125&nh=124&nh=123&nh=130&hasPic=1".freeze

loop do
  AppartmentFinder::Scrapper.new(URL).appartments.each do |appartment|
    if appartment.new?
      AppartmentFinder::AppartmentEmailer.new(appartment).deliver
      appartment.save
    end
  end
  sleep 300
end
