class YouthPointTransactionsController < ApplicationController
  before_action :set_worker

  # GET /workers/[id]/youth_point_transactions/new
  def new
    @transaction = YouthPointTransaction.new(worker: @worker)
  end

  # POST /workers/[id]/youth_point_transactions
  def create
    @transaction = YouthPointTransaction.new(transaction_params.merge(worker: @worker))
    if @transaction.points && @transaction.points > @worker.youth_points
      @transaction.errors.add(:base, :invalid, message: "Insufficient points")
      render :new and return
    end
    if @transaction.save
      redirect_to @worker, notice: 'Points successfully deducted.'
    else
      render :new
    end
  end

  private
    def transaction_params
      params.require(:youth_point_transaction).permit(:points)
    end

    def set_worker
      @worker = Worker.find(params[:worker_id])
    end
end
