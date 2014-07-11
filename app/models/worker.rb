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

  STATUS = ["Volunteer", "Member", "Paid Staff"] 

  scope :email_only, -> { where("email IS NOT NULL AND phone IS NULL") }
  scope :has_email, -> { where("email IS NOT NULL") }
  scope :has_phone, -> { where("phone IS NOT NULL") }
  scope :no_contact, -> { where("email IS NULL AND phone IS NULL") }

  # Find workers with identical names
  # this may be a problem with assigning work hours from xml backup
  #
  def self.duplicate_names
    array = all.map(&:name)
    array.select{|element| array.count(element) > 1 }.uniq
  end

  def previous
    w = Worker.where(['id < ?', self.id]).order('id DESC').limit(1).first
    return w.id if w
  end

  def next
    w = Worker.where(['id > ?', self.id]).limit(1).first
    return w.id if w
  end

  def created_datetime
    created_at.strftime("%a %b %d %Y")
  end

  # Remove non-standard spaces and dashes and replace with ascii?
  #
  def shoehorn_name
    name.split(/\s/).map {|n| 
      n.split('-').map { |nn| 
        nn.capitalize }.join("-")}.join(" ")
  end

end
