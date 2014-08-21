module Worker::WorkerHours
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def has_hours?
    work_times.empty? ? false : true
  end

  def sum_time_in_seconds(begin_time, end_time)
    time = WorkTime.worker_id_between(id, begin_time, end_time)
    return time.to_a.sum(&:difference_in_seconds)
  end

  def sum_time_in_hours(begin_time, end_time)
    return sum_time_in_seconds(begin_time, end_time) / (60 * 60)
  end

end
