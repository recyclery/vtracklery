class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @worker = Worker.find(params[:worker_id])
    @surveys = @worker.survey.blank? ? [] : [@worker.survey]
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @worker = Worker.find(params[:worker_id])
    @survey = @worker.build_survey
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @worker = Worker.find(params[:worker_id])
    @survey = @worker.build_survey(survey_params)

    respond_to do |format|
      if @survey.save
        #format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.html { redirect_to @survey.worker, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: worker_survey_path(@worker, @survey) }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        #format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.html { redirect_to @survey.worker, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: worker_survey_path(@worker, @survey) }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @worker = @survey.worker
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to @worker, notice: 'Survey was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @worker = Worker.find(params[:worker_id])
      @survey = @worker.survey
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:worker_id, :assist_host, :host_program, :greet_open, :frequency, :tues_vol, :tues_open, :thurs_youth, :thurs_open, :fri_vol, :sat_sale, :sat_open, :can_name_bike, :can_fix_flat, :can_replace_tire, :can_replace_seat, :can_replace_cables, :can_adjust_brakes, :can_adjust_derailleurs, :can_replace_brakes, :can_replace_shifters, :can_remove_pedals, :replace_crank, :can_adjust_bearing, :can_overhaul_hubs, :can_overhaul_bracket, :can_overhaul_headset, :can_true_wheels, :can_replace_fork, :assist_youth, :assist_tuneup, :assist_overhaul, :pickup_donations, :taken_tuneup, :taken_overhaul, :drive_stick, :have_vehicle, :represent_recyclery, :sell_ebay, :organize_drive, :organize_events, :skill_graphic_design, :skill_drawing, :skill_photography, :skill_videography, :skill_programming, :skill_grants, :skill_newsletter, :skill_carpentry, :skill_coordination, :skill_fundraising, :comment)
    end
end
