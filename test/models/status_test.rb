require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "associations" do
    @status = Status.first
    assert_equal "Volunteer", @status.name
  end
end
