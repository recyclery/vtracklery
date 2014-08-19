class Api::V1::BackupController < Api::V1::BaseController
  before_filter :set_content_type


  # GET /api/backup/statuses.json
  # GET /api/backup/statuses.xml
  def statuses
    @statuses = Status.all
  end

  # GET /api/backup/workers.json
  # GET /api/backup/workers.xml
  def workers
    @workers = Worker.all
  end

  # GET /api/backup/surveys.json
  # GET /api/backup/surveys.xml
  def surveys
    @surveys = Survey.all
  end

  # GET /api/backup/shop.json
  # GET /api/backup/shop.xml
  def shop
    @shop = Shop.all
  end

  # GET /api/backup/events.json
  # GET /api/backup/events.xml
  def events
    @events = Event.all
  end

  # GET /api/backup/work_times.json
  # GET /api/backup/work_times.xml
  def work_times
    @work_times = WorkTime.all
  end

  # GET /api/backup/work_statuses.json
  # GET /api/backup/work_statuses.xml
  def work_statuses
    @work_statuses = WorkStatus.all
  end

  # GET /api/backup/report.json
  # GET /api/backup/report.xml
  def report
    @report = Report.all
  end

  private
    # Important if using rabl xml builders
    def set_content_type
      respond_to do |format|
        format.json { response.headers["Content-Type"] = "application/json" }
        format.xml { response.headers["Content-Type"] = "application/xml" }
      end
    end

end
