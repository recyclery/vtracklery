class Status < ActiveRecord::Base
  has_many :workers
  has_many :work_times

  validates_presence_of :name

  include XmlExtensions

  API_ATTRIBUTES = [ :name, :created_at, :updated_at ]
end
