Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root to: "main#main"
  resources :users
  resources :people do
  	resources :alerts, only: [:index, :create]
  end
  resources :services
  resources :used_services
  resources :alerts, only: [:show, :update, :destroy]
end
