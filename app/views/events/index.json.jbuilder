json.array!(@events) do |event|
  json.extract! event, :id, :name, :first_at, :last_at, :wday, :s_hr, :s_min, :e_hr, :e_min
  json.url event_url(event, format: :json)
end
