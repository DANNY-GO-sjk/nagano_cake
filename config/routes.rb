Rails.application.routes.draw do
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  }
  patch 'users/edit', to: 'users#update'

  get 'home' => 'home#index', as: 'home'

  get 'about' => 'home#about', as: 'about'

  resource :users, only: [:show, :edit]
  get 'users/edit_info' => 'users#edit_info'
  get 'users/edit_withdraw' => 'users#edit_withdraw', as: 'edit_user_withdraw'
  put 'users/withdraw' => 'users#withdraw', as: 'user_withdraw'

  resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]

  delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
  resources :cart_items, only: [:index, :create, :update, :destroy]

  get 'orders/confirm' => 'orders#new'
  post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
  post 'orders/back' => 'orders#back', as: 'order_back'
  resources :orders, only: [:index, :new, :create, :show]

  resources :items, only: [:index, :show]

  get 'genre/:id' => 'genres#search', as: 'genres_search'
  namespace :admins do
    resources :items, except: :destroy
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: :update
    get '/home' => 'home#index', as: 'home'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
