class ShopController < ApplicationController
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

  def sign_in
    cur_top = params[:left].to_i # "-34px".to_i => -34
    cur_left = params[:top].to_i # "422px".to_i => 422
    img_order = params[:order]

    @worker = Worker.find(params[:worker])
    @work_time = @worker.clock_in()
    @start = @work_time.start_time

    if @worker.save && @work_time.save
      respond_to do |format|
        format.html { render :partial => "sign_in" }
        #render @worker.to_xml
      end
    end
  end

  def sign_out
    @worker = Worker.find(params[:worker])
    @work_time = @worker.clock_out
    @end = @work_time.end_at.strftime("%I:%M%p")
    @message = @work_time.punch_message()

    if @worker.save and @work_time.save
      respond_to do |format|
        format.html { render :partial => "sign_out" }
      end
    end
  end

  def directions

  end

  private
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
