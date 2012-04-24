require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'mail'

module AppartmentFinder

  DB_PATH = "db.yml".freeze

  class Scrapper
    def initialize(href)
      @href = href
    end

    def appartments
      @appartments ||= set_appartments
    end

    def reload
      @page = nil
      @appartments = nil
      appartments
    end

    private

    def page
      @page ||= Nokogiri::HTML(open(@href))
    end

    def set_appartments
      page.xpath("/html/body/blockquote[2]/p/a").map do |anchor|
        Appartment.new(anchor.attr('href'))
      end
    end

  end

  class AppartmentEmailer
    def initialize(appartment)
      @appartment = appartment
    end

    def deliver
      title = @appartment.title
      href = @appartment.href
      body = @appartment.body
      images = @appartment.images
      email = ENV["TO_EMAIL_ADDRESS"]
      mail = Mail.new do
        from "appartment finder"
        to email
        subject title
        html_part do
          content_type 'text/html; charset=UTF-8'
          body" <h1><a href='#{href}'>#{title}</a></h1> <p>#{body}</p> #{images.map { |i| "<img src='#{i}' />" }.join}"
        end
      end
      mail.delivery_method :sendmail
      mail.deliver
    end
  end

  class Appartment
    attr_reader :href

    def initialize(href)
      @href = href
    end

    def id
      @id ||= 
        /http:\/\/newyork\.craigslist\.org\/mnh\/roo\/(\d+)\.html/.match(@href)[1].to_i
    end

    def title
      @title ||= page.xpath('/html/body/h2').text
    end

    def body
      @body ||= page.xpath('//*[@id="userbody"]/text()').text.strip
    end

    def images
      @images ||= if !(images = page.xpath('//*[@id="iwt"]/div/a')).empty?
                    images.map { |node| node.attr('href') }
                  elsif !(images = page.xpath('//*[@id="userbody"]/center/a/img')).empty?
                    images.map { |node| node.attr('src') }
                  else
                    page.xpath('//*[@id="userbody"]/img').map do |node|
                      node.attr('src')
                    end
                  end
    end
    
    def new?
      ids = YAML::load(File.open(DB_PATH)) || []
      !ids.include?(id)
    end

    def save
      ids = YAML::load(File.open(DB_PATH)) || []
      ids << id
      File.open(DB_PATH, 'w') { |f| f.write YAML::dump(ids) }
    end

    private

    def page
      @page ||= Nokogiri::HTML(open(@href))
    end

  end

end
