xml.instruct!
xml.worker do
  xml << render(partial: 'api/v1/backup/worker.xml',
                locals: { worker: @worker })
end # xml.worker
