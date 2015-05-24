Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root to: "main#main"
  resources :users
  resources :people do
    resources :alerts, only: [:index, :create]
    resources :histories, only: [:index, :create]
  end
  resources :families
  resources :services
  resources :used_services
  resources :alerts, only: [:show, :update, :destroy]
  resources :histories, only: [:show, :update, :destroy]

  get '/current' => 'users#current'
end
