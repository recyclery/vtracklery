module WorkTime::Finder
  extend ActiveSupport::Concern

  #included do
  #end

  module ClassMethods
    def find_by_start_date(*args)
      if 1 == args.size && args[0].respond_to?(:year) && 
          args[0].respond_to?(:month) && args[0].respond_to?(:day)
        year, month, day = args[0].year, args[0].month, args[0].day
      elsif 3 == args.size && args[0].is_a?(Integer) && 
          args[1].is_a?(Integer) && args[2].is_a?(Integer)
        year, month, day = args
      else raise "Bad input error: #{args.inspect}"
      end
      beg = Date.civil(year, month, day)
      ending = beg + 1
      conditions = ["start_at BETWEEN ? AND ? ", beg.to_date, ending.to_date]
      hours = WorkTime.where(conditions)
      return hours
    end

    def find_stats_for(year = Time.now.year, month = nil)
      work_times = WorkTime.find_for(year, month)
      workers = WorkTime.workers_for(year, month)
      total_time_in_seconds = WorkTime.time_for(year, month)
      total_time = WorkTime.stringify_seconds(total_time_in_seconds)
      if workers.blank?
        avg_time = 0
      else
        avg_time_in_seconds = total_time_in_seconds / workers.size
        avg_time = WorkTime.stringify_seconds(avg_time_in_seconds)
      end
      return [work_times, workers, total_time, avg_time]
    end

    def status_stats_for(sts, year = Time.now.year, month = nil)
      work_times = find_status_for(sts, year, month)
      workers = worker_type_for(sts, year, month)
      total_in_seconds = status_time_for(sts, year, month)
      total = stringify_seconds(total_in_seconds)
      if workers.blank?
        avg = 0
      else
        avg_in_seconds = total_in_seconds / workers.size
        avg = WorkTime.stringify_seconds(avg_in_seconds)
      end
      return [work_times, workers, total, avg]
    end
    
    # Get array of workers who were active during a given month or year
    def workers_for(year = Time.now.year, month = nil)
      year = year.to_i
      if month # Get all unique workers for the month
        month = month.to_i
        w_ids = find_for(year, month).map { |vh| vh.worker_id }.uniq
      else # Get all unique workers for the entire year
        w_ids = find_for(year).map { |vh| vh.worker_id }.uniq
      end
      Worker.find(w_ids)
    end
    
    def find_status_for(s, year = Time.now.year, month = nil)
      s_id = s.id
      #s_id = s.is_a? Fixnum ? s : s.id
      year = year.to_i
      if month
        month = month.to_i
        self.where(['start_at >= ? AND end_at <= ? AND status_id = ?', 
                    self.start_of_month(month, year),
                    self.end_of_month(month, year),
                    s_id])
      else
        self.where(['start_at >= ? AND end_at <= ? AND status_id = ?', 
                    self.start_of_year(year),
                    self.end_of_year(year),
                    s_id])
      end
    end
    
    def status_time_for(s, year = Time.now.year, month = nil)
      year = year.to_i
      time = 0
      if month # Get all unique volunteers for the month
        month = month.to_i
        find_status_for(s, year, month).each do |card| 
          time += card.difference_in_seconds if card.difference?
        end
      else # Get all unique volunteers for the entire year
        find_status_for(s, year).each do |card| 
          time += card.difference_in_seconds if card.difference?
        end
      end
      return time
    end
    
    def worker_type_for(s, year = Time.now.year, month = nil)
      #s_id = s.is_a? Status ? s.id : s
      s_id = s.id
      year = year.to_i
      if month # Get all unique workers with this status for the month
        month = month.to_i
        w_ids = find_for(year, month).map { |card| 
          card.worker_id if card.status_id == s_id  }.compact.uniq
      else # Get all unique workers with this status for the entire year
        w_ids = find_for(year).map { |card| 
          card.worker_id if card.status_id == s_id  }.compact.uniq
      end
      Worker.find(w_ids)
    end

    def time_for(year = Time.now.year, month = nil)
      year = year.to_i
      time = 0
      if month # Get all unique volunteers for the month
        month = month.to_i
        find_for(year, month).each do |card| 
          time += card.difference_in_seconds if card.difference?
        end
      else # Get all unique volunteers for the entire year
        find_for(year).each do |card| 
          time += card.difference_in_seconds if card.difference?
        end
      end
      return time
    end
        
    def find_for(year = Time.now.year, month = nil)
      year = year.to_i
      if month
        month = month.to_i
        self.where(['start_at >= ? AND end_at <= ?',
                    self.start_of_month(month, year),
                    self.end_of_month(month, year)]).order(:start_at)
      else
        self.where(['start_at >= ? AND end_at <= ?',
                    self.start_of_year(year),
                    self.end_of_year(year)]).order(:start_at)
      end
    end
    
    def find_for_this_month
      year, month = Time.now.year, Time.now.month
      s_at = self.start_of_month(month, year)
      self.where(['start_at >= ?', s_at]).order(:start_at)
    end

  end
end
