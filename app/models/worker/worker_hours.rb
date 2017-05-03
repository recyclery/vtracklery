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
    time.to_a.sum(&:difference_in_seconds) / (60 * 60)
	end

  # @param begin_time [DateTime]
  # @param end_time [DateTime]
  # @return [Integer] the difference between the times in hours
  def sum_time_in_hours(begin_time, end_time)
    return sum_time_in_seconds(begin_time, end_time) / (60 * 60)
  end

end
