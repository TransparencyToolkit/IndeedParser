require 'nokogiri'
load 'indeed_utilities.rb'

class IndeedCertifications
  include IndeedUtilities
  def initialize(html)
    certifications = html.xpath("//div[contains(concat(' ',normalize-space(@class),' '),' certification-section ')]")
    @certification_list = Array.new
    
    certifications.each do |certification|
      @certification_list.push({
                                 cert_title: cert_title(certification),
                                 cert_description: cert_description(certification),
                                 cert_start_date: cert_start_date(certification),
                                 cert_end_date: cert_end_date(certification)
      })
    end
  end

  # Return cert info
  def get_certifications
    return @certification_list
  end

  # Get title of cert
  def cert_title(certification)
    certification.xpath(".//p[@class='certification_title']").text
  end

  # Get description of cert
  def cert_description(certification)
    certification.xpath(".//p[@class='certification_description']").text
  end

  # Get start date for cert validity
  def cert_start_date(certification)
    parse_dates(certification.xpath(".//p[@class='certification_date']").text)[0]
  end

  # Get cert end date
  def cert_end_date(certification)
    parse_dates(certification.xpath(".//p[@class='certification_date']").text)[1]
  end
end
