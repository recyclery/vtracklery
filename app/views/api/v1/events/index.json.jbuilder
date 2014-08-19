json.array!(@events) do |event|
  json.extract! event, *Event::API_ATTRIBUTES
  json.url api_v1_event_url(event, format: :json)
end

API_ATTRIBUTES = [ :name, :first_at, :last_at, :wday, :s_hr, :s_min, :e_hr, :e_min, :created_at, :updated_at ]

