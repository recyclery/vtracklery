#
# A purchase using youth points
#
class YouthPointPurchase < ActiveRecord::Base
  belongs_to :worker
  validates_numericality_of :points, greater_than: 0
  validates_presence_of :worker_id
end
