module WorkTime::WorkTimeClock
  extend ActiveSupport::Concern

  #included do
  #end

  module ClassMethods
    # Plugin Class Methods
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
