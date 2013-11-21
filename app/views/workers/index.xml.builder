xml.instruct!
xml.workers(type: :array) do
  @workers.each do |worker|
    xml.worker do
      xml << render(partial: 'workers/worker', locals: {worker: worker})
    end # xml.worker
  end
end # xml.workers
