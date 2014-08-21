module Worker::WorkerPunchCard
  extend ActiveSupport::Concern

  included do
    scope :clocked_in, -> { where(in_shop: true) }
    scope :clocked_out, -> { where(in_shop: false).order('updated_at DESC') }
  end

  module ClassMethods
    def clock_in(worker)
      worker = Worker.find(params[:person])
      return worker.clock_in
    end

    def clock_in!(worker)
      worker = Worker.find(params[:person])
      return worker.clock_in!
    end

    def clock_out(worker)
      worker = Worker.find(params[:person])
      return worker.clock_out
    end

    def clock_out!(worker)
      worker = Worker.find(params[:person])
      return worker.clock_out!
    end
  end

  # Returns the work_time with start_at filled in
  def clock_in
    work_time = self.work_times.build()
    self.updated_at = Time.now
    work_time.start_at = Time.now
    self.in_shop = true
    return work_time
  end

  # Should be a transaction?
  def clock_in!
    work_time = self.clock_in()
    return self.save && work_time.save
  end

  def clock_out
    work_time = self.work_times.last
    self.updated_at = Time.now  # To help sort by recently in shop
    work_time.end_at = Time.now
    self.in_shop = false
    return work_time
  end

  # Should be a transaction?
  def clock_out!
    work_time = self.clock_out()
    return self.save && work_time.save
  end

  def is_in_shop?
    latest_record.is_open?
  end

  def latest_record
    @sorted_hours ||= work_times.sort_by { |h| h.start_at }
    @sorted_hours[-1]
  end

  def oldest_record
    @sorted_hours ||= work_times.sort_by { |h| h.start_at }
    @sorted_hours[0]
  end

  def last_visit_text
    if not has_hours? then I18n.t "messages.new_volunteer"
    elsif is_in_shop? then I18n.t "messages.in_shop"
    else I18n.t "messages.last_visit", latest_date: latest_record.end_date
    end
  end

end
