require 'nokogiri'
load 'utilities.rb'

class Degrees
  include Utilities
  def initialize(html)
    degrees = html.xpath("//div[@itemtype='http://schema.org/EducationalOrganization']")
    @degree_list = Array.new
    
    degrees.each do |degree|
      @degree_list.push({
                          school: school(degree),
                          degree_title: degree_title(degree),
                          school_location: school_location(degree),
                          degree_start_date: degree_start_date(degree),
                          degree_end_date: degree_end_date(degree)
      })
    end
  end

  # Return degree info
  def get_degrees
    return @degree_list
  end

  # Get school name
  def school(degree)
    degree.xpath(".//span[@itemprop='name']").text
  end

  # Get title of degree
  def degree_title(degree)
    degree.xpath(".//p[@class='edu_title']").text
  end

  # Get where the school is
  def school_location(degree)
    degree.xpath(".//span[@itemprop='addressLocality']").text
  end

  # Get start date for degree
  def degree_start_date(degree)
    parse_dates(degree.xpath(".//p[@class='edu_dates']").text)[0]
  end

  # Get degree end date
  def degree_end_date(degree)
    parse_dates(degree.xpath(".//p[@class='edu_dates']").text)[1]
  end
end
