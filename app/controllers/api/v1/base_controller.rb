class Api::V1::BaseController < ApplicationController
  http_basic_authenticate_with(name: Settings.api.login,
                               password: Settings.api.password)
  skip_before_filter :verify_authenticity_token
end
