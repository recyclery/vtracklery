#
# Methods to help with {WorkTime} reports
#
module WorkTime::WorkTimeReports
  extend ActiveSupport::Concern

  included do
    # WorkTimes that haven't been closed
    scope :logged_in, -> { where(end_at: nil) }
  end

  module ClassMethods

    # @return [Array<WorkTime>] volunteer WorkTimes longer than 5 hours
    def long_volunteers
      all.select do |work_time|
        work_time.difference_in_hours > 5 && work_time.worker.status_id == 1
      end
    end

    # @return [Array<WorkTime>] WorkTime where the start and end date aren't
    #    the same day (eg overnight login)
    def mismatched_dates
      all.select do |work_time|
        work_time.visit_date == "Start and end date don't match"
      end
    end

    # @return [Boolean] true if this month has volunteers whose hours went
    #   too long.
    def has_long_hours?
      find_for_this_month.long_volunteers.count > 0
    end

  end

end
