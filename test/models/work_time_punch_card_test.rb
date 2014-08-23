require 'test_helper'

class WorkTimePunchCardTest < ActiveSupport::TestCase
  def setup
    @worker = workers(:one)
  end

  test "basic methods exist" do
    work_time = WorkTime.first
    assert work_time.respond_to?(:difference_to_s), "Should have difference_to_s"
  end

  test "difference_methods" do
    work_time = WorkTime.new()
    time = DateTime.now

    assert ! work_time.difference?, "No start or end time, no difference."
    work_time.start_at = time
    assert work_time.end_at.nil?, "end_at should not be assigned."
    assert ! work_time.difference?, "If no end time, no difference."
    work_time.end_at = time
    assert ! work_time.difference?, "If start and end times are the same, no difference."

    work_time.end_at = time + 1
    assert work_time.difference?    
  end

  test "difference_to_s" do
    wt2 = WorkTime.create(worker: @worker,
                          start_at: 'Fri, 22 Aug 2014 22:29:05 -0500',
                          end_at: 'Fri, 22 Aug 2014 22:19:05 -0500')
    assert_equal "Invalid order", wt2.difference_to_s

    wt1 = WorkTime.create(worker: @worker,
                          start_at: 'Fri, 22 Aug 2014 22:19:05 -0500',
                          end_at: 'Fri, 22 Aug 2014 22:29:05 -0500')
    assert_equal "10 minutes", wt1.difference_to_s

  end

end
