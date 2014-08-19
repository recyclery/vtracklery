require 'test_helper'

class Api::V1::ReportsControllerTest < ActionController::TestCase
  setup do
    @report = report(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:report)
  end

  test "should create report" do
    assert_difference('Report.count') do
      report_hash = {

      }
      xhr :post, :create, report: report_hash
    end

    assert_response :success
  end

  test "should show report" do
    xhr :get, :show, id: @report
    assert_response :success
  end

  test "should update report" do
    report_hash = {

    }
    xhr :patch, :update, id: @report, report: report_hash

    assert_response :success
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      xhr :delete, :destroy, id: @report
    end

    assert_response :success
  end
end
