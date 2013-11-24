Vtrack::Application.routes.draw do

  get "report/active"
  get "report/admin"
  get "report/calendar"
  get "report/contact"
  get "report/event"
  get "report/index"
  get "report/month"
  get "report/monthly"
  get "report/volunteer"
  get "report/week"
  get "report/weekly"
  get "report/year"
  get "report/yearly"
  root 'shop#index'

  get "shop/index"
  get "shop/directions"
  get "shop/sign_in"
  get "shop/sign_out"

  resources :workers do
    collection do
      get 'upload_image', to: 'upload_image', as: 'worker_upload_image'
      get 'upload_form', to: 'upload_form', as: 'upload_form'
      get 'image_chooser'
      get 'cheese_chooser'
    end
  end
  resources :work_times
  resources :events

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
