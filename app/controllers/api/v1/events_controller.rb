class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/events.json
  def index
    @events = Event.all
  end

  # GET /api/v1/events/1.json
  def show
  end

  # POST /api/v1/events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      format.json do
        if @event.save
          render action: 'show', status: :created, location: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /api/v1/events/1.json
  def update
    respond_to do |format|
      format.json do
        if @event.update(event_params) then head :no_content
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :first_at, :last_at, :wday, :s_hr, :s_min, :e_hr, :e_min, :created_at, :updated_at)
    end
end
