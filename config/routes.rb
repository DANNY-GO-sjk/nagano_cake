Rails.application.routes.draw do
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end
  devise_for :users

  get 'home' => 'home#index', as: 'home'

  resource :users, only: :show
  get 'users/edit_withdraw' => 'users#edit_withdraw', as: 'edit_user_withdraw'
  put 'users' => 'users#withdraw', as: 'user_withdraw'

  resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]

  resources :cart_items, only: [:index, :create, :updeate, :destroy]
  get 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'

  resources :orders, only: [:index, :new, :create, :show]
  post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
  post 'orders/back' => 'orders#back', as: 'order_back'

  resources :items, only: [:index, :show]

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
