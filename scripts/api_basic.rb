require 'faraday'
require 'faraday_middleware'
require 'json'

class ApiBasic
  URL = 'http://localhost:3000/api/v1'

  def initialize(url = URL)
    @base_url = url
    api_connection
  end

  def api_connection
    @conn = Faraday.new(url: @base_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :json
      faraday.adapter :net_http #Faraday.default_adapter
    end
    @conn.basic_auth('admin', 'password')
  end

  def api_get_worker(email)
    response = @conn.get 'workers/email', { value: email }
    workers = response.body

    if 1 == workers.count
      worker = workers.first
      worker_id = worker['id']
      return worker_id
    end
  end

  def sign_in(worker_id)
    response = @conn.post "workers/#{worker_id}/sign_in"
    return response.body
  end

  def sign_out(worker_id)
    response = @conn.post "workers/#{worker_id}/sign_out"
    return response.body
  end

end
