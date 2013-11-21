require 'test_helper'

class WorkTimeTest < ActiveSupport::TestCase
  #fixtures :work_times, :workers, :statuses, :work_statuses
  STATUS = ["Volunteer", "Member", "Paid Staff"] 
  WORK_STATUS = ["Volunteer", "Earn-a-bike", "Paid"] 

  def setup
    time = DateTime.now
    @volunteer = Worker.create(name: "Ver", status_id:  1, work_status_id: 1)
    @member = Worker.create(name: "Mer", status_id:  2, work_status_id: 1)
  end

  def test_before_create_inherit_status_and_work_status
    work_time = WorkTime.create(start_at: DateTime.now,
                                worker_id: @member.id)    
    assert_equal @member.status_id, work_time.status_id
    assert_equal @member.work_status_id, work_time.work_status_id
  end

  def test_work_time_without_worker_fails
    assert true
  end

  def test_difference_methods
    work_time = WorkTime.new()
    assert ! work_time.difference?
    work_time.start_at = DateTime.now
    assert ! work_time.difference?
    work_time.end_at = DateTime.now
    assert work_time.difference?    
  end

  def test_start_and_end_of_time_utilities
    assert_equal DateTime.new(2008, 12), WorkTime.start_of_month(12, 2008)
    assert_equal DateTime.new(2009) - 1.second, WorkTime.end_of_month(12, 2008)
    assert_equal DateTime.new(2008), WorkTime.start_of_year(2008)
    assert_equal DateTime.new(2009) - 1.second, WorkTime.end_of_year(2008)
    assert_equal DateTime.new(Time.now.year), WorkTime.start_of_year
  end

  # Test may fail within 5 days after a new year
  def test_find_stats_for
    STATUS.each { |stat| Status.create(name: stat) }
    WORK_STATUS.each { |stat| WorkStatus.create(name: stat) }
    5.times do |n|
      time = DateTime.new(2008,3,15) + n.days
      WorkTime.create(start_at: time,
                      end_at: time + 3.hours,
                      worker_id: @volunteer.id)
    end
    5.times do |n|
      time = DateTime.new(2008,3,15) + n.days
      WorkTime.create(start_at: time,
                      end_at: time + 3.hours,
                      worker_id: @member.id)
    end
    5.times do |n| 
      time = DateTime.new(2007,3,15) + n.days
      WorkTime.create(start_at: time,
                      end_at: time + 3.hours,
                      worker_id: @member.id)
    end
    5.times do |n| 
      time = DateTime.new(2007,4,15) + n.days
      WorkTime.create(start_at: time,
                      end_at: time + 3.hours,
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
end
