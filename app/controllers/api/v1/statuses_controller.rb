class Api::V1::StatusesController < Api::V1::BaseController
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/statuses.json
  def index
    @statuses = Status.all
  end

  # GET /api/v1/statuses/1.json
  def show
  end

  # POST /api/v1/statuses.json
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      format.json do
        if @status.save
          render action: 'show', status: :created, location: @status
        else
          render json: @status.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /api/v1/statuses/1.json
  def update
    respond_to do |format|
      format.json do
        if @status.update(status_params) then head :no_content
        else
          render json: @status.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:name, :created_at, :updated_at)
    end
end
