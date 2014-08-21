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

    @person = Worker.find(params[:person])
    @time = @person.clock_in()
    @start = @time.start_time

    if @person.save && @time.save
      respond_to do |format|
        format.html { render :partial => "sign_in" }
        #render @person.to_xml
      end
    end
  end

  def sign_out
    @person = Worker.find(params[:person])
    @time = @person.clock_out
    @end = @time.end_at.strftime("%I:%M%p")
    @difference = @time.punch_message()

    if @person.save and @time.save
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
