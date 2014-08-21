json.array!(@events) do |event|
  json.extract! event, *Event::API_ATTRIBUTES
  json.url api_v1_event_url(event, format: :json)
end

