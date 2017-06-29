class YouthPointPurchasesController < ApplicationController
  before_action :set_worker

  # GET /workers/[id]/youth_point_purchases/new
  def new
    @purchase = YouthPointPurchase.new(worker: @worker)
  end

  # POST /workers/[id]/youth_point_purchases
  def create
    @purchase = YouthPointPurchase.new(purchase_params.merge(worker: @worker))
    if @purchase.points && @purchase.points > @worker.youth_points
      @purchase.errors.add(:base, :invalid, message: "Insufficient points")
      render :new and return
    end
    if @purchase.save
      redirect_to @worker, notice: 'Points successfully deducted.'
    else
      render :new
    end
  end

  private
    def purchase_params
      params.require(:youth_point_purchase).permit(:points)
    end

    def set_worker
      @worker = Worker.find(params[:worker_id])
    end
end
