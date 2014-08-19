json.array!(@workers) do |worker|
  json.extract! worker, *Worker::API_ATTRIBUTES
  json.url api_v1_worker_url(worker, format: :json)
end

API_ATTRIBUTES = [ :name, :image, :in_shop, :email, :phone, :public_email, :created_at, :updated_at ]

