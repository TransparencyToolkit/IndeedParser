require 'requestmanager'
require 'json'
load 'indeed_personal_info.rb'
load 'indeed_jobs.rb'

class IndeedParser
  def initialize(html, url, crawler_fields)
    @html = html
    @url = url
    @crawler_fields = crawler_fields
    parse
  end

  # Parse profile
  def parse
    p = IndeedPersonalInfo.new(@html, @url)
    @personal_info = p.get_personal_info

    j = IndeedJobs.new(@html)
    @job_info = j.get_jobs
  end

  # Get output
  def get_results_by_job
    output = Array.new
    @job_info.each do |job|
      output.push(job.merge!(@personal_info).merge!(@crawler_fields))
    end

    JSON.pretty_generate(output)
  end
end

