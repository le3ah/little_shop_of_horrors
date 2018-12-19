Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  resources :users, only: [:create, :update]

  namespace :admin do 
    resources :merchants, only: [:index, :show]
    post '/toggle', to: "merchants#toggle_status"
  end

  get '/register', to: 'users#new'
  get '/profile', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'merchants#show'


  get '/cart', to: 'carts#index'
end
