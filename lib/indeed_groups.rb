require 'nokogiri'
load 'indeed_utilities.rb'

class IndeedGroups
  include IndeedUtilities
  def initialize(html)
    groups = html.xpath("//div[contains(concat(' ',normalize-space(@class),' '),' group-section ')]")
    @group_list = Array.new
    
    groups.each do |group|
      @group_list.push({
                                 group_title: group_title(group),
                                 group_description: group_description(group),
                                 group_start_date: group_start_date(group),
                                 group_end_date: group_end_date(group)
      })
    end
  end

  # Return group info
  def get_groups
    return @group_list
  end

  # Get title of group
  def group_title(group)
    group.xpath(".//p[@class='group_title']").text
  end

  # Get description of group
  def group_description(group)
    group.xpath(".//p[@class='group_description']").text
  end

  # Get start date for group
  def group_start_date(group)
    parse_dates(group.xpath(".//p[@class='group_date']").text)[0]
  end

  # Get group end date
  def group_end_date(group)
    parse_dates(group.xpath(".//p[@class='group_date']").text)[1]
  end
end
