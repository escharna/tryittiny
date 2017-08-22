class Result < ApplicationRecord
  # Listing ID, Address, Price, Bedrooms, Bathrooms, Garage, Type, Subtype, Lot Size, Sq. Feet, Year Built, School Districts, Subdivision, Description
  # has_many amenities Name
  # has_one contact_info Name
  #   has_many phone_numbers Number

  agent = Mechanize.new
  page = agent.get("http://fsbo.com")
  form = page.form_with(dom_id: 'basicSearchForm')
  form.searchQuery = "Denver, CO"
  page = form.submit
  listing_links = page.links_with(css: '.fsbo-button')
  listing_links.each do |listing_link|
    if listing_link.text == "View Listing Details"
      page = listing_link.click
      html = Nokogiri::HTML(page.body)
      price = html.css('.address-copy > .price').text.strip.gsub(/\t/, "")
      address = html.css('.address-copy > .address').text.strip.gsub(/\t/, "")
      details = []
      html.css('.listing-data > tr').each_with_index do |row, i|
        details[i] = row.search('td').map(&:text)
      end
      description = html.css('.property-description').text
      amenities = []
      html.css('.amenities > .more-amenities > ul > li').each do |amenity|
        amenities << amenity.text
      end
      page.links_with(text: "Contact Owner").first.click
      contact_info = html.css('.modal-body > div:first-child').css('.col-md-10').map(&:text).map(&:strip)

      # find or create these records here... do not create a new record if listing ID exists
    end
  end
end
