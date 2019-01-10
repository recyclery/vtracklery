class ReportController < ApplicationController
  include ReportHelper

  # Page for hours that don't look right
  #
  # GET /report/admin
  def admin
    @work_times = WorkTime.mismatched_dates
    @logged_in = WorkTime.logged_in
    @long_volunteers = WorkTime.long_volunteers
  end

  # GET /report/admin_month
  def admin_month
    @work_times = WorkTime.find_since(Date.today - 21).long_volunteers
  end

  # GET /report/calendar/2015/12
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

  # GET /report/contact
  def contact
    @workers = Worker.order(:name)
  end

  # GET /report/event/1
  def event
    @count = params[:n] ? params[:n].to_i : 0
    @event = Event.find(params[:id])
    @dates = @event.dates(@count)
  end

  # GET /report
  def index
    @events = Event.all
  end

  # GET /report/month/2015/12
  def month
    @month = params[:month] ? params[:month].to_i : DateTime.now.month
    @year = params[:year] ? params[:year].to_i : DateTime.now.year
    @statuses = Status.find([1,2]).sort_by(&:id).reverse

    @prev = WorkTime.prev(@year, @month)
    @next = WorkTime.next(@year, @month)

    @work_times, @workers, @total_time,
    @avg_time = WorkTime.find_stats_for(@year, @month)
  end

  # GET /report/month/2015/12/totals
  def month_totals
    @month = params[:month] ? params[:month].to_i : DateTime.now.month
    @year = params[:year] ? params[:year].to_i : DateTime.now.year
    @statuses = Status.find([1,2]).sort_by(&:id).reverse

    @prev = WorkTime.prev(@year, @month)
    @next = WorkTime.next(@year, @month)

    @work_times, @workers, @total_time,
    @avg_time = WorkTime.find_stats_for(@year, @month)
  end

  # GET /report/monthly
  def monthly
    @current_year = DateTime.now.year
    if params[:year] && (params[:year].to_i != @current_year)
      @year = params[:year].to_i
    else
      @year = @current_year
      @month = DateTime.now.month
    end
  end

  # GET /report/regular
  def regular
    @workers = Worker.all
    # Have > 10 hours since last month
    @regular_workers = Worker.regular_workers
    @missing_list = Worker.missing_list
  end

  # GET /report/volunteer/1
  def volunteer
    @worker = Worker.find( params[:id] )
    @work_times = @worker.work_times
  end

  # GET /report/week/2015/12/31
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

    beg = beginning_of_week(@date, 1)
    ending = end_of_week(@date, 1)
    @last = Date.civil(ending.year, ending.month, ending.day)
    @first = Date.civil(beg.year, beg.month, beg.day)
    @hours = WorkTime.between(beg, ending)

    # @week_hash = {}
    # @hours.each { |hour| @week_hash[hour.start_at.mday] }

    @first_weekday = first_day_of_week(@options[:first_day_of_week])
    @last_weekday = last_day_of_week(@options[:first_day_of_week])

    @day_names = Date::DAYNAMES.dup
    @first_weekday.times { @day_names.push(@day_names.shift) }

    @block ||= Proc.new {|d| nil}
  end

  # GET /report/weekly
  def weekly
  end

  # GET /report/year/2015
  def year
    @statuses = Status.find([1,2]).sort_by(&:id).reverse
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

  # Member Hours Year Report
  #
  # GET /report/year/2015/hoursm
  def year_hoursm
    @status = Status.member
    @year = params[:year].to_i
    @workers = WorkTime.worker_type_for(@status, @year)
  end

  # Staff Hours Year Report
  # Note that this is volunteer time the staff puts in.
  # Paid staff time is not recorded in this application.
  #
  # GET /report/year/2015/hourss
  def year_hourss
    @status = Status.staff
    @year = params[:year].to_i
    @workers = WorkTime.worker_type_for(@status, @year)
  end

  # Volunteer Hours Year Report
  #
  # GET /report/year/2015/hoursv
  def year_hoursv
    @status = Status.volunteer
    @year = params[:year].to_i
    @workers = WorkTime.worker_type_for(@status, @year)
  end

  # Youth Hours Year Report
  #
  # GET /report/year/2015/hoursy
  def year_hoursy
    @status = Status.youth
    @year = params[:year].to_i
    @workers = WorkTime.worker_type_for(@status, @year)
  end

  # GET /report/year/2015/newv
  def year_newv
    @year = params[:year].to_i
    @begin = DateTime.new(@year, 1, 1)
    @end = @begin.end_of_year
    @workers = Worker.where(created_at: @begin..@end).order(:created_at)
  end

  # GET /report/yearly
  def yearly
    @last_year = (DateTime.now - 1.year).year
    @first_year = WorkTime.oldest.start_at.year
  end

end
