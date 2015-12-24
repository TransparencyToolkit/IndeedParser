require 'nokogiri'
load 'degrees.rb'
load 'military_service.rb'
load 'certifications.rb'
load 'rec_people.rb'
load 'links.rb'
load 'awards.rb'
load 'groups.rb'

class PersonalInfo
  def initialize(html, url)
    @raw_html = html
    @html = Nokogiri::HTML(html)
    @url = url

    @personal_info = {
      name: name,
      url: @url,
      location: location,
      current_title: current_title,
      skills: skills,
      summary: summary,
      additional_info: additional_info,
      last_updated: last_updated,
      degrees: degrees,
      military_service: military_service,
      certifications: certifications,
      rec_people: rec_people,
      links: links,
      awards: awards,
      groups: groups,
      fulltext: @raw_html
    }
  end

  # Return personal info hash
  def get_personal_info
    return @personal_info
  end

  # Get certification data
  def certifications
    c = Certifications.new(@html)
    c.get_certifications
  end

  # Get list of suggested resumes from side
  def rec_people
    r = RecPeople.new(@html)
    r.get_rec_people
  end

  # Get any links they list
  def links
    l = Links.new(@html)
    l.get_links
  end

  # Get list of awards
  def awards
    a = Awards.new(@html)
    a.get_awards
  end

  # Get list of groups
  def groups
    g = Groups.new(@html)
    g.get_groups
  end

  # Get list of degrees
  def degrees
    d = Degrees.new(@html)
    d.get_degrees
  end

  # Get military service
  def military_service
    m = MilitaryService.new(@html)
    m.get_military_service
  end

  # Get persons name
  def name
    @html.xpath("//h1[@itemprop='name']").text
  end

  # Get location
  def location
    @html.xpath("//p[@id='headline_location']").text
  end

  # Get overall job title
  def current_title
    @html.xpath("//h2[@id='headline']").text
  end

  # Get skills section
  def skills
    @html.xpath("//span[@class='skill-text']").text
  end

  # Get summary
  def summary
    @html.xpath("//p[@id='res_summary']").text
  end
  
  # Get additional info
  def additional_info
    @html.xpath("//div[@id='additionalinfo-section']//p").text
  end

  # Get last updated time
  def last_updated
    @html.xpath("//div[@id='resume_actions_contacted']").text.gsub("Updated: ", "")
  end
end
