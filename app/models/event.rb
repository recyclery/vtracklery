class Event < ActiveRecord::Base
  include Runt
  include XmlExtensions

  DAY_OF_THE_WEEK_OPTIONS = [%w(Sunday 0), %w(Monday 1), %w(Tuesday 2), %w(Wednesday 3), %w(Thursday 4), %w(Friday 5), %w(Saturday 6)]
  MINUTE_OPTIONS = 0.step(45,15).map {|n| [ n == 0 ? '00' : n , n]}
  START_HOUR_OPTIONS = 7.upto(23).map {|n| [ (n % 12) == 0 ? 12 : n % 12, n]}
  END_HOUR_OPTIONS = 8.upto(24).map {|n| [ (n % 12) == 0 ? 12 : n % 12, n]}

  def texpr; @texpr ||= compose_temporal_expression; end

  def compose_temporal_expression(day = wday, shr = s_hr, smin = s_min, ehr = e_hr, emin = e_min)
    DIWeek.new(day) & REDay.new(shr, smin, ehr, emin)
  end

  def week_day; DateTime::DAYNAMES[wday]; end
  def first_date; first_at.strftime("%a %b %d %Y") if first_at; end
  def last_date; last_at.strftime("%a %b %d %Y") if last_at; end
  def s_time; DateTime.new(1,1,1,s_hr,s_min); end
  def start_time; s_time.strftime("%I:%M %p") if s_time; end
  def e_time; DateTime.new(1,1,1,e_hr,e_min); end
  def end_time; e_time.strftime("%I:%M %p") if e_time; end

  def include?(time)
    case time
    when DateTime
      texpr.include? time
    when WorkTime # Tests get progressively more computationally intensive
      # Reject if the day of the week doesn't match
      return false unless wday == time.start_at.wday

      # time start before event end; time end after event start
      # Test if event range contains either start or end time
      return true  if texpr.include? time.start_at
      return true  if texpr.include? time.end_at
      # Create a Texpr from work time and see if event is contained in st or et
      work_texpr = REDay.new(time.start_at.hour, time.start_at.min,
                             time.end_at.hour, time.end_at.min)
      return true if work_texpr.include? s_time
      return true if work_texpr.include? e_time
      return false
    end
  end

  #class EventDate
  #  attr_reader :times, :date
  #  def initialize(date)
  #    @date = DateTime.new(date)
  #    @times = WorkTime.find_by_start_date(self)
  #  end
  #end
  def dates(n = 0, per_page = 10)
    @dates = []
    n.upto(n + per_page) do |n|
      if first_at.wday == wday
        date = first_at + (n * 7).days
      elsif first_at.wday > wday
        date = first_at + (7 - first_at.wday + wday).days + (n * 7).days
      elsif first_at.wday < wday
        date = first_at + (wday - first_at.wday).days + (n * 7).days
      end

      @dates << [date, WorkTime.find_by_start_date(date)]
    end
    return @dates
  end
end
