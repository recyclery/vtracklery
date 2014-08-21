require 'test_helper'

class Api::V1::WorkTimesControllerTest < ActionController::TestCase
  setup do
    @work_time = work_times(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:work_times)
  end

  test "should create work_time" do
    assert_difference('WorkTime.count') do
      work_time_hash = {
        start_at: @work_time.start_at,
        end_at: @work_time.end_at,
        status_id: @work_time.status_id,
        work_status_id: @work_time.work_status_id,
        worker_id: @work_time.worker_id,
        created_at: @work_time.created_at,
        updated_at: @work_time.updated_at
      }
      xhr :post, :create, work_time: work_time_hash
    end

    assert_response :success
  end

  test "should show work_time" do
    xhr :get, :show, id: @work_time
    assert_response :success
  end

  test "should update work_time" do
    work_time_hash = {
      start_at: @work_time.start_at,
      end_at: @work_time.end_at,
      created_at: @work_time.created_at,
      updated_at: @work_time.updated_at
    }
    xhr :patch, :update, id: @work_time, work_time: work_time_hash

    assert_response :success
  end

  test "should destroy work_time" do
    assert_difference('WorkTime.count', -1) do
      xhr :delete, :destroy, id: @work_time
    end

    assert_response :success
  end
end
