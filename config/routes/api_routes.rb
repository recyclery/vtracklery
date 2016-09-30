require 'api_constraints'
module Routes
  module ApiRoutes

    def self.draw(context)
      context.instance_eval do

        concern :api_v1 do
          scope :backup, controller: 'backup' do
            get :surveys
            get :events
            get :workers
            get :work_times
            get :work_statuses
            get :statuses
          end

          resources :workers do
            collection do
              get :shop
              get :active
              get :missing
              get :email
              get :where
            end
            member do
              post :sign_in
              post :sign_out
            end
          end

          resources :work_times do
            collection do
              get :logged_in
              get :too_long
              get :mismatched_dates

              get :week
              get :month
              get :year
            end
          end

          resources :surveys
          resources :events

        end

        namespace :api, defaults: {format: 'json'} do
          scope(:module => :v1,
                constraints: ApiConstraints.new(version: 1, default: true)) do
            concerns :api_v1
          end
          namespace :v1 do
            concerns :api_v1
          end
        end

      end
    end
  end
end
