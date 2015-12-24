require 'nokogiri'
load 'indeed_utilities.rb'

class IndeedJobs
  include IndeedUtilities
  def initialize(html)
    @html = Nokogiri::HTML(html)

    jobs = @html.xpath("//div[contains(concat(' ',normalize-space(@class),' '),' work-experience-section ')]")
    @job_info = Array.new
    
    jobs.each do |job|
      @job_info.push({
        job_title: job_title(job),
        company: company(job),
        company_location: company_location(job),
        job_description: job_description(job),
        start_date: start_date(job),
        end_date: end_date(job)
      })
    end
  end

  # Return job info
  def get_jobs
    return @job_info
  end

  # Get job title
  def job_title(job)
    job.xpath(".//p[@class='work_title title']").text
  end

  # Get company
  def company(job)
    job.xpath(".//div[@class='work_company']//span").first.text
  end

  # Get work location
  def company_location(job)
    job.xpath(".//div[@class='work_company']//div[@class='inline-block']//span").text
  end

  # Get job description
  def job_description(job)
    job.xpath(".//p[@class='work_description']").text
  end

  # Get start date
  def start_date(job)
    parse_dates(job.xpath(".//p[@class='work_dates']").text)[0]
  end

  # Get end date
  def end_date(job)
    parse_dates(job.xpath(".//p[@class='work_dates']").text)[1]
  end
end
