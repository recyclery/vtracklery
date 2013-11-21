require 'test_helper'

class WorkTimesControllerTest < ActionController::TestCase
  setup do
    @work_time = work_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_time" do
    assert_difference('WorkTime.count') do
      post :create, work_time: { end_at: @work_time.end_at, start_at: @work_time.start_at, status_id: @work_time.status_id, work_status_id: @work_time.work_status_id, worker_id: @work_time.worker_id }
    end

    assert_redirected_to work_time_path(assigns(:work_time))
  end

  test "should show work_time" do
    get :show, id: @work_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_time
    assert_response :success
  end

  test "should update work_time" do
    patch :update, id: @work_time, work_time: { end_at: @work_time.end_at, start_at: @work_time.start_at, status_id: @work_time.status_id, work_status_id: @work_time.work_status_id, worker_id: @work_time.worker_id }
    assert_redirected_to work_time_path(assigns(:work_time))
  end

  test "should destroy work_time" do
    assert_difference('WorkTime.count', -1) do
      delete :destroy, id: @work_time
    end

    assert_redirected_to work_times_path
  end
end
