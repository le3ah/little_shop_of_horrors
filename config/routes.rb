Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  resources :users, only: [:create, :update]
  resources :cart_items, only: [:create, :update]
  resources :orders, only: [:create]

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :users, only: [:index, :show, :edit]
    resources :orders, only: [:destroy, :show]
    post '/toggle', to: "merchants#toggle_status"
    post '/toggle-user', to: "users#toggle_user"
    post '/toggle-role', to: "merchants#toggle_role"
  end

  namespace :profile do
    resources :orders, only: [:index, :show, :destroy]
  end

  namespace :dashboard do
    resources :orders, only: [:show]
    resources :items, only: [:index, :show, :new, :create, :update, :destroy]
  end

  get '/dashboard', to: 'merchants#show'
  
  delete '/dashboard/items', to: 'merchants#destroy', as: 'delete_item'
  get '/dashboard/items/update', to: 'merchants#edit', as: 'edit_item'
  patch '/items', to: 'merchants#update'
  post '/toggle-item', to: 'merchants#toggle_item', as: 'toggle_item'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'

  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/cart', to: 'cart_items#index'
  delete '/cart_items', to: 'cart_items#destroy'
end
