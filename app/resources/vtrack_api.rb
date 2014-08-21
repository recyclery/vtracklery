# /usr/lib/ruby/gems/1.9.1/gems/activeresource-4.0.0/lib/active_resource/base.rb
class VtrackApi < ActiveResource::Base
  self.site = Settings.api.site
  self.user = Settings.api.login
  self.password = Settings.api.password

  class << self
    def element_name
      @element_name ||= model_name.element[0..-10]
    end

    def model
      element_name.camelize.constantize
    end

  end # class << self

end
