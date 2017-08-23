class Query < ApplicationRecord
  VALID_SOURCES = {
    'FSBO' => 'http://fsbo.com'
  }

  has_many :results

  def query
    agent = Mechanize.new
    agent.user_agent_alias = "Windows IE 7"
    page = agent.get("http://fsbo.com")
    form = page.form_with(dom_id: 'basicSearchForm')
    form.searchQuery = location
    page = form.submit
    listing_links = page.links_with(css: '.fsbo-button')
    listing_links.each do |listing_link|
      if listing_link.text == "View Listing Details"
        page = listing_link.click
        html = Nokogiri::HTML(page.body)
        price = html.css('.address-copy > .price').text.strip.gsub(/\t/, "")
        address = html.css('.address-copy > .address').text.strip.gsub(/\t/, "").gsub(/\n/, "")
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

        detail_results = details.inject({}) do |hsh, detail|
          hsh.merge!(detail.first.gsub(":", "") => detail.second)
          hsh
        end

        result = results.new(
            listing_id: detail_results["Listing Id"],
            bedrooms: detail_results["Bedrooms"],
            bathrooms: detail_results["Bahtrooms"],
            garage: detail_results["Garage"],
            result_type: detail_results["Type"],
            subtype: detail_results["Subtype"],
            lot_size: detail_results["Lot Size"],
            square_feet: detail_results["Sq. Feet"],
            year_built: detail_results["Year Built"],
            school_district: detail_results["School District"],
            subdivision: detail_results["Subdivision"],
            price: price,
            address: address,
            description: description,
          )

        contact_information = result.contact_informations.new(
            name: contact_info.first
          )

        contact_information.phone_numbers.new(
            number: contact_info.second
          )
      end
    end
  end
end
