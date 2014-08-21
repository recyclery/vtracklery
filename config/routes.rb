require 'api_constraints'

Rails.application.routes.draw do

  concern :api_v1 do
    scope :backup, controller: 'backup' do
      get :surveys
      get :events
      get :workers
      get :work_times
      get :work_statuses
      get :statuses
    end

    resources :surveys
    resources :events
    resources :workers
    resources :work_times

    # Not sure if I should keep these
    resources :work_statuses
    resources :statuses

    scope :report, controller: 'report' do
      get :active
      get :logged_in
      get :month
      get :volunteer
      get :week
      get :year
    end
  end

  namespace :api, defaults: {format: 'json'} do
    scope( :module => :v1,
           constraints: ApiConstraints.new(version: 1, default: true) ) do
      concerns :api_v1
    end
    namespace :v1 do
      concerns :api_v1
    end
  end

  resources :surveys

  get 'report', as: 'reports', to: 'report#index'
  scope '/report', controller: 'report' do
    get 'active', as: 'active_workers'
    get 'admin'
    get 'calendar/:year/:month', as: 'calendar', to: 'report#calendar'
    get 'calendar', as: 'current_month_calendar', to: 'report#calendar'
    get 'contact', as: 'contact_list'
    get 'event/:id', as: 'event_report', to: 'report#event'
    get 'month/:year/:month', as: 'month_report', to: 'report#month'
    get 'month/:year', as: 'year_month_report', to: 'report#month'
    get 'month', as: 'current_month_report', to: 'report#month'
    get 'monthly'
    get 'volunteer/:id', as: 'worker_report', to: 'report#volunteer'
    get 'week/:year/:month/:day', as: 'day_week_report', to: 'report#week'
    get 'week/:year/:month', as: 'month_week_report', to: 'report#week'
    get 'week/:year', as: 'year_week_report', to: 'report#week'
    get 'week', as: 'week_report', to: 'report#week'
    get 'weekly'
    get 'year'
    get 'yearly'
  end

  root 'shop#index'

  get 'shop', as: 'shop', to: 'shop#index'
  scope '/shop', controller: 'shop' do
    get 'directions'
    get 'sign_in'
    get 'sign_out'
  end

  resources :workers do 
    collection do
      post 'upload_image', to: 'workers#upload_image', as: 'worker_upload_image'
      get 'upload_form', to: 'workers#upload_form', as: 'upload_form'
    end
    member do
      get 'image_chooser'
      get 'cheese_chooser'
    end
  end

  scope "/export", controller: "export" do
    get 'phone'
    get 'email'
    get 'no_contact'
    get 'contact'
    get 'mailchimp'
    get 'worker_hours/:id', as: "worker_hours", to: "export#worker_hours"
    get 'month/:year/:month', as: "month_csv", to: "export#month"
    get 'year'
  end

  resources :events
  resources :work_times

  # Not sure if I should keep these
  resources :work_statuses
  resources :statuses

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
