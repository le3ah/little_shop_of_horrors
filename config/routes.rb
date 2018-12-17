Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index]
  resources :merchants, only: [:index]
  resources :users, only: [:index, :create]

  get '/register', to: 'users#new'
  get '/profile', to: 'users#show'
end
