class Survey < ActiveRecord::Base
  belongs_to :worker

  include XmlExtensions

end
