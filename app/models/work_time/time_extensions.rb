module WorkTime::TimeExtensions
  extend ActiveSupport::Concern

  #included do
  #end

  def difference_to_s
    return "" unless difference?
    minutes = difference_in_minutes
    hours = difference_in_hours
    case minutes
    when 0
      "< 1 minute"
    when 1
      "1 minute"
    when 2..59
      "#{minutes} minutes"
    when 60
      "1 hour"
    when 61
      "1 hr 1 min"
    when 62..119
      # "1 hour #{minutes % (hours * 60)} minutes"
      "1 hr #{minutes % (hours * 60)}min"
    when 120
      "2 hours"
    when 121
      "2 hr 1 min"
    else
      "#{hours} hr #{minutes % (hours * 60)} min"
    end
  end

  module ClassMethods
    # Plugin Class Methods
    def stringify_minutes(minutes)
      hours = minutes_to_hours(minutes)
      case minutes
      when 0
        "< 1 minute"
      when 1
        "1 minute"
      when 2..59
        "#{minutes} minutes"
      when 60
        "1 hour"
      when 61
        "1 hr 1 min"
      when 62..119
        # "1 hour #{minutes % (hours * 60)} minutes"
        "1 hr #{minutes % (hours * 60)} min"
      when 120
        "2 hours"
      when 121
        "2 hr 1 min"
      else
        "#{hours}h #{minutes % (hours * 60)} min"
      end
    end
    
    def stringify_seconds(seconds)
      stringify_minutes(seconds_to_minutes(seconds))
    end
    
    def stringify_hours(hours)
      stringify_minutes(hours * 60)
    end
    
    def prev(year = Time.now.year, month = nil)
      year = year.to_i
      if month &&= month.to_i
        (month == 1) ? {month: 12, year: year - 1} : 
          {month: month - 1, year: year }        
      else
        year - 1
      end
    end
    
    def next(year = Time.now.year, month = nil)
      year = year.to_i
      if month &&= month.to_i
        (month == 12) ? {month: 1, year: year + 1} : 
          {month: month + 1, year: year }        
      else
        year + 1
      end    
    end
    
    def start_of_month(month = Time.now.month, year = Time.now.year)
      DateTime.new(year, month)
    end
    
    def end_of_month(month = Time.now.month, year = Time.now.year)
      if 12 == month
        end_of_year(year)
      else
        DateTime.new(year, month + 1) - 1.second
      end
    end
    
    def start_of_year(year = Time.now.year)
      DateTime.new(year)
    end
    
    def end_of_year(year = Time.now.year)
      DateTime.new(year + 1) - 1.second
    end
    
    def seconds_to_minutes(seconds)
      (seconds / 60).to_i
    end
    
    def minutes_to_hours(minutes)
      (minutes / 60).to_i
    end
  end
end
