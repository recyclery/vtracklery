#
# Eg. Volunteer, Member, Paid Staff, Youth
#
class Status < ActiveRecord::Base
  has_many :workers
  has_many :work_times

  validates_presence_of :name

  include XmlExtensions

  # Attributes accessible via the API
  API_ATTRIBUTES = [ :name, :created_at, :updated_at ]

  # Attributes accessible via the web interface
  WEB_PARAMS = [] # Status attributes should not be accessible via the web

end
