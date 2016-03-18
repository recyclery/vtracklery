#
# The Employees/Volunteers of the Shop
#
class Worker < ActiveRecord::Base
  has_many :work_times, dependent: :destroy
  has_one :survey, dependent: :destroy
  belongs_to :status
  belongs_to :work_status

  validates_presence_of :name

  include XmlExtensions
  include Worker::WorkerAlternates
  include Worker::WorkerHours
  include Worker::WorkerImage
  include Worker::WorkerPhone
  include Worker::WorkerPunchCard
  include Worker::WorkerReports

  STATUS = ["Volunteer", "Member", "Paid Staff"] 

  scope :email_only, -> { where("email IS NOT NULL AND phone IS NULL") }
  scope :has_email, -> { where("email IS NOT NULL") }
  scope :has_phone, -> { where("phone IS NOT NULL") }
  scope :no_contact, -> { where("email IS NULL AND phone IS NULL") }

  # @return [String] "%a %b %d %Y" formatted :created_at datetime
  def created_datetime
    created_at.strftime("%a %b %d %Y")
  end

  # Remove non-standard spaces and dashes and replace with ascii?
  #
  # @return [String] standardized version of worker name for filenames etc.
  def shoehorn_name
    name.split(/\s/).map {|n| 
      n.split('-').map { |nn| 
        nn.capitalize }.join("-")}.join(" ")
  end

  # Attributes accessible via the API
  API_ATTRIBUTES = [ :id, :name, :image, :in_shop,
                     :email, :phone, :public_email,
                     :created_at, :updated_at ]
end
