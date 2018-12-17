Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index]
  resources :merchants, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/register', to: 'sessions#new'
  post '/register', to: 'sessions#create'

  get '/cart', to: 'carts#index'
end
