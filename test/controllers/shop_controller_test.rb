require 'test_helper'

class ShopControllerTest < ActionController::TestCase
  setup do
    @worker = workers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get directions" do
    get :directions
    assert_response :success
  end

  test "should get sign_in" do
    assert_difference('WorkTime.count') do
      patch :sign_in, id: @worker
    end

    assert_response :success
  end

  test "should get sign_out" do
    patch :sign_out, id: @worker

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @worker

    assert_response :success
  end

  test "should update" do
    @work_time = @worker.work_times.last
    work_time_hash = {
      end_at: @work_time.end_at,
      start_at: @work_time.start_at
    }
    patch :update, id: @worker, work_time: work_time_hash

    assert_redirected_to root_path
  end

  test "should delete" do
    @worker = workers(:one)
    assert_difference('WorkTime.count', -1) do
      delete :destroy, id: @worker
    end

    assert_redirected_to root_path
  end

end
