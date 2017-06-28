#
# A transaction using youth points
#
class YouthPointTransaction < ActiveRecord::Base
  belongs_to :worker
  validates_numericality_of :points, greater_than: 0
  validates_presence_of :worker_id
end
