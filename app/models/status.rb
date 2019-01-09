#
# Eg. Volunteer, Member, Paid Staff, Youth
#
class Status < ActiveRecord::Base
  has_many :workers
  has_many :work_times

  validates_presence_of :name

  include XmlExtensions

  YOUTH = "Youth"
  VOLUNTEER = "Volunteer"
  MEMBER = "Member"
  STAFF =  "Paid Staff"

  # @return [Boolean] true if Worker has "Member" status
  def self.member
    return where(name: Status::MEMBER).first
  end

  # @return [Boolean] true if Worker has "Staff" status
  def self.staff
    return where(name: Status::STAFF).first
  end

  # @return [Boolean] true if Worker has "Volunteer" status
  def self.volunteer
    return where(name: Status::VOLUNTEER).first
  end

  # @return [Boolean] true if Worker has "Youth" status
  def self.youth
    return where(name: Status::YOUTH).first
  end

  # Attributes accessible via the API
  API_ATTRIBUTES = [ :name, :created_at, :updated_at ]

  # Attributes accessible via the web interface
  WEB_PARAMS = [] # Status attributes should not be accessible via the web

end
