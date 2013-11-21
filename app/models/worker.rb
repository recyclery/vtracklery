class Worker < ActiveRecord::Base
  belongs_to :status
  belongs_to :work_status
end
