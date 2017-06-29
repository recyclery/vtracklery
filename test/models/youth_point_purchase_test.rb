require 'test_helper'

#
# Test for youth point purchase model
#
class YouthPointPurchaseTest < ActiveSupport::TestCase
  test "validity" do
    worker = Worker.create(name: "test", status_id: 1, work_status_id: 1)
    purchase = YouthPointPurchase.new(worker: worker, points: -4)
    assert !purchase.valid?, "should be invalid if the number of points is negative"

    workerless_purchase = YouthPointPurchase.new(points: 3)
    assert !workerless_purchase.valid?, "should be invalid if the it doesn't have an associated worker"
  end
end
