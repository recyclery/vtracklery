json.array!(@surveys) do |survey|
  json.extract! survey, *Survey::API_ATTRIBUTES
  json.url api_v1_survey_url(survey, format: :json)
end

