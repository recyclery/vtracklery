xml.instruct!
xml.worker do
  xml << render(partial: 'workers/worker', locals: {worker: @worker})
end # xml.worker
