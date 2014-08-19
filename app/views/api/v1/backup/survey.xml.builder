xml.instruct!
xml.survey do
  xml << render(partial: 'api/v1/backup/survey.xml',
                locals: { survey: @survey })
end # xml.survey
