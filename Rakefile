require 'rake'
require 'rake/testtask'
require_relative 'lib/scrapper'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

task :check_for_updates do
  AppartmentFinder::Scrapper.new("http://newyork.craigslist.org/search/roo/mnh?query=&srchType=A&minAsk=1000&maxAsk=1775&nh=160&nh=121&nh=129&nh=133&nh=127&nh=126&nh=131&nh=125&nh=124&nh=123&nh=130&hasPic=1").appartments.each do |appartment|
    if appartment.new?
      AppartmentFinder::AppartmentEmailer.new(appartment).deliver
      appartment.save
    end
  end
end

task :default => :test
