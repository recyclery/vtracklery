class DumpController < ApplicationController

  # Dump work_times table to csv
  def work_times
    @work_times = WorkTime.all
    send_csv(@work_times, "work_times_dump.csv") do |h|
      [h.id, h.start_at, h.end_at, h.worker_id, h.status_id, h.work_status_id, h.created_at, h.updated_at]
    end
  end

end
