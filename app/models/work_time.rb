#
# The hours worked by a {Worker}.
#
class WorkTime < ActiveRecord::Base
  belongs_to :work_status
  belongs_to :worker
  belongs_to :status
  belongs_to :admin, :class_name => "Worker"

  include XmlExtensions
  include ActsAsPunchCard
  include WorkTime::WorkTimeAlternates
  include WorkTime::WorkTimeClock
  include WorkTime::WorkTimeFinder
  include WorkTime::WorkTimeReports

  before_create :inherit_status

  validates_presence_of :start_at, :worker_id

  #scope :non_admin, -> { where('admin_id IS NULL') }
  scope :between, ->(beg, ending) { where( start_at: 
                                           beg.to_date..ending.to_date ) }
  scope :worker_id_between, ->(worker_id, begin_time, end_time) do
    where(worker_id: worker_id, start_at: begin_time..end_time)
  end

  # Duplication of the {Status} object
  STATUS = ["Volunteer", "Earn-a-bike", "Paid"] 

  # Automatically inherit the status of the worker that created it
  # @return [Boolean] true (callback method)
  def inherit_status
    self.status_id = worker.status_id if status_id.nil?
    self.work_status_id = worker.work_status_id if work_status_id.nil?
    return true
  end

  # Attributes accessible via the API
  API_ATTRIBUTES = [ :id, :worker_name, :start_at, :end_at, :created_at, :updated_at ]
end
