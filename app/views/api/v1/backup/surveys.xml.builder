xml.instruct!
xml.surveys(type: :array) do
  @surveys.each do |survey|
    xml.survey do
      xml << render(partial: 'api/v1/backup/survey.xml',
                    locals: { survey: survey })
    end # xml.survey
  end
end # xml.surveys
