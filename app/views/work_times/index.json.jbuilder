json.array!(@work_times) do |work_time|
  json.extract! work_time, :start_at, :end_at, :worker_id, :status_id, :work_status_id
  json.url work_time_url(work_time, format: :json)
end
