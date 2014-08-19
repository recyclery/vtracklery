json.array!(@workers) do |worker|
  json.extract! worker, :id, :name, :image, :in_shop, :email, :phone, :status_id, :work_status_id, :public_email
  json.url worker_url(worker, format: :json)
end
