module Worker::WorkerAlternates
  extend ActiveSupport::Concern

  included do
    delegate :name, to: :status, prefix: true
    delegate :name, to: :work_status, prefix: true
  end

  module ClassMethods
  end

  def status_name=(val)
    #self.status.name = val
    self.status = Status.find_by_name(val)
  end
  
  def work_status_name=(val)
    #self.work_status.name = val
    self.work_status = WorkStatus.find_by_name(val)
  end

end
