require 'test_helper'

class WorkerTest < ActiveSupport::TestCase
  test "sum_time_in_seconds" do
    w = Worker.create(name: "test worker", status_id: 1, work_status_id: 1)
    start_at = DateTime.new(2008, 10, 11, 1, 0)
    end_at = DateTime.new(2008, 10, 11, 1, 30) # 30 minutes later

    wt = w.work_times.create(start_at: start_at, end_at: end_at)

    assert_equal 1, wt.status_id, 'Should inherit status from worker'
    assert_equal 1, wt.work_status_id, 'Should inherit work_status from worker'

    # Only 30 minutes (1800 s) of work was done in that day since only 1 entry
    assert_equal 1800, w.sum_time_in_seconds(start_at, end_at)
  end

  test "phone methods" do
    w = Worker.create(name: "test worker", status_id: 1, work_status_id: 1,
                      phone: "312.555.1212")
    assert_equal "(312) 555-1212", w.shoehorn_phone

    assert_equal ["312", "555", "1212"], w.normalize_phone("(312) 555-1212")
    assert_equal ["312", "555", "1212"], w.normalize_phone("1-312-555-1212")
    assert_equal ["312", "555", "1212"], w.normalize_phone("  1-312-555-1212")
    assert_equal ["312", "555", "1212"], w.normalize_phone("312-555-1212")
    assert_equal ["312", "555", "1212"], w.normalize_phone("312/555-1212")
    assert_equal ["312", "555", "1212"], w.normalize_phone("3125551212")
    assert_equal ["312", "555", "1212"], w.normalize_phone("(312)555-1212")
    assert_equal nil, w.normalize_phone("5551212")
  end
end
