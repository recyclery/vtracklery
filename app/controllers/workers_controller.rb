class WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :edit, :status, :update, :update_status, :destroy, :destroy_and_redirect]

  # GET /workers
  # GET /workers.xml
  # GET /workers.json
  def index
    @workers = Worker.all
    @images = []
    @cheese = []
  end

  # GET /workers/member
  # GET /workers/member.xml
  # GET /workers/member.json
  def member
    @workers = Worker.all_member
    @images = []
    @cheese = []
  end

  # GET /workers/youth
  # GET /workers/youth.xml
  # GET /workers/youth.json
  def youth
    @workers = Worker.all_youth
    @images = []
    @cheese = []
  end

  # GET /workers/1
  # GET /workers/1.xml
  # GET /workers/1.json
  def show
    @images = []
    @cheese = []
  end

  # Edit status; should only be accessible via links in the
  # statuses controller.
  #
  # GET /workers/1/status
  def status
  end

  # GET /workers/new
  def new
    @worker = Worker.new
    @images = Worker.avatar_filepaths
    @cheese = Worker.cheese_filepaths
  end

  # GET /workers/1/edit
  def edit
    @image = @worker.image || "vimg01.png"
    @images = Worker.avatar_filepaths
    @cheese = Worker.cheese_filepaths
  end

  # GET /workers/upload_form
  def upload_form
    render :partial => 'upload_form'
  end

  # GET /workers/cheese_chooser
  def cheese_chooser
    @worker = Worker.find(params[:id])
    render :partial => 'cheese_chooser'
  end

  # GET /workers/image_chooser
  def image_chooser
    @worker = Worker.find(params[:id])
    render :partial => 'image_chooser'
  end

  # POST /workers/upload
  def upload_image
    uploaded_data = params[:avatar]
    @avatar = AvatarUploader.new
    if @avatar.store!(uploaded_data.tempfile.name)
      render :partial => 'upload_image'
    else
      render :partial => 'upload_form'
    end
  end

  # POST /workers
  # POST /workers.json
  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
        format.json { render :show, status: :created, location: @worker }
      else
        format.html { render :new }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workers/1
  # PATCH/PUT /workers/1.json
  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to @worker, notice: 'Worker was successfully updated.' }
        format.json { render :show, status: :ok, location: @worker }
      else
        format.html { render :edit }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workers/1/status/1
  # PATCH/PUT /workers/1/status/1.json
  def update_status
    @status = Status.find(params[:status_id])
    @worker.status = @status
    @name = @worker.name
    respond_to do |format|
      if @worker.save
        format.html do
          redirect_to :back, notice: "Worker #{@name}'s status was successfully updated to '#{@status.name}.'"
        end
        format.json { render :show, status: :ok, location: @worker }
      else
        format.html do
          redirect_to :back, notice: "Worker #{@name} update failed."
        end
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroy the object and redirect back to the referrer
  #
  # DELETE /workers/1/back
  def destroy_and_redirect
    name = @worker.name
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: "Worker #{name} was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url, notice: 'Worker was successfully destroyed' }
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
      is_youth = params["worker"]["youth"] == "1"
      p = params.require(:worker).permit(Worker::WEB_PARAMS)
      if is_youth
        p[:work_status_id] = WorkStatus.where(name: WorkStatus::YOUTHPOINTS).first.id
        p[:status_id] = Status.where(name: Status::YOUTH).first.id
      end
      p
    end

end
