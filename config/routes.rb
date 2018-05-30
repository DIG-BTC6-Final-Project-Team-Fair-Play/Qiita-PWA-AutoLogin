Rails.application.routes.draw do
  
  ##
  # root
  root 'users#index'
  
  # users
  resources :users
  match '/signup', to: 'users#new', via: 'get'
  
  ##
  # sessions
  resource :sessions, only: [:new, :create, :destroy]
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
  
  ##
  # authentication
  post '/authentication', to: 'authentication#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
