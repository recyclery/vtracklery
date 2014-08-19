xml.instruct!
xml.work_status do
  xml << render(partial: 'api/v1/backup/work_status.xml',
                locals: { work_status: @work_status })
end # xml.work_status
