require 'test_helper'

class WorkersControllerTest < ActionController::TestCase
  setup do
    @worker = workers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create worker" do
    worker_hash = {
      email: @worker.email,
      image: @worker.image,
      in_shop: @worker.in_shop,
      name: @worker.name,
      phone: @worker.phone,
      public_email: @worker.public_email,
      status_id: @worker.status_id,
      work_status_id: @worker.work_status_id
    }
    assert_difference('Worker.count') do
      post :create, worker: worker_hash
    end

    assert_redirected_to worker_path(assigns(:worker))
  end

  test "should show worker" do
    get :show, id: @worker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @worker
    assert_response :success
  end

  test "should update worker" do
    worker_hash = {
      email: @worker.email,
      image: @worker.image,
      in_shop: @worker.in_shop,
      name: @worker.name,
      phone: @worker.phone,
      public_email: @worker.public_email,
      status_id: @worker.status_id,
      work_status_id: @worker.work_status_id
    }
    patch :update, id: @worker, worker: worker_hash
    assert_redirected_to worker_path(assigns(:worker))
  end

  test "should update worker status" do
    @status = statuses(:member)
    @request.env['HTTP_REFERER'] = 'http://test.com/workers/new'
    patch :update_status, id: @worker, status_id: @status
    assert_redirected_to :back
    assert_equal "Worker #{@worker.name}'s status was successfully updated to '#{@status.name}.'", flash[:notice]
  end

  test "should destroy worker and redirect" do
    @request.env['HTTP_REFERER'] = 'http://test.com/workers/new'
    assert_difference('Worker.count', -1) do
      delete :destroy_and_redirect, id: @worker
    end

    assert_redirected_to :back
  end

  test "should destroy worker" do
    assert_difference('Worker.count', -1) do
      delete :destroy, id: @worker
    end

    assert_redirected_to workers_path
  end
end
