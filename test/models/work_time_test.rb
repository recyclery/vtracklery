require 'test_helper'

class WorkTimeTest < ActiveSupport::TestCase
  #fixtures :work_times, :workers, :statuses, :work_statuses
  #STATUS = ["Volunteer", "Member", "Paid Staff"] 
  #WORK_STATUS = ["Volunteer", "Earn-a-bike", "Paid"] 

  def setup
    time = DateTime.now
    @volunteer = Worker.create(name: "Ver", status_id:  1, work_status_id: 1)
    @member = Worker.create(name: "Mer", status_id:  2, work_status_id: 1)
  end

  test "before_create_inherit_status_and_work_status" do
    work_time = WorkTime.create(start_at: DateTime.now,
                                worker_id: @member.id)    
    assert_equal @member.status_id, work_time.status_id
    assert_equal @member.work_status_id, work_time.work_status_id
  end

  test "work_time_without_worker_fails" do
    assert true
  end

  test "difference_methods" do
    work_time = WorkTime.new()
    assert ! work_time.difference?
    work_time.start_at = DateTime.now
    assert ! work_time.difference?
    work_time.end_at = DateTime.now
    assert work_time.difference?    
  end

  test "start_and_end_of_time_utilities" do
    assert_equal DateTime.new(2008, 12), WorkTime.start_of_month(12, 2008)
    assert_equal DateTime.new(2009) - 1.second, WorkTime.end_of_month(12, 2008)
    assert_equal DateTime.new(2008), WorkTime.start_of_year(2008)
    assert_equal DateTime.new(2009) - 1.second, WorkTime.end_of_year(2008)
    assert_equal DateTime.new(Time.now.year), WorkTime.start_of_year
  end

  # Test may fail within 5 days after a new year
  test "find_stats_for" do
    5.times do |n|
      WorkTime.create(start_at: DateTime.new(2008,3,15) + n,
                      end_at: DateTime.new(2008,3,15,3) + n,
                      worker_id: @volunteer.id)
    end
    5.times do |n|
      WorkTime.create(start_at: DateTime.new(2008,3,15) + n,
                      end_at: DateTime.new(2008,3,15,3) + n,
                      worker_id: @member.id)
    end
    5.times do |n| 
      WorkTime.create(start_at: DateTime.new(2007,3,15) + n,
                      end_at: DateTime.new(2007,3,15,3) + n,
                      worker_id: @member.id)
    end
    5.times do |n| 
      WorkTime.create(start_at: DateTime.new(2007,4,15) + n,
                      end_at: DateTime.new(2007,4,15,3) + n,
                      worker_id: @member.id)
    end
    wt, w, t, a = WorkTime.find_stats_for(2008)
    assert_equal [2, 10], [w.size, wt.size], w.inspect
    assert_equal WorkTime.stringify_hours(30), t
    assert_equal WorkTime.stringify_hours(15), a

    wt, w, t, a = WorkTime.status_stats_for(Status.find(1), 2008)
    assert_equal [1, 5], [w.size, wt.size], w.inspect
    assert_equal WorkTime.stringify_hours(15), t
    assert_equal WorkTime.stringify_hours(15), a

    wt, w, t, a = WorkTime.status_stats_for(Status.find(2), 2007, 3)
    assert_equal [1, 5], [w.size, wt.size], w.inspect
    assert_equal WorkTime.stringify_hours(15), t, wt.inspect
    assert_equal WorkTime.stringify_hours(15), a, wt.inspect
  end

  test "find_by_start_date" do
    beg = DateTime.new(2008,3,11,11,30)
    fin = DateTime.new(2008,3,11,11,45)

    wt = WorkTime.create(start_at: beg, end_at: fin, worker_id: 1, work_status_id: 1, status_id: 1)

    # find_by_start_date can be passed integer dates or object that responds
    # to :year, :month, :day
    work_time = WorkTime.find_by_start_date(2008,3,11)
    assert_equal [wt], work_time
    
    work_time = WorkTime.find_by_start_date(beg)
    assert_equal [wt], work_time
  end

  test "worker_id_between scope" do
    w = Worker.create(name: "test worker", status_id: 1, work_status_id: 1)
    start_at = DateTime.new(2008, 10, 11, 1, 0)
    end_at = DateTime.new(2008, 10, 11, 1, 30) # 30 minutes later
    wt = w.work_times.create(start_at: start_at, end_at: end_at)

    assert_equal 1, wt.status_id, 'Should inherit status from worker'
    assert_equal 1, wt.work_status_id, 'Should inherit work_status from worker'

    # Only 30 minutes (1800 s) of work was done in that day since only 1 entry
    time = WorkTime.worker_id_between(w.id, wt.start_at, wt.end_at)
    assert_equal [wt], time
    assert_equal 1800, time.to_a.sum(&:difference_in_seconds)
  end

end
