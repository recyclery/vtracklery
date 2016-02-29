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

  # @param begin_time [DateTime]
  # @param end_time [DateTime]
  # @return [Integer] the difference between the times in seconds
  def sum_time_in_seconds(begin_time, end_time)
    time = WorkTime.worker_id_between(id, begin_time, end_time)
    return time.to_a.sum(&:difference_in_seconds)
  end

  # @param begin_time [DateTime]
  # @param end_time [DateTime]
  # @return [Integer] the difference between the times in hours
  def sum_time_in_hours(begin_time, end_time)
    return sum_time_in_seconds(begin_time, end_time) / (60 * 60)
  end

end
