module LinktoHelper
  def link_to_worker(worker, options = {})
    link_to(worker.name, worker) if worker
  end

  def link_to_survey(worker, options = {})
    #link_to(worker.name, worker) if worker
    if worker && worker.survey
      link_to("Profile", edit_survey_path(worker.survey))
    else
      link_to("Create Profile", new_survey_path(worker_id: worker.id))
    end
  end
end
