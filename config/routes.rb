Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root 'static_pages#home'
  match '/home', to: 'static_pages#home', via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/testing', to: 'static_pages#testing', via: 'get'
  match '/change_role', to: 'static_pages#change_role', via: 'get'
  match '/no_page', to: 'static_pages#not_implemented', via: 'get'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'signup'  => 'users#new'
  get 'newtrip' => 'trips#new'
  get 'newCar' => 'carpools#new'
  get 'car' => 'trips#car'
  get 'edit_car' => 'carpools#edit'
  get 'off_waitlist' => 'trips#off_waitlist'
  get 'on_waitlist' => 'trips#on_waitlist'
  get 'role_change' => 'users#role_change'
  get 'edit_user_trip' => 'users_trips#edit'

  #for joining and leaving a car
  get 'car_join' => 'users_cars#create_destroy'

  #adds all resources needed for users
  resources :users

  #adds all resources needed for trips
  resources :trips

  #adds all resosources needed for carpools
  resources :carpools, only: [:new, :create, :destroy, :update, :edit]

  #adds all resources needed for usersTrips
  resources :users_trips,  only: [:create, :destroy, :edit, :update]

  #adds all resources needed for UsersCars
  resources :users_cars, only: [:create, :destroy, :create_destroy]

  #adds all resources for account activations
  resources :account_activations, only: [:edit]

  #adds all resources for password forgetting/remembering
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
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
