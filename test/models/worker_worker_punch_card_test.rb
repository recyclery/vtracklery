require 'test_helper'

#
# Test for Worker::WorkerPunchCard concern
#
class WorkerWorkerPunchCardTest < ActiveSupport::TestCase
  test "class methods" do
    [ :clock_in,
      :clock_in!,
      :clock_out,
      :clock_out!
    ].each do |method_name|
      assert Worker.respond_to?(method_name), method_name.to_s
    end
  end

  test "instance methods" do
    worker = workers(:one)
    [ :clock_in,
      :clock_in!,
      :clock_out,
      :clock_out!,
      :is_in_shop?,
      :latest_record,
      :oldest_record,
      :last_visit_text
    ].each do |method_name|
      assert worker.respond_to?(method_name), method_name.to_s
    end
  end

  test "clock_in, clock_out" do
    worker = workers(:one)
    t_in = DateTime.current - 10

    worker.clock_in(t_in)
    assert_equal t_in, worker.updated_at

    work_time = worker.latest_record
    assert_equal t_in, work_time.start_at

    work_time = worker.latest_record
    assert_equal t_in, work_time.start_at

    t_out = DateTime.current + 10

    worker.clock_out(t_out)
    assert_equal t_out, worker.updated_at
    
    work_time = worker.latest_record
    assert_equal t_in, work_time.start_at
    assert_equal t_out, work_time.end_at

    e_in = (DateTime.current - 10).to_i

    worker.clock_in(e_in.to_i)
    assert_equal e_in, worker.updated_at.to_i

    work_time = worker.latest_record
    assert_equal e_in, work_time.start_at.to_i

    work_time = worker.latest_record
    assert_equal e_in, work_time.start_at.to_i

    e_out = (DateTime.current + 10).to_i

    worker.clock_out(e_out)
    assert_equal e_out, worker.updated_at.to_i
    
    work_time = worker.latest_record
    assert_equal e_in, work_time.start_at.to_i
    assert_equal e_out, work_time.end_at.to_i
  end

end
