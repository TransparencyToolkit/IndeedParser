require 'nokogiri'
load 'indeed_utilities.rb'

class IndeedAwards
  include IndeedUtilities
  def initialize(html)
    awards = html.xpath("//div[contains(concat(' ',normalize-space(@class),' '),' award-section ')]")
    @award_list = Array.new
    
    awards.each do |award|
      @award_list.push({
                        award_title: award_title(award),
                        award_date: award_date(award),
                        award_description: award_description(award)
      })
    end
  end

  # Return award info
  def get_awards
    return @award_list
  end

  # Get title of award
  def award_title(award)
    award.xpath(".//p[@class='award_title']").text
  end

  # Get award date
  def award_date(award)
    award.xpath(".//p[@class='award_date']").text
  end

  # Get award description
  def award_description(award)
    award.xpath(".//p[@class='award_description']").text
  end
end
