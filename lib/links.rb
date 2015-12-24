require 'nokogiri'
load 'utilities.rb'

class Links
  include Utilities
  def initialize(html)
    links = html.xpath("//div[contains(concat(' ',normalize-space(@class),' '),' link-section ')]")
    @link_list = Array.new
    
    links.each do |link|
      @link_list.push({
                        link_title: link_title(link),
                        link_url: link_url(link)
      })
    end
  end

  # Return person info
  def get_links
    return @link_list
  end

  # Get title of link
  def link_title(link)
    link.xpath(".//a").text
  end

  # Get link url
  def link_url(link)
    link.xpath(".//a").first['href']
  end
end
