class Api::V1::SurveysController < Api::V1::BaseController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /api/v1/surveys/1.json
  def show
  end

  # POST /api/v1/surveys.json
  def create
    @survey = Survey.new(survey_params)
    @worker = @survey.worker

    respond_to do |format|
      format.json do
        if @survey.save
          render action: 'show', status: :created, location: worker_survey_url(@worker, @survey)
        else
          render json: @survey.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /api/v1/surveys/1.json
  def update
    respond_to do |format|
      format.json do
        if @survey.update(survey_params) then head :no_content
        else
          render json: @survey.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
      @worker = @survey.worker
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:worker_name, :assist_host, :host_program, :greet_open, :frequency, :tues_vol, :tues_open, :thurs_youth, :thurs_open, :fri_vol, :sat_sale, :sat_open, :can_name_bike, :can_fix_flat, :can_replace_tire, :can_replace_seat, :can_replace_cables, :can_adjust_brakes, :can_adjust_derailleurs, :can_replace_brakes, :can_replace_shifters, :can_remove_pedals, :replace_crank, :can_adjust_bearing, :can_overhaul_hubs, :can_overhaul_bracket, :can_overhaul_headset, :can_true_wheels, :can_replace_fork, :assist_youth, :assist_tuneup, :assist_overhaul, :pickup_donations, :taken_tuneup, :taken_overhaul, :drive_stick, :have_vehicle, :represent_recyclery, :sell_ebay, :organize_drive, :organize_events, :skill_graphic_design, :skill_drawing, :skill_photography, :skill_videography, :skill_programming, :skill_grants, :skill_newsletter, :skill_carpentry, :skill_coordination, :skill_fundraising, :comment, :created_at, :updated_at)
    end
end
