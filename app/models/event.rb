#
# Weekly scheduled events.
#
class Event < ActiveRecord::Base
  include Runt
  include XmlExtensions

  # Array of tuples of [WeekdayName, id]
  DAY_OF_THE_WEEK_OPTIONS = [%w(Sunday 0), %w(Monday 1), %w(Tuesday 2), %w(Wednesday 3), %w(Thursday 4), %w(Friday 5), %w(Saturday 6)]
  # Array of tuples separated by 15
  MINUTE_OPTIONS = 0.step(45,15).map {|n| [ n == 0 ? '00' : n , n]}
  # Array of tuples starting at 7am, ending at 23pm
  START_HOUR_OPTIONS = 7.upto(23).map {|n| [ (n % 12) == 0 ? 12 : n % 12, n]}
  # Array of tuples starting at 8am, ending at 24pm
  END_HOUR_OPTIONS = 8.upto(24).map {|n| [ (n % 12) == 0 ? 12 : n % 12, n]}

  # @return [Runt::Intersect] temporal expression
  def texpr; @texpr ||= compose_temporal_expression; end

  # @param day [Integer] day of the week (0..6)
  # @param shr [Integer] start hour
  # @param smin [Integer] start minute
  # @param ehr [Integer] end hour
  # @param emin [Integer] end minute
  # @return [Runt::Intersect] temporal expression
  def compose_temporal_expression(day = wday, shr = s_hr, smin = s_min, ehr = e_hr, emin = e_min)
    DIWeek.new(day) & REDay.new(shr, smin, ehr, emin)
  end

  # @return [String] the weekday name
  def week_day; DateTime::DAYNAMES[wday]; end

  # @return [String,nil] the first event date as a string
  def first_date; first_at.strftime("%a %b %d %Y") if first_at; end

  # @return [Integer] the first year the event existed
  def first_year; first_at ? first_at.year : 2008; end

  # @return [String,nil] the last event date as a string (nil means ongoing)
  def last_date; last_at.strftime("%a %b %d %Y") if last_at; end

  # @param year [Integer]
  # @param month [Integer]
  # @return [DateTime] the first day the weekly event occurs in a given month
  def first_day_of_month(year, month)
    first_day = Date.new(year,month,1)
    first_wday = first_day.wday

    if self.wday == first_wday then return first_day
    elsif self.wday > first_wday
      return first_day + (self.wday - first_wday)
    else
      return first_day + (7 - first_wday + self.wday)
    end

  end

  # @return [Integer] the last year the event existed (or the current year)
  def last_year; last_at ? last_at.year : Date.today.year; end

  # @return [DateTime]
  def s_time; DateTime.new(1,1,1,s_hr,s_min); end

  # @return [String]
  def start_time; s_time.strftime("%I:%M %p") if s_time; end

  # @return [DateTime]
  def e_time; DateTime.new(1,1,1,e_hr,e_min); end

  # @return [String]
  def end_time; e_time.strftime("%I:%M %p") if e_time; end

  # @param time [DateTime,WorkTime]
  # @return [Boolean]
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

  # For building a calendar
  #
  # @param n [Integer] (default: 0)
  # @param per_page [Integer] (default: 10)
  # @return [Array< [DateTime, WorkTime] >] array of date tuples
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

  # Attributes accessible via the API
  API_ATTRIBUTES = [ :id, :name, :first_at, :last_at,
                     :wday, :s_hr, :s_min, :e_hr, :e_min,
                     :created_at, :updated_at ]

  # Attributes accessible via the web interface
  WEB_PARAMS = [ :name, :first_at, :last_at,
                 :wday, :s_hr, :s_min, :e_hr, :e_min ]

end
