xml.instruct!
xml.work_time do
  xml << render(partial: 'api/v1/backup/work_time.xml',
                locals: { work_time: @work_time })
end # xml.work_time
