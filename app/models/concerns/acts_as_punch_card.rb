#
# Generic concern for clocking in and out. Only uses the start_at and end_at
# fields of the inheriting object.
#
module ActsAsPunchCard
  extend ActiveSupport::Concern

  #included do
  #end

  module ClassMethods
    def punch_message(minutes)
      hours = (minutes / 60).to_i

      case minutes
      when 0
        "less than a minute.  Oops?"
      when 1
        "barely a minute.  Cumon!  Don't waste my time."
      when 2..10
        "less than ten minutes.  That shouldn't count!"
      when 10..59
        "#{minutes} minutes."
      when 60..119
        "one hour and #{minutes % (hours * 60)} minutes."
      else
        "#{hours} hours and #{minutes % (hours * 60)} minutes."
      end
    end

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
    
  end
  
  # Note that leading zeros are replaced with spaces in all functions
  # except for datetime; FMT_TIME/CSV may have leading whitespace
  FMT_DATETIME = "%a %b %d %I:%M %p %Y" # "Mon Oct 06 05:18 PM 2008"
  FMT_DATE = "%a %d %b %Y"              # "Mon 06 Oct 2008"
  FMT_TIME = "%I:%M %p"                 # "05:18 PM"
  FMT_STAMP = "%a %d%b%Y %I:%M&nbsp;%p" # "Mon 06Oct2008 05:18&nbsp;PM"
  FMT_CSV   = "%m/%d/%y %I:%M %p"       # "12/31/99 12:01 PM"
  
  def wday; self.start_at.wday; end
  def yday; self.start_at.yday; end
  #def sec; self.start_at.sec; end
  #def min; self.start_at.min; end
  #def hour; self.start_at.hour; end
  def cday; self.start_at.cday; end
  def cweek; self.start_at.cweek; end
  def cwyear; self.start_at.cwyear; end
  def day; self.start_at.day; end
  def month; self.start_at.month; end
  def year; self.start_at.year; end
  
  def difference?
    if self.end_at
      raise "End before start: #{id}" if start_at > self.end_at
      return true
    end
    return false
  end
  
  def difference_in_seconds
    #unless self.end.nil? or self.start_at.nil?
    return 0 unless self.end_at && start_at
    ( self.end_at - start_at ).to_i
  end
  
  def difference_in_minutes
    #unless self.end.nil? or self.start_at.nil?
    return 0 unless self.end_at && start_at
    (( self.end_at - start_at ) / 60).to_i
  end
        
  def difference_in_hours
    return 0 unless self.end_at && start_at
    ((( self.end_at - start_at ) / 60) / 60).to_i
  end

  def difference_to_s
    return "" unless difference?
    return self.class.stringify_minutes( difference_in_minutes )
  end

  def punch_message
    return self.class.punch_message( difference_in_minutes )
  end

  def start_datetime # "Sun Oct 05 01:13 PM 2008"
    start_at.strftime("%a %b %d %I:%M %p %Y")
  end
    
  def start_date # "Sun Oct 05 01:13 PM 2008"
    start_at.strftime("%a %d %b %Y").gsub(/\s0/, " ")
  end
  
  def start_time
    start_at.strftime("%I:%M %p").gsub(/^0/, " ").strip
  end
        
  def start_stamp
    start_at.strftime("%a %d%b%Y %I:%M&nbsp;%p").gsub(/\s0/, " ")
  end
  
  def start_csv
    start_at.strftime(FMT_CSV).gsub(/\s0/, " ").strip
  end

  def end_datetime # "Sun Oct 05 01:13 PM 2008"
    if self.end_at.nil?
      "n/a"
    else
      self.end_at.strftime("%a %b %d %I:%M %p %Y")
    end
  end
    
  def end_date # "Sun Oct 05 01:13 PM 2008"
    return nil unless self.end_at
    self.end_at.strftime("%a %d %b %Y").gsub(/\s0/, " ")
  end
    
  def end_time
    return nil unless self.end_at
    self.end_at.strftime("%I:%M %p").gsub(/^0/, " ").strip
  end
    
  def end_stamp
    return nil unless self.end_at 
    self.end_at.strftime("%a %d%b%Y %I:%M&nbsp;%p").gsub(/\s0/, " ")
  end
        
  def end_csv
    return nil unless self.end_at 
    self.end_at.strftime(FMT_CSV).gsub(/\s0/, " ").strip
  end

  def is_open?; self.end_at.nil?; end
  def is_closed?; not is_open?; end
  
  def is_today?
    DateTime.now.strftime("%a%d%b%Y") == start_at.strftime("%a%d%b%Y")
  end
        
  def visit_date
    if is_open? or start_date == self.end_date
      start_date
    else
      "Start and end date don't match"
    end
  end

end
