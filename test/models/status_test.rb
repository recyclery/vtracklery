require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "associations" do
    @status = Status.first
    assert_equal "Volunteer", @status.name

    @work_time = work_times(:two)

    assert statuses(:one), "Should have status fixture"

    assert @work_time.status, "Should have status"
    assert_equal "Volunteer", @work_time.status_name
  end
end
