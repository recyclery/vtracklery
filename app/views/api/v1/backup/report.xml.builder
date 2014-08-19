xml.instruct!
xml.report do
  xml << render(partial: 'api/v1/backup/report.xml',
                locals: { report: @report })
end # xml.report
