class ExportController < ApplicationController
  def contact
    @workers = Worker.all
    render template: 'export/contact.csv.erb'
  end

  def email
    @workers = Worker.email_only
    render template: 'export/email.csv.erb'
  end

  def mailchimp
    @workers = Worker.has_email
    render template: 'export/mailchimp.csv.erb'
  end

  def month
    @month = params[:month] ? params[:month].to_i : DateTime.now.month
    @year = params[:year] ? params[:year].to_i : DateTime.now.year

    @work_times, @workers, @total_time,
    @avg_time = WorkTime.find_stats_for(@year, @month)

    send_csv(@work_times, "#{params[:year]}-#{"%0.2d" % @month}.csv") do |t|
      [t.difference_in_minutes, t.worker.name, t.start_csv]
    end
  end

  def no_contact
    @workers = Worker.no_contact
    render template: 'export/no_contact.csv.erb'
  end

  def phone
    @workers = Worker.has_phone
    render template: 'export/phone.csv.erb'
  end

  def worker_hours
    @worker = Worker.find(params[:id])
    send_csv(@worker.work_times, "#{@worker.name}.csv") do |h|
      [h.difference_in_minutes, h.worker.name, h.start_csv, h.end_csv]
    end
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

    send_csv(@months, "#{params[:year]}.csv") do |m|
      ["#{m[:name]} #{@year}", m[:workers].size, m[:total_time], m[:avg_time]]
    end
  end

  private
  # Couldn't figure out how to dynamically assign name via render
  def send_csv(array, filename = "data.csv")
    csv_data = ::CSV.generate do |csv|
      array.each { |row| csv << yield(row) }
    end
    send_data csv_data, :filename => filename, :type => 'text/csv'
  end

end
