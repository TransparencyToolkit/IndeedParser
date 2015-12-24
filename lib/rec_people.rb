require 'nokogiri'
load 'utilities.rb'

class RecPeople
  include Utilities
  def initialize(html)
    rec_people = html.css(".rec_resume")
    @rec_people_list = Array.new
    
    rec_people.each do |rec_person|
      @rec_people_list.push({
                              rec_person_name: rec_person_name(rec_person),
                              rec_person_link: rec_person_link(rec_person)
      })
    end
  end

  # Return person info
  def get_rec_people
    return @rec_people_list
  end

  # Get name of suggested person
  def rec_person_name(rec_person)
    rec_person.css("a").text
  end

  # Get name of suggested link
  def rec_person_link(rec_person)
    rec_person.css("a").first['href']
  end
end
