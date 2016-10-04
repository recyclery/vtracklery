require 'faraday'
require 'faraday_middleware'
require 'json'

# Sample script for logging in through the API with an email address
#
#    #!/usr/bin/env ruby
#    require_relative 'api_basic'
#    email = ARGV[0] || "example@example.com"
#    vtrack = ApiBasic.new('http://vtrack.domain')
#    worker_id = vtrack.api_get_worker(email)
#    vtrack.sign_in(worker_id)
#
class ApiBasic
  URL = 'http://localhost:3000'

  # @param url [String] The base domain for the Api
  def initialize(url = URL)
    @base_url = "#{url}/api/v1"
    api_connection
  end

  # @return [Faraday::Connection]
  def api_connection
    @conn = Faraday.new(url: @base_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :json
      faraday.adapter :net_http #Faraday.default_adapter
    end
    @conn.basic_auth('admin', 'password')
  end

  # @param email [String] the email for the worker
  # @return [Integer] the worker's database id
  def api_get_worker(email)
    response = @conn.get 'workers/email', { value: email }
    workers = response.body

    if 1 == workers.count
      worker = workers.first
      worker_id = worker['id']
      return worker_id
    end
  end

  # @param worker_id [Integer] the worker's database id
  # @param e [Integer] the unix time (epoch) the worker clocked in
  # @return [Hash]
  def sign_in(worker_id, e = nil)
    if e.nil? then response = @conn.post "workers/#{worker_id}/sign_in"
    else response = @conn.post("workers/#{worker_id}/sign_in", { epoch: e })
    end

    return response.body
  end

  # @param worker_id [Integer] the worker's database id
  # @param epoch [Integer] the unix time (epoch) the worker clocked out
  # @return [Hash]
  def sign_out(worker_id, e = nil)
    if e.nil? then response = @conn.post "workers/#{worker_id}/sign_out"
    else response = @conn.post("workers/#{worker_id}/sign_out", { epoch: e })
    end

    return response.body
  end

end
