Rails.application.routes.draw do
  root 'home#index'
  get 'home/index', to: 'home#index'
  resources :movements, except: [:index, :show]
  resources :groups
  devise_for :users

  get 'movement_create_new/:group_id', to: 'movements#new_movement', as: 'movement_create_new'
  post 'movement_create_new/:group_id', to: 'movements#create_movement', as: 'movement_create_new_post'
end
