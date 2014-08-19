require 'test_helper'

class Api::V1::WorkersControllerTest < ActionController::TestCase
  setup do
    @worker = workers(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:workers)
  end

  test "should create worker" do
    assert_difference('Worker.count') do
      worker_hash = {
        name: @worker.name,
        image: @worker.image,
        in_shop: @worker.in_shop,
        email: @worker.email,
        phone: @worker.phone,
        public_email: @worker.public_email,
        created_at: @worker.created_at,
        updated_at: @worker.updated_at
      }
      xhr :post, :create, worker: worker_hash
    end

    assert_response :success
  end

  test "should show worker" do
    xhr :get, :show, id: @worker
    assert_response :success
  end

  test "should update worker" do
    worker_hash = {
      name: @worker.name,
      image: @worker.image,
      in_shop: @worker.in_shop,
      email: @worker.email,
      phone: @worker.phone,
      public_email: @worker.public_email,
      created_at: @worker.created_at,
      updated_at: @worker.updated_at
    }
    xhr :patch, :update, id: @worker, worker: worker_hash

    assert_response :success
  end

  test "should destroy worker" do
    assert_difference('Worker.count', -1) do
      xhr :delete, :destroy, id: @worker
    end

    assert_response :success
  end
end
