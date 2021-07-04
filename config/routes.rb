Rails.application.routes.draw do
  get 'gallery/index'
  get 'gallery/checkout'
  post 'gallery/checkout'
  get 'gallery/purchase_complete'
  get 'gallery/search'
  post 'gallery/search'
  resources :orders
  resources :line_items
  resources :carts
  get 'admin/login'
  resources :stores
  devise_for :users
  get 'home/index'
  root to: 'home#index'
  post 'admin/login'
  get 'admin/logout'
  get '/users/sign_out'
  post '/users/sign_out'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
