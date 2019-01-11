class EventsController < ApplicationController
  before_action :set_event, only: [:show, :week, :month, :year, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/1/2018/11/15
  # GET /events/1/2018/11/15.json
  def week
    @year = params[:year].to_i
    @month = params[:month].to_i
    @day = params[:day].to_i
    @date = Date.new(@year, @month, @day)
    @work_times = WorkTime.find_by_start_date(@date)
  end

  # GET /events/1/2018/11
  # GET /events/1/2018/11.json
  def month
    @year = params[:year].to_i
    @month = params[:month].to_i
    @first_day = @event.first_day_of_month(@year, @month)
    @last_day_of_month = Date.new(@year, @month, 1).end_of_month
  end

  # GET /events/1/2018
  # GET /events/1/2018.json
  def year
    @year = params[:year].to_i
    @first_month = 1
    @last_month = (Date.today.year == @year) ? Date.today.month : 12
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
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
      params.require(:event).permit(Event::WEB_PARAMS)
    end

end
