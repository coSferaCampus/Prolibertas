Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root to: "main#main"
  resources :users
  resources :people do
    resources :alerts, only: [:index, :create]
    resources :histories, only: [:index, :create]
    resources :articles, only: [:index, :create]
  end
  resources :families
  resources :services
  resources :used_services
  resources :alerts, only: [:show, :update, :destroy]
  resources :histories, only: [:show, :update, :destroy]
  resources :articles, only: [:show, :update, :destroy]
  resources :sandwiches, only: [:show, :create]

  get '/current' => 'users#current'

  get '/people/:id/individual_report' => 'people#individual_report'
end
