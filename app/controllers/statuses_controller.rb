#
# Status and WorkStatus should only #list and #show; they're connected to
# hard logic, and should only be changed by programmers at this point.
#
class StatusesController < ApplicationController
  before_action :set_status, only: [:show]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @workers = @status.workers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(Status::WEB_PARAMS)
    end

end
