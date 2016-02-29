#
# Alternate names for WorkTime methods
#
module WorkTime::WorkTimeAlternates
  extend ActiveSupport::Concern

  included do
    delegate :name, to: :worker, prefix: true
    delegate :name, to: :status, prefix: true
    delegate :name, to: :work_status, prefix: true
  end

  # @param val [String]
  # @return [String]
  def worker_name=(val)
    unless val.blank?
      self.worker = Worker.find_by_name(val)
    end
  end

  # @param val [String]
  # @return [String]
  def status_name=(val)
    unless val.blank?
      self.status = Status.find_by_name(val)
    end
  end

  # @param val [String]
  # @return [String]
  def work_status_name=(val)
    unless val.blank?
      self.work_status = WorkStatus.find_by_name(val)
    end
  end

end
