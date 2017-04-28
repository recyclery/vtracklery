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

  test "should get monthly" do
    get :monthly
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

  test "should get weekly" do
    get :weekly
    assert_response :success
  end

  test "should get year" do
    get :year
    assert_response :success
  end

  test "should get yearly" do
    get :yearly
    assert_response :success
  end

end
