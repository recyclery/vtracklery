require 'test_helper'

class Api::V1::StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should create status" do
    assert_difference('Status.count') do
      status_hash = {
        name: @status.name,
        created_at: @status.created_at,
        updated_at: @status.updated_at
      }
      xhr :post, :create, status: status_hash
    end

    assert_response :success
  end

  test "should show status" do
    xhr :get, :show, id: @status
    assert_response :success
  end

  test "should update status" do
    status_hash = {
      name: @status.name,
      created_at: @status.created_at,
      updated_at: @status.updated_at
    }
    xhr :patch, :update, id: @status, status: status_hash

    assert_response :success
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      xhr :delete, :destroy, id: @status
    end

    assert_response :success
  end
end
