require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "valid events" do
    tue_open_shop = Event.new(:name => "Tuesday Open Shop", 
                              :first_at => nil, :last_at => nil, 
                              :wday => 2,
                              :s_hr => 19, :e_hr => 21, 
                              :s_min => 0, :e_min => 0)
    assert tue_open_shop.valid?

    assert_equal Runt::Intersect, tue_open_shop.texpr.class
    assert   tue_open_shop.include?( DateTime.new(2009,3,31,19,45) )

    # Volunteer arrives early and leaves late
    assert ! tue_open_shop.include?( DateTime.new(2009,3,31,18,45) )
    assert ! tue_open_shop.include?( DateTime.new(2009,3,31,21,15) )

    # The above problem is solved by responding to the WorkTime class
    late_early =  WorkTime.new(:worker_id => 1, 
                               :start_at => DateTime.new(2009,3,31,19,15),
                               :end_at   => DateTime.new(2009,3,31,20,45))
    early_late =  WorkTime.new(:worker_id => 1, 
                               :start_at => DateTime.new(2009,3,31,18,45),
                               :end_at   => DateTime.new(2009,3,31,21,15))
    early_early = WorkTime.new(:worker_id => 1, 
                               :start_at => DateTime.new(2009,3,31,18,45),
                               :end_at   => DateTime.new(2009,3,31,20,45))
    late_late =   WorkTime.new(:worker_id => 1, 
                               :start_at => DateTime.new(2009,3,31,19,15),
                               :end_at   => DateTime.new(2009,3,31,21,15))

    # Under any of these conditions, a worker will have attended this event
    assert tue_open_shop.include?( late_early  )
    assert tue_open_shop.include?( early_late  )
    assert tue_open_shop.include?( early_early )
    assert tue_open_shop.include?( late_late   )

    wrong_day  = WorkTime.new(:worker_id => 1, 
                              :start_at => DateTime.new(2009,3,30,19,15),
                              :end_at   => DateTime.new(2009,3,30,20,45))
    wrong_time = WorkTime.new(:worker_id => 1, 
                              :start_at => DateTime.new(2009,3,31,15,15),
                              :end_at   => DateTime.new(2009,3,31,18,45))
    assert ! tue_open_shop.include?( wrong_day )
    assert ! tue_open_shop.include?( wrong_time )

  end
end
