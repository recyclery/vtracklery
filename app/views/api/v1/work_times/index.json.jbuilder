json.array!(@work_times) do |work_time|
  json.extract! work_time, *WorkTime::API_ATTRIBUTES
  json.url api_v1_work_time_url(work_time, format: :json)
end

API_ATTRIBUTES = [ :start_at, :end_at, :created_at, :updated_at ]

