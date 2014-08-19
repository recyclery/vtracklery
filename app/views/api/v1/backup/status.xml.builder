xml.instruct!
xml.status do
  xml << render(partial: 'api/v1/backup/status.xml',
                locals: { status: @status })
end # xml.status
