require 'test_helper'

class Api::V1::WorkStatusesControllerTest < ActionController::TestCase
  setup do
    @work_status = work_statuses(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:work_statuses)
  end

  test "should create work_status" do
    assert_difference('WorkStatus.count') do
      work_status_hash = {
        name: @work_status.name,
        created_at: @work_status.created_at,
        updated_at: @work_status.updated_at
      }
      xhr :post, :create, work_status: work_status_hash
    end

    assert_response :success
  end

  test "should show work_status" do
    xhr :get, :show, id: @work_status
    assert_response :success
  end

  test "should update work_status" do
    work_status_hash = {
      name: @work_status.name,
      created_at: @work_status.created_at,
      updated_at: @work_status.updated_at
    }
    xhr :patch, :update, id: @work_status, work_status: work_status_hash

    assert_response :success
  end

  test "should destroy work_status" do
    assert_difference('WorkStatus.count', -1) do
      xhr :delete, :destroy, id: @work_status
    end

    assert_response :success
  end
end
