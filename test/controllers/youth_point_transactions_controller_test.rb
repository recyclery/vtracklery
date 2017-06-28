require 'test_helper'

class YouthPointTransactionsControllerTest < ActionController::TestCase
  test "#create should assign an error if the youth does not have enough points" do
    youth_work_status = WorkStatus.create(name: WorkStatus::YOUTHPOINTS)
    worker = Worker.create(name: "youth worker", status_id: 1, work_status: youth_work_status)
    post :create, worker_id: worker.id, youth_point_transaction: {points: 3}
    assert assigns(:transaction).errors.full_messages == ["Insufficient points"]
  end
end
