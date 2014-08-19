xml.instruct!
xml.workers(type: :array) do
  @workers.each do |worker|
    xml.worker do
      xml << render(partial: 'api/v1/backup/worker.xml',
                    locals: { worker: worker })
    end # xml.worker
  end
end # xml.workers
