require 'date'

module Utilities
  # Parse dates
  def parse_dates(dates)
    start_date, end_date = dates
    
    if dates.include?(" to ")
      start_date, end_date = dates.split(" to ")
    end

    return date_normalize(start_date), date_normalize(end_date)
  end

  def date_normalize(date)
    begin
      date = date+"-01-01" if date =~ /^(19|20)\d{2}$/
      return Date.parse(date)
    rescue
      return date
    end
  end
end
