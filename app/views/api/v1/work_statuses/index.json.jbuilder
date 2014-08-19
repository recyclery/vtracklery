json.array!(@work_statuses) do |work_status|
  json.extract! work_status, *WorkStatus::API_ATTRIBUTES
  json.url api_v1_work_status_url(work_status, format: :json)
end

API_ATTRIBUTES = [ :name, :created_at, :updated_at ]

