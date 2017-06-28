#
# Methods for manipulating {Worker} {WorkTime} records.
#
module Worker::WorkerHours
  extend ActiveSupport::Concern

  included do
  end

  # Class methods added to the object when {Worker::WorkerHours}
  # is included
  #
  #module ClassMethods
  #end

  # @return [Boolean] true unless there are no :work_times records
  def has_hours?
    work_times.empty? ? false : true
  end

  # @param year [Integer]
  # @param month [Integer]
  def last_month_time_in_seconds(year, month)
    date = Time.new(year, month) - 1.month
    return sum_time_in_seconds(date.beginning_of_month, date.end_of_month)
  end

  # @param year [Integer]
  # @param month [Integer]
  def last_month_time_in_minutes(year, month)
    return last_month_time_in_seconds(year, month) / 60
  end

  # @param year [Integer]
  # @param month [Integer]
  def month_time_in_seconds(year, month)
    date = Time.new(year, month)
    return sum_time_in_seconds(date.beginning_of_month, date.end_of_month)
  end

  # @param year [Integer]
  # @param month [Integer]
  def month_time_in_minutes(year, month)
    return month_time_in_seconds(year, month) / 60
  end

  # @param year [Integer]
  # @param month [Integer]
  def month_time_in_hours(year, month)
    return month_time_in_minutes(year, month) / 60
  end

  # @param begin_time [DateTime]
  # @param end_time [DateTime]
  # @return [Integer] the difference between the times in seconds
  def sum_time_in_seconds(begin_time, end_time)
    time = WorkTime.worker_id_between(id, begin_time, end_time)
    return time.to_a.sum(&:difference_in_seconds)
  end

	# @return [Integer] the number of youth points the youth volunteer has
	def youth_points
    time = WorkTime.worker_id_between(id, 1.year.ago, Time.current).includes(:work_status).where("work_statuses.name IS \"#{WorkStatus::YOUTHPOINTS}\"").references("work_statuses")
    hours = time.to_a.sum(&:difference_in_seconds) / (60 * 60)
    transaction_points = YouthPointTransaction.where(worker_id: id).map(&:points).sum
    hours - transaction_points
	end

  # @param begin_time [DateTime]
  # @param end_time [DateTime]
  # @return [Integer] the difference between the times in hours
  def sum_time_in_hours(begin_time, end_time)
    return sum_time_in_seconds(begin_time, end_time) / (60 * 60)
  end

  # @param year [Integer]
  def year_time_in_seconds(year)
    date = Time.new(year)
    return sum_time_in_seconds(date.beginning_of_year, date.end_of_year)
  end

  # @param year [Integer]
  def year_time_in_minutes(year)
    return year_time_in_seconds(year) / 60
  end

  # @param year [Integer]
  def year_time_in_hours(year)
    return year_time_in_minutes(year) / 60
  end

  # Used to calculate active workers for the purposes of discounts and freebees
  #
  # @param now [DateTime] the time during a month after the last complete month
  # @return [Array<Integer>] 12 place array of hours for each of the
  #   previous months
  def hours_year_array(now = DateTime.now)
    # size 12 array: the last 12 months
    month_arr = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    cur_month_t = now.at_beginning_of_month # first day of month
    12.times do |n|
      t = cur_month_t - n.months
      minutes = self.month_time_in_minutes(t.year, t.month)
      month_arr[n] = minutes / 60.0
    end
    return month_arr
  end

end
