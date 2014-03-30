Ecobox::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  
  match "/sensors/list" => "sensors#list", via: :get
  match "/sensors/:id/sensor_data" => "sensors#sensor_data", via: [:get, :post]
  match "/sensors/:id/active_sensor" => "sensors#active_sensor", via: :post
  match "/sensors/:id/blacklist" => "sensors#blacklist_sensor", via: :get, :as => "blacklist"
  resources :sensors
  resources :actuators

  resources :users
  match '/signup',  to: 'users#new',     	via: :get
  match '/signin',  to: 'sessions#new',     via: :get
  match '/signout', to: 'sessions#destroy',	via: :delete

  match '/home',  to: 'home#index',     via: :get
  root 'home#index' 

end
