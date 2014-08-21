json.array!(@statuses) do |status|
  json.extract! status, *Status::API_ATTRIBUTES
  json.url api_v1_status_url(status, format: :json)
end


