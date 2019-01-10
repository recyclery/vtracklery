require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get admin" do
    get :admin
    assert_response :success
  end

  test "should get calendar" do
    get :calendar
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get event" do
    get :event, id: events(:one)
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get month" do
    get :month
    assert_response :success
  end

  test "should get month with year" do
    get :month, year: 2018
    assert_response :success
  end

  test "should get month with year and month" do
    get :month, year: 2018, month: 6
    assert_response :success
  end

  test "should get monthly" do
    get :monthly
    assert_response :success
  end

  test "should get monthly with year" do
    get :monthly, year: 2018
    assert_response :success
  end

  test "should get regular" do
    get :regular
    assert_response :success
  end

  test "should get volunteer" do
    volunteer = Worker.find(500)
    get :volunteer, id: volunteer
    assert_response :success
  end

  test "should get week" do
    get :week
    assert_response :success
  end

  test "should get week with year" do
    get :week, year: 2018
    assert_response :success
  end

  test "should get week with year and month" do
    get :week, year: 2018, month: 6
    assert_response :success
  end

  test "should get week with year, month, and day" do
    get :week, year: 2018, month: 6, day: 15
    assert_response :success
  end

  test "should get weekly" do
    get :weekly
    assert_response :success
  end

  test "should get weekly with year" do
    get :weekly, year: 2018
    assert_response :success
  end

  test "should get weekly with year and month" do
    get :weekly, year: 2018, month: 6
    assert_response :success
  end

  test "should get year" do
    get :year
    assert_response :success
  end

  test "should get year with year" do
    get :year, year: 2018
    assert_response :success
  end

  test "should get member_hours_year_report with year" do
    get :year_hoursm, year: 2018
    assert_response :success
  end

  test "should get staff_hours_year_report with year" do
    get :year_hourss, year: 2018
    assert_response :success
  end

  test "should get volunteer_hours_year_report with year" do
    get :year_hoursv, year: 2018
    assert_response :success
  end

  test "should get youth_hours_year_report with year" do
    get :year_hoursy, year: 2018
    assert_response :success
  end

  test "should get yearly" do
    get :yearly
    assert_response :success
  end

end
