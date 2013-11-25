class WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  # GET /workers
  # GET /workers.xml
  # GET /workers.json
  def index
    @workers = Worker.all
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

  # GET /workers/new
  def new
    @worker = Worker.new
    @images = []
    Dir.entries(Settings.avatars.default_dir).each do |file|
      @images.push file if file =~ /\.png/
    end
    @cheese = []
    begin
      Dir.entries(Settings.cheese.dir).each do |file|
        @cheese.push file if file =~ /\.jpg/
      end if File.directory? Settings.cheese.dir
    rescue #"Errno::ENOENT"
    end
  end

  # GET /workers/1/edit
  def edit
    @image = @worker.image || "vimg01.png"
    @images = []
    Dir.entries(Settings.avatars.default_dir).each do |file|
      @images.push file if file =~ /\.png/
    end
    @cheese = []
    begin
      Dir.entries(Settings.cheese.dir).each do |file|
        @cheese.push file if file =~ /\.jpg/
      end
    rescue #"Errno::ENOENT"
    end
  end

  # GET /upload_form
  def upload_form
    render :partial => 'upload_form'
  end

  # GET /cheese_chooser
  def cheese_chooser
    @worker = Worker.find(params[:id])
    @image_path = @worker.image_path
    render :partial => 'cheese_chooser'
  end

  # POST /upload
  def upload_image
    @avatar = Avatar.new(params[:avatar])
    if @avatar.save
      render :partial => 'upload_image'
    else
      render :partial => 'upload_form'
    end
  end

  # GET /image_chooser
  def image_chooser
    @worker = Worker.find(params[:id])
    @image_path = @worker.image_url
    render :partial => 'image_chooser'
  end

  # POST /workers
  # POST /workers.json
  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
        format.json { render action: 'show', status: :created, location: @worker }
      else
        format.html { render action: 'new' }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url }
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
      params.require(:worker).permit(:name, :image, :in_shop, :email, :phone, :status_id, :work_status_id, :public_email)
    end
end
