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
    assert_nil w.normalize_phone("5551212")
  end

  test "youth_points" do
    youth_work_status = WorkStatus.create(name: WorkStatus::YOUTHPOINTS)
    paid_work_status = WorkStatus.create(name: WorkStatus::PAID)

    youth = Worker.create(name: "youth worker", status_id: 1, work_status: youth_work_status)
    paid_worker = Worker.create(name: "youth worker", status_id: 1, work_status: paid_work_status)

    youth_points_time = WorkTime.create(work_status: youth_work_status, worker: youth, status_id: 1, start_at: Time.now - 5.hours, end_at: Time.now - 1.hours)
    youth_paid_time = WorkTime.create(work_status: paid_work_status, worker: youth, status_id: 1, start_at: Time.now - 6.hours, end_at: Time.now - 4.hours)
    paid_worker_paid_time = WorkTime.create(work_status: paid_work_status, worker: paid_worker, status_id: 1, start_at: Time.now - 4.hours, end_at: Time.now - 2.hours)

    assert_equal youth.youth_points, 4, "should only count youth points worktimes"
    assert_equal paid_worker.youth_points, 0, "should be zero for non-youth"

    YouthPointPurchase.create(worker: youth, points: 1)
    YouthPointPurchase.create(worker: youth, points: 2)
    assert_equal youth.youth_points, 1, "should deduct youth point purchases"

  end

  test "youth?" do
    youth_status = Status.create(name: "Youth")
    youth = Worker.create(name: "youth worker", status: youth_status, work_status_id: 1)
    paid_worker = Worker.create(name: "youth worker", status_id: 1, work_status_id: 1)
    assert youth.youth?
    assert !paid_worker.youth?
  end
end
