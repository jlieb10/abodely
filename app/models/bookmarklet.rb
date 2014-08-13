require 'nokogiri'
require 'open-uri'
require 'mechanize'

class Bookmarklet

	def initialize(url, user)
		@user = user
		@url = url
		@images = []
	end

	def run 
		@doc = Nokogiri::HTML(open(@url))
		scrape_images
		scrape_rent
		scrape_neighborhood
		scrape_contact
		check_for_hunt
		create_apartment
		add_details
	end

	def scrape_images
		@doc.css('#thumbs a').each do |thumb|
    	@images << thumb['href']
		end
	end

	def scrape_rent
		@rent = @doc.at_css('.postingtitle').text.match(/\b\d+\b/)[0]
	end

	def scrape_neighborhood
		title_text = @doc.at_css('.postingtitle').text
		if title_text.include?("(")
			hood = title_text.match(/\(.+/)[0]
			@neighborhood = hood.gsub(/\(|\)/, "")
		else
			@neighborhood = "See Craiglist posting."
		end
	end

	def scrape_contact
		agent = Mechanize.new
		agent.get(@url)
		new_page = agent.page.link_with(:text => "show contact info")
		if new_page != nil
		  @number = new_page.click.body.match(/\d.?\d.?\d.?.?.?\d.?\d.?\d.?.?.?\d.?\d.?\d.?\d/)[0]
		else
		  @number = "See Craiglist posting."
		end
	end

	def check_for_hunt
		if !!@user.hunts.last
			@hunt = @user.hunts.last
		else 
			@hunt = Hunt.create(title: "New Hunt")
			@user.hunts << @hunt
		end
	end

	def create_apartment
		@apartment = Apartment.new(:link => @url, :price => @rent, :street => @neighborhood, :contact => @number)
		@apartment.save
		@hunt.apartments << @apartment
	end

	def add_details
		@images.each do |image_url|
			det = Detail.new(:remote_image_url => image_url, :apartment_id => @apartment.id)
			det.content = ""
			det.save
		end
	end

end



