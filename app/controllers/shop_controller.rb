class ShopController < ApplicationController
  before_action :set_work_time, only: [:edit, :update, :destroy]

  # GET /
  # GET /shop
  def index
    @max_top = 280
    @max_left = 500
    @logo = logo_exists? ? logo_url : Settings.logo.default_url

    @workers = Worker.all
    @shop_people = Worker.clocked_in

    if params[:search].nil? || params[:search] == ""
      v_people = Worker.clocked_out.limit(6)
      @v_col1 = v_people[0..2]
      @v_col2 = v_people[3..5]
    else
      v_people = Worker.clocked_out
      found = []
      # DEK Putting the unescaped search parameter here is a really bad idea.
      v_people.each { |v| found.push v if v.name.downcase =~ /#{params[:search].downcase}/ }
      @v_col1 = found
    end
  end

  # PATCH/PUT /shop/sign_in
  # PATCH/PUT /shop/sign_in.json
  def sign_in
    cur_top = params[:left].to_i # "-34px".to_i => -34
    cur_left = params[:top].to_i # "422px".to_i => 422
    img_order = params[:order]

    @worker = Worker.find(params[:id])
    @work_time = @worker.clock_in()
    @start = @work_time.start_time

    if @worker.save && @work_time.save
      respond_to do |format|
        format.html { render :partial => "sign_in" }
        #render @worker.to_xml
      end
    end
  end

  # PATCH/PUT /shop/sign_out
  # PATCH/PUT /shop/sign_out.json
  def sign_out
    @worker = Worker.find(params[:id])
    @work_time = @worker.clock_out
    @end = @work_time.end_at.strftime("%I:%M%p")
    @message = @work_time.punch_message()

    if @worker.save and @work_time.save
      respond_to do |format|
        format.html { render :partial => "sign_out" }
      end
    end
  end

  # GET /shop/directions
  def directions
  end

  # GET /shop/time/1
  def edit
  end

  # PATCH/PUT /shop/time/1
  # PATCH/PUT /shop/time/1.json
  def update
    respond_to do |format|
      if @work_time.update(work_time_params)
        format.html { redirect_to root_path, notice: "#{@worker.name} #{@worker.status_name.downcase} record changed: in the shop from #{@work_time.start_time_to_s}-#{@work_time.end_time_to_s} (#{@work_time.difference_to_s})." }
        format.json { render :show, status: :ok, location: @work_time }
      else
        format.html { render :edit_shop_time }
        format.json { render json: @work_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/time/1
  # DELETE /shop/time/1.json
  def destroy
    start_time = @work_time.start_time_to_s
    end_time   = @work_time.end_time_to_s
    difference = @work_time.difference_to_s

    @work_time.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: "#{@worker.name} #{@worker.status_name.downcase} record changed: deleted work time #{start_time}-#{end_time} (#{difference})." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_time
      @worker = Worker.find(params[:id])
      @work_time = @worker.work_times.last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_time_params
      params.require(:work_time).permit(:start_at, :end_at, :worker_id)
    end

    def logo_path
      Dir.glob(File.join(Settings.logo.default_dir.split("/"),
                         Settings.logo.filename)).first
    end

    def logo_url
      if logo_path.nil? then Settings.logo.default_url
      else "/assets/#{Settings.logo.filename}"
      end
    end

    def logo_exists?
      if logo_path.nil? then return nil
      else return File.exist?(logo_path)
      end
    end
end
