class ReportController < ApplicationController
  include ReportHelper

  def active
    @workers = Worker.find(:all)
    @active_workers = [] # Have > 10 hours since last month
    @workers.each do |w|
      if w.sum_time_in_seconds(DateTime.now - 30.days, DateTime.now) > 36000
        @active_workers << w 
      end
    end
    @missing_list = []
    @active_workers.each do |w|
      if w.sum_time_in_seconds(DateTime.now - 14.days, DateTime.now) == 0
        @missing_list << w
      end
    end
  end

  # Page for hours that don't look right
  def admin
    work_times = WorkTime.find(:all, :conditions => 'admin_id IS NULL')
    @work_times, @logged_in, @long_volunteers = [], [], []
    work_times.each do |work_time|
      @work_times << work_time if work_time.visit_date == "Start and end date don't match"
      @logged_in << work_time if work_time.end_at.nil?
      if work_time.difference_in_hours > 5 && work_time.worker.status_id == 1
        @long_volunteers << work_time
      end
    end
  end

  def calendar
    @month = params[:month] ? params[:month].to_i : Time.now.month
    @year = params[:year] ? params[:year].to_i : Time.now.year
    options = {:year => @year, :month => @month, :first_day_of_week => 1}
    defaults = {
      :table_class => 'calendar',
      :month_name_class => 'monthName',
      :other_month_class => 'otherMonth',
      :day_name_class => 'dayName',
      :day_class => 'day',
      :abbrev => (0..2),
      :first_day_of_week => 1,
      :accessible => false,
      :show_today => true,
      :previous_month_text => nil,
      :next_month_text => nil
    }
    @first = Date.civil(options[:year], options[:month], 1)
    @last = Date.civil(options[:year], options[:month], -1)

    @first_weekday = first_day_of_week(options[:first_day_of_week])
    @last_weekday = last_day_of_week(options[:first_day_of_week])

    @day_names = Date::DAYNAMES.dup
    @first_weekday.times do
      @day_names.push(@day_names.shift)
    end
    
    @block ||= Proc.new {|d| nil}
    @options = defaults.merge options
  end

  def contact
    @workers = Worker.find(:all, :order => 'name')
  end

  def event
    @count = params[:n] ? params[:n].to_i : 0
    @event = Event.find(params[:id])
    @dates = @event.dates(@count)
  end

  def index
    @events = Event.all
  end

  def month
    @month = params[:month] ? params[:month].to_i : DateTime.now.month
    @year = params[:year] ? params[:year].to_i : DateTime.now.year
    @statuses = Status.find([1,2], :order => 'id DESC')

    @prev = WorkTime.prev(@year, @month)
    @next = WorkTime.next(@year, @month)

    @work_times, @workers, @total_time,
    @avg_time = WorkTime.find_stats_for(@year, @month)
  end

  def monthly
    @month = DateTime.now.month
    @year = DateTime.now.year
  end

  def volunteer
    @worker = Worker.find( params[:id] )
    @work_times = @worker.work_times
  end

  def week
    # SELECT start_at FROM work_times where start_at > '2008-01-01';
    # SELECT start_at FROM work_times where start_at BETWEEN '2008-01-01' AND '2008-01-31;
    # >>  "Sun Oct 05 22:48:45 -0500 2008".to_datetime
    # => Sun, 05 Oct 2008 22:48:45 +0000
    # ???
    now = Time.now
    @year = params[:year].nil? ? now.year : params[:year].to_i
    @month = params[:month].nil? ? now.month : params[:month].to_i
    @day = params[:day].nil? ? 1 : params[:day].to_i

    if params[:year].nil? and params[:day].nil? and params[:month].nil?
      @year, @month, @day = now.year, now.month, now.day
    end
    # TODO Assert sane values for date?
    
    options = {}
    defaults = {
      :table_class => 'calendar',
      :month_name_class => 'monthName',
      :other_month_class => 'otherMonth',
      :day_name_class => 'dayName',
      :day_class => 'day',
      :abbrev => (0..2),
      :first_day_of_week => 1,
      :accessible => false,
      :show_today => true,
      :previous_month_text => nil,
      :next_month_text => nil,
      # DEK new options start here
      :year => Time.now.year,
      :month => Time.now.month,
      :day => Time.now.day
    }
    @options = defaults.merge options

    # @last = Date.civil(@options[:year], @options[:month], @options[:day])
    @date = Date.civil(@year, @month, @day)
    ending = end_of_week(@date, 1)
    @last = Date.civil(ending.year, ending.month, ending.day)
    beg =  beginning_of_week(@date, 1)
    @first = Date.civil(beg.year, beg.month, beg.day)

    conditions = ["start_at BETWEEN ? AND ? ", beg.to_date, ending.to_date]
    @hours = WorkTime.find(:all, :conditions => conditions)

    @week_hash = {}

    @hours.each do |hour|
      @week_hash[hour.start_at.mday]
    end

    @first_weekday = first_day_of_week(@options[:first_day_of_week])
    @last_weekday = last_day_of_week(@options[:first_day_of_week])

    @day_names = Date::DAYNAMES.dup
    @first_weekday.times do
      @day_names.push(@day_names.shift)
    end
    
    @block ||= Proc.new {|d| nil}
  end

  def weekly
  end

  def year
    @year = params[:year] ? params[:year].to_i : Time.now.year

    @work_times, @workers, @total_time,
    @avg_time = WorkTime.find_stats_for(@year)

    @months = []
    12.downto(1) do |n|
      month = {:id => n}
      month[:name] = Date::MONTHNAMES[n]
      month[:work_times], 
      month[:workers], 
      month[:total_time], 
      month[:avg_time] = WorkTime.find_stats_for(@year, n)
      @months.push month
    end
  end

  def yearly
  end
end
