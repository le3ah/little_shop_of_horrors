Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  resources :users, only: [:create, :update]

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :users, only: [:index, :show]
    get '/profile', to: 'admin_users#show'
    post '/toggle', to: "merchants#toggle_status"
    post '/toggle-user', to: "users#toggle_user"
  end

  namespace :profile do
    resources :orders, only: [:index, :show]
  end

  namespace :merchants do
    get '/dashboard', to: 'merchants#show'
    get '/dashboard/items', to: 'merchant_items#index'
  end
  # scope module: :merchant, path: :dashboard, as: :merchant do
  #   resources :items, only: [:index]
  # end

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'

  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'



  get '/cart', to: 'cart_items#index'
  post '/cart_items', to: 'cart_items#create'
end
