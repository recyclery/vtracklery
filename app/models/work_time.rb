class WorkTime < ActiveRecord::Base
  belongs_to :work_status
  belongs_to :worker
  belongs_to :status
  belongs_to :admin, :class_name => "Worker"

  include ActsAsPunchCard
  include TimeExtensions
  include Finder

  #acts_as_punch_card
  before_create :inherit_status

  validates_presence_of :start_at, :worker_id

  STATUS = ["Volunteer", "Earn-a-bike", "Paid"] 

  delegate :name, to: :worker, prefix: true
  def worker_name=(val)
    self.worker.name = val
  end
  delegate :name, to: :status, prefix: true
  def status_name=(val)
    self.status.name = val
  end
  delegate :name, to: :work_status, prefix: true
  def work_status_name=(val)
    self.work_status.name = val
  end

  # Automatically inherit the status of the worker that created it
  def inherit_status
    self.status_id = worker.status_id if status_id.nil?
    self.work_status_id = worker.work_status_id if work_status_id.nil?
  end
end
