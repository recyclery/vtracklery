class Api::V1::ReportController < Api::V1::BaseController
  include ReportHelper

  # The days from the previous week (Mon..Sun) for the given day
  #
  # GET /report/weekof/2016/10/21
  def weekof
    now = Time.now
    if params[:year].nil? and params[:day].nil? and params[:month].nil?
      @year, @month, @day = now.year, now.month, now.day
    else
      @year, @month, @day =
                     params[:year].to_i, params[:month].to_i, params[:day].to_i
    end

    @date = Date.new(@year, @month, @day)
    if 0 == @date.wday # If Sunday, return the recent week including now
      beg = beginning_of_week(@date, 1)
      ending = end_of_week(@date, 1)
    else # Return the begin and end dates for the last week
      beg = beginning_of_week(@date - 7, 1)
      ending = end_of_week(@date - 7, 1)
    end

    hash = {beg: beg, ending: ending}
    respond_to do |format|
      format.json { render json: hash }
    end
  end

  # Hours for the given day
  #
  # GET /report/hours/2016/10/21
  def day_hours
    now = Time.now
    if params[:year].nil? and params[:day].nil? and params[:month].nil?
      @year, @month, @day = now.year, now.month, now.day
    else
      @year, @month, @day =
                     params[:year].to_i, params[:month].to_i, params[:day].to_i
    end
    @date = Date.new(@year, @month, @day)
    beg = @date.beginning_of_day
    ending = @date.end_of_day
    @hours = WorkTime.where(start_at: beg..ending)

    hash = {year: @year, month: @month, day: @day, beginning: beg, ending: ending, hours: @hours}
    respond_to do |format|
      format.json { render json: hash }
    end
  end

  # All the workers that appeared on a given day
  #
  # GET /report/workers/2016/10/21
  def day_workers
    now = Time.now
    if params[:year].nil? and params[:day].nil? and params[:month].nil?
      @year, @month, @day = now.year, now.month, now.day
    else
      @year, @month, @day =
                     params[:year].to_i, params[:month].to_i, params[:day].to_i
    end
    @date = Date.new(@year, @month, @day)
    beg = @date.beginning_of_day
    ending = @date.end_of_day
    @worker_ids = WorkTime.where(start_at: beg..ending).pluck(:worker_id)
    @workers = Worker.where(id: @worker_ids)

    hash = {year: @year, month: @month, day: @day, beginning: beg, ending: ending, workers: @workers}
    respond_to do |format|
      format.json { render json: hash }
    end
  end

  # The Volunteers who came in Mon-Sunday from last week
  def lastweek
    now = Time.now
    if params[:year].nil? and params[:day].nil? and params[:month].nil?
      @year, @month, @day = now.year, now.month, now.day
    end
    @date = Date.civil(@year, @month, @day)
    beg = beginning_of_week(@date, 1)
    ending = end_of_week(@date, 1)
    @day_names = Date::DAYNAMES.dup
    @hours = WorkTime.between(beg, ending)

    respond_to do |format|
      format.json { render json: {range: [beg, ending]} }
    end
  end

end
