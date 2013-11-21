class WorkTime < ActiveRecord::Base
  belongs_to :worker
  belongs_to :status
  belongs_to :work_status
end
