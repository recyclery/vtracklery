Dir.glob("#{Rails.root.to_s}/config/routes/**/*.rb").each {|route_file| load(route_file)}

Rails.application.routes.draw do
  Routes::ApiRoutes.draw(self)

  root 'shop#index'

  get 'shop', as: 'shop', to: 'shop#index'
  scope '/shop', controller: 'shop' do
    get :directions
    post :sign_in
    post :sign_out

    get    "time/:id", as: 'edit_shop_time',   to: 'shop#edit'
    patch  "time/:id", as: 'update_shop_time', to: 'shop#update'
    delete "time/:id", as: 'delete_shop_time', to: 'shop#destroy'
  end

  get 'report', as: 'reports', to: 'report#index'
  scope '/report', controller: 'report' do
    get 'admin'
    get 'admin_month', as: 'fix_month_hours'
    get 'calendar/:year/:month', as: 'calendar', to: 'report#calendar'
    get 'calendar', as: 'current_month_calendar', to: 'report#calendar'
    get 'contact', as: 'contact_list'
    get 'event/:id', as: 'event_report', to: 'report#event'
    get 'month/:year/:month', as: 'month_report', to: 'report#month'
    get 'month/:year/:month/totals', as: 'month_totals_report', to: 'report#month_totals'
    get 'month/:year', as: 'year_month_report', to: 'report#month'
    get 'month', as: 'current_month_report', to: 'report#month'
    get 'monthly'
    get 'regular', as: 'regular_workers'
    get 'volunteer/:id', as: 'worker_report', to: 'report#volunteer'
    get 'week/:year/:month/:day', as: 'day_week_report', to: 'report#week'
    get 'week/:year/:month', as: 'month_week_report', to: 'report#week'
    get 'week/:year', as: 'year_week_report', to: 'report#week'
    get 'week', as: 'week_report', to: 'report#week'
    get 'weekly'
    get 'year/:year/hoursm', as: 'member_hours_year_report', to: 'report#year_hoursm'
    get 'year/:year/hourss', as: 'staff_hours_year_report', to: 'report#year_hourss'
    get 'year/:year/hoursv', as: 'volunteer_hours_year_report', to: 'report#year_hoursv'
    get 'year/:year/hoursy', as: 'youth_hours_year_report', to: 'report#year_hoursy'
    get 'year/:year/newv', as: 'new_volunteers_year_report', to: 'report#year_newv'
    get 'year/:year', as: 'year_report', to: 'report#year'
    get 'year'
    get 'yearly'
  end

  resources :workers do
    resources :surveys
    resources :youth_point_purchases, only: [:new, :create]
    collection do
      get :member
      get :staff
      get :volunteer
      get :youth
      post 'upload_image', to: 'workers#upload_image', as: 'worker_upload_image'
      get 'upload_form', to: 'workers#upload_form', as: 'upload_form'
    end
    member do
      get :status
      get :image_chooser
      get :cheese_chooser
      put :sign_in
      put :sign_out
      put 'update_status/:status_id', action: :update_status, as: :update_status
      delete :destroy_and_redirect
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
    get 'month/:year/:month/totals', as: "month_totals_csv", to: "export#month_totals"
    get 'year'
  end

  resources :work_times
  resources :events

  resources :statuses, only: [:index, :show]

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
