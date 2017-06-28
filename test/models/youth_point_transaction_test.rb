require 'test_helper'

#
# Test for youth point transaction model
#
class YouthPointTransactionTest < ActiveSupport::TestCase
  test "validity" do
    worker = Worker.create(name: "test", status_id: 1, work_status_id: 1)
    transaction = YouthPointTransaction.new(worker: worker, points: -4)
    assert !transaction.valid?, "should be invalid if the number of points is negative"

    big_transaction = YouthPointTransaction.new(worker: worker, points: 40)
    assert !big_transaction.valid?, "should be invalid if the youth doesn't have enough points"

    workerless_transaction = YouthPointTransaction.new(points: 3)
    assert !workerless_transaction.valid?, "should be invalid if the it doesn't have an associated worker"
  end
end
