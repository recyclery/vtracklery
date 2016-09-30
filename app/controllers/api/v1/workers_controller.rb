class Api::V1::WorkersController < Api::V1::BaseController
  before_action :set_worker, only: [:show, :edit, :sign_in, :sign_out, :update, :destroy]

  # GET /api/v1/workers.json
  def index
    @workers = Worker.all
  end

  # All workers currently in the shop
  #
  # GET /api/v1/workers/shop.json
  def shop
    @workers = Worker.clocked_in
    render :index
  end

  # Find workers by email.
  #
  # GET /api/v1/workers/email?value=example@example.com
  def email
    email = params[:value]
    @workers = Worker.where(email: email)
    render :index
  end

  # Find workers by email or phone.
  # This works okay for email, but since phone numbers aren't normalized in
  # the database, they aren't guarunteed to work as well.
  #
  # GET /api/v1/workers/where.json
  # GET /api/v1/workers/where.json?email=example@example.com
  # GET /api/v1/workers/where?phone=3125550192
  def where
    email = params[:email]
    phone = params[:phone]
    if email then @workers = Worker.where(email: email)
    elsif phone then @workers = Worker.where(phone: phone)
    end
    render :index
  end

  # Have > 10 hours since last month
  #
  # @see Worker::WorkerReports::ClassMethods#active_workers
  # GET /api/v1/workers/active.json
  def active
    @workers = Worker.active_workers
    render :index
  end

  # Have > 10 hours since last month and haven't been in the last two weeks
  #
  # @see Worker::WorkerReports::ClassMethods#missing_list
  # GET /api/v1/workers/missing.json
  def missing
    @workers = Worker.missing_list
    render :index
  end

  # GET /api/v1/workers/1.json
  def show
  end

  # POST /api/v1/workers.json
  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      format.json do
        if @worker.save
          render action: 'show', status: :created, location: @worker
        else
          render json: @worker.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # POST /api/v1/workers/1/sign_in.json
  def sign_in
    @work_time = @worker.clock_in()
    @start = @work_time.start_time

    if @worker.save && @work_time.save
      respond_to do |format|
        format.json { render json: @work_time }
        #render @worker.to_xml
      end
    end
  end

  # POST /api/v1/workers/1/sign_out.json
  def sign_out
    @work_time = @worker.clock_out
    @end = @work_time.end_at.strftime("%I:%M%p")

    if @worker.save and @work_time.save
      respond_to do |format|
        format.json { render json: @work_time }
      end
    end
  end

  # PATCH/PUT /api/v1/workers/1.json
  def update
    respond_to do |format|
      format.json do
        if @worker.update(worker_params) then head :no_content
        else
          render json: @worker.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worker_params
      params.require(:worker).permit(:id, :name, :image, :in_shop, :email, :phone, :public_email, :created_at, :updated_at)
    end
end
