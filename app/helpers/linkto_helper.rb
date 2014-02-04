module LinktoHelper
  def link_to_worker(worker, options = {})
    link_to(worker.name, worker) if worker
  end
end
