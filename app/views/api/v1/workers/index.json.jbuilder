json.array!(@workers) do |worker|
  json.extract! worker, *Worker::API_ATTRIBUTES
  json.url api_v1_worker_url(worker, format: :json)
end

