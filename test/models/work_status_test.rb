require 'test_helper'

class WorkStatusTest < ActiveSupport::TestCase
  test "associations" do
    @work_status = WorkStatus.first
    assert_equal "Volunteer", @work_status.name

    @work_time = work_times(:two)
    assert_equal "Volunteer", @work_time.work_status_name
  end
end
