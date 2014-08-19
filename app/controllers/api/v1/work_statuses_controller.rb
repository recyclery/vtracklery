class Api::V1::WorkStatusesController < Api::V1::BaseController
  before_action :set_work_status, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/work_statuses.json
  def index
    @work_statuses = WorkStatus.all
  end

  # GET /api/v1/work_statuses/1.json
  def show
  end

  # POST /api/v1/work_statuses.json
  def create
    @work_status = WorkStatus.new(work_status_params)

    respond_to do |format|
      format.json do
        if @work_status.save
          render action: 'show', status: :created, location: @work_status
        else
          render json: @work_status.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /api/v1/work_statuses/1.json
  def update
    respond_to do |format|
      format.json do
        if @work_status.update(work_status_params) then head :no_content
        else
          render json: @work_status.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/work_statuses/1.json
  def destroy
    @work_status.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_status
      @work_status = WorkStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_status_params
      params.require(:work_status).permit(:name, :created_at, :updated_at)
    end
end
