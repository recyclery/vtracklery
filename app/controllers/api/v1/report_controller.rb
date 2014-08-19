class Api::V1::ReportsController < Api::V1::BaseController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/report.json
  def index
    @report = Report.all
  end

  # GET /api/v1/report/1.json
  def show
  end

  # POST /api/v1/report.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      format.json do
        if @report.save
          render action: 'show', status: :created, location: @report
        else
          render json: @report.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /api/v1/report/1.json
  def update
    respond_to do |format|
      format.json do
        if @report.update(report_params) then head :no_content
        else
          render json: @report.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/report/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit()
    end
end
