module Worker::WorkerAlternates
  extend ActiveSupport::Concern

  included do
    delegate :name, to: :status, prefix: true
    delegate :name, to: :work_status, prefix: true
  end

  # Class methods added to the object when {Worker::WorkerAlternates}
  # is included
  #
  #module ClassMethods
  #end

  # @param val [String]
  def status_name=(val)
    #self.status.name = val
    self.status = Status.find_by_name(val)
  end
  
  # @param val [String]
  def work_status_name=(val)
    #self.work_status.name = val
    self.work_status = WorkStatus.find_by_name(val)
  end

end
