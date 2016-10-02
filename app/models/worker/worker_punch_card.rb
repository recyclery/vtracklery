module Worker::WorkerPunchCard
  extend ActiveSupport::Concern

  included do
    scope :clocked_in, -> { where(in_shop: true) }
    scope :clocked_out, -> { where(in_shop: false).order('updated_at DESC') }
  end

  # Class methods added to the object when {Worker::WorkerPunchCard}
  # is included
  #
  # I don't think any of these are used, as they are broken.
  module ClassMethods
    # @param worker [Worker]
    # @param t [DateTime] the time the worker clocked in
    # @return [WorkTime]
    def clock_in(worker, t = DateTime.current)
      worker = Worker.find(params[:person])
      return worker.clock_in(t)
    end

    # @param worker [Worker]
    # @param t [DateTime] the time the worker clocked in
    # @return [Boolean]
    def clock_in!(worker, t = DateTime.current)
      worker = Worker.find(params[:person])
      return worker.clock_in!(t)
    end

    # @param worker [Worker]
    # @param t [DateTime] the time the worker clocked out
    # @return [WorkTime]
    def clock_out(worker, t = DateTime.current)
      worker = Worker.find(params[:person])
      return worker.clock_out(t)
    end

    # @param worker [Worker]
    # @param t [DateTime] the time the worker clocked out
    # @return [Boolean]
    def clock_out!(worker, t = DateTime.current)
      worker = Worker.find(params[:person])
      return worker.clock_out!(t)
    end
  end

  # @param t [DateTime] the time the worker clocked in
  # @return [WorkTime] the {WorkTime} with :start_at and :worker_id filled in
  def clock_in(t = DateTime.current)
    work_time = self.work_times.build()
    self.updated_at = t
    work_time.start_at = t
    self.in_shop = true
    return work_time
  end

  # Should be a transaction?
  #
  # @param t [DateTime] the time the worker clocked in
  # @return [Boolean] true if both the Worker updated_at is touched and
  #   the WorkTime is saved.
  def clock_in!(t = DateTime.current)
    work_time = self.clock_in(t)
    return self.save && work_time.save
  end

  # @param t [DateTime] the time the worker clocked out
  # @return [WorkTime] the last {WorkTime} is given a :end_at value, and
  #   :updated_at and :in_shop is updated.
  def clock_out(t = DateTime.current)
    work_time = self.work_times.last
    self.updated_at = t  # To help sort by recently in shop
    work_time.end_at = t
    self.in_shop = false
    # Should work_time be saved?
    return work_time
  end

  # Should be a transaction?
  #
  # @param t [DateTime] the time the worker clocked out
  # @return [Boolean] true if both the Worker updated_at is touched and
  #   the WorkTime is saved.
  def clock_out!(t = DateTime.current)
    work_time = self.clock_out(t)
    return self.save && work_time.save
  end

  # @return [Boolean] true if the last {WorkTime} record is open
  def is_in_shop?
    return latest_record.is_open?
  end

  # @return [WorkTime] the latest {WorkTime} record sorted by :start_at
  def latest_record
    @sorted_hours ||= work_times.sort_by { |h| h.start_at }
    return @sorted_hours[-1]
  end

  # @return [WorkTime] oldest {WorkTime} record sorted by :start_at
  def oldest_record
    @sorted_hours ||= work_times.sort_by { |h| h.start_at }
    @sorted_hours[0]
  end

  # @return [String] translated string for {Worker} at-work or last visit
  def last_visit_text
    if not has_hours? then I18n.t "messages.new_volunteer"
    elsif is_in_shop? then I18n.t "messages.in_shop"
    else I18n.t "messages.last_visit", latest_date: latest_record.end_date
    end
  end

end
