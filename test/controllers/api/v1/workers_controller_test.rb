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

  test "should get shop" do
    xhr :get, :shop
    assert_response :success
    assert_not_nil assigns(:workers)
  end

  test "should get regular" do
    xhr :get, :regular
    assert_response :success
    assert_not_nil assigns(:workers)
  end

  test "should get missing" do
    xhr :get, :missing
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

  test "should create youth worker" do
    youth_work_status = WorkStatus.create(name: WorkStatus::YOUTHPOINTS)
    youth_status = Status.create(name: Status::YOUTH)

    assert_difference('Worker.count') do
      worker_hash = {
        name: @worker.name,
        image: @worker.image,
        in_shop: @worker.in_shop,
        email: @worker.email,
        phone: @worker.phone,
        public_email: @worker.public_email,
        created_at: @worker.created_at,
        updated_at: @worker.updated_at,
        youth: "1"
      }
      xhr :post, :create, worker: worker_hash
    end
    assert assigns(:worker).work_status = youth_work_status
    assert assigns(:worker).status = youth_status
    assert_response :success

  end

  test "should sign in and out" do
    assert_difference('WorkTime.count') do
      xhr :post, :sign_in, id: @worker
    end
    assert_response :success

    xhr :post, :sign_out, id: @worker
    assert_response :success
  end

  test "should sign in and out - epoch" do
    e_in = (DateTime.current - 10).to_i
    assert_difference('WorkTime.count') do
      xhr :post, :sign_in, id: @worker, epoch: e_in
    end
    assert_response :success

    e_out = (DateTime.current - 10).to_i
    xhr :post, :sign_out, id: @worker, epoch: e_out
    assert_response :success

    work_time = @worker.latest_record
    assert_equal e_in, work_time.start_at.to_i
    assert_equal e_out, work_time.end_at.to_i
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
