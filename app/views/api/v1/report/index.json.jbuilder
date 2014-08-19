json.array!(@report) do |report|
  json.extract! report, *Report::API_ATTRIBUTES
  json.url api_v1_report_url(report, format: :json)
end

API_ATTRIBUTES = [  ]

