require 'nokogiri'
load 'utilities.rb'

class IndeedMilitaryService
  include Utilities
  def initialize(html)
    military_items = html.xpath("//div[contains(concat(' ',normalize-space(@class),' '),' military-section ')]")
    @military_service = Array.new
    
    military_items.each do |mil_item|
      @military_service.push({
                               military_country: military_country(mil_item),
                               military_branch: military_branch(mil_item),
                               military_rank: military_rank(mil_item),
                               military_description: military_description(mil_item),
                               military_commendations: military_commendations(mil_item),
                               military_start_date: military_start_date(mil_item),
                               military_end_date: military_end_date(mil_item)
      })
    end
  end

  # Return military service info
  def get_military_service
    return @military_service
  end

  # Get country of military service
  def military_country(mil_item)
    remove = mil_item.xpath(".//p[@class='military_country']//span").text
    mil_item.xpath(".//p[@class='military_country']").text.gsub(remove, "").strip.lstrip
  end

  # Get military branch
  def military_branch(mil_item)
    remove = mil_item.xpath(".//p[@class='military_branch']//span").text
    mil_item.xpath(".//p[@class='military_branch']").text.gsub(remove, "").strip.lstrip
  end

  # Get military rank
  def military_rank(mil_item)
    remove = mil_item.xpath(".//p[@class='military_rank']//span").text
    mil_item.xpath(".//p[@class='military_rank']").text.gsub(remove, "").strip.lstrip
  end
  
  # Get military description
  def military_description(mil_item)
    mil_item.xpath(".//p[@class='military_description']").text
  end

  # Get military commendations
  def military_commendations(mil_item)
    mil_item.xpath(".//p[@class='military_commendations']").text
  end

  # Get start date
  def military_start_date(mil_item)
    parse_dates(mil_item.xpath(".//p[@class='military_date']").text)[0]
  end

  # Get end date
  def military_end_date(mil_item)
    parse_dates(mil_item.xpath(".//p[@class='military_date']").text)[1]
  end
end
