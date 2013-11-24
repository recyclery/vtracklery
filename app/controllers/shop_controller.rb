class ShopController < ApplicationController
  def index
    @max_top = 280
    @max_left = 500
    @logo = logo_exists? ? logo_url : Settings.logo.default_url

    @workers = Worker.find(:all)

    v_people = []
    @v_col1 = []
    @v_col2 = []
    @shop_people = []
    @workers.each do |person|
      if person.in_shop?
        @shop_people.push person
      else
        v_people.push person
      end

      if params[:search].nil? || params[:search] == ""
        v_people.sort! { |v1,v2| 
          v1.updated_at <=> v2.updated_at
        }
        v_people.reverse!
        @v_col1 = v_people[0..2]
        @v_col2 = v_people[3..5]
      else
        found = []
        # DEK Putting the unescaped search parameter here is a really bad idea.
        v_people.each { |v| found.push v if v.name.downcase =~ /#{params[:search].downcase}/ }
        @v_col1 = found
      end
    end
  end

  def sign_in
    @person = Worker.find(params[:person])
    @time = WorkTime.new()
    cur_top = params[:left].to_i # "-34px".to_i => -34
    cur_left = params[:top].to_i # "422px".to_i => 422
    img_order = params[:order]

    @person.updated_at = Time.now # To help sort by recently in shop

    @time.worker = @person
    @time.start_at = Time.now

    @start = @time.start_time
    @person.in_shop = true

    if @person.save and @time.save
      respond_to do |format|
        format.html { render :partial => "sign_in" }
        #render @person.to_xml
      end
    end
  end

  def sign_out
    @person = Worker.find(params[:person])
    @time = @person.work_times.last

    @person.updated_at = Time.now  # To help sort by recently in shop

    @time.end_at = Time.now
    @end = @time.end_at.strftime("%I:%M%p")
    seconds = (@time.end_at - @time.start_at)
    minutes = (seconds / 60).to_i
    hours = (minutes / 60).to_i

    case minutes
    when 0
      @difference = "less than a minute.  Oops?"
    when 1
      @difference = "barely a minute.  Cumon!  Don't waste my time."
    when 2..10
      @difference = "less than ten minutes.  That shouldn't count!"
    when 10..59
      @difference = "#{minutes} minutes."
    when 60..119
      @difference = "one hour and #{minutes % (hours * 60)} minutes."
    else
      @difference = "#{hours} hours and #{minutes % (hours * 60)} minutes."
    end
    # @minutes = "DIFFERENCE"
    @person.in_shop = false
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
