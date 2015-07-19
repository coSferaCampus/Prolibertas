Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root to: "main#main"

  resources :users

  resources :people do
    resources :alerts, only: [:index, :create]
    resources :histories, only: [:index, :create]
    resources :articles, only: [:index, :create]
    resources :attachments, only: [:index, :create]
  end

  resources :families
  resources :services
  resources :used_services
  resources :alerts, only: [:show, :update, :destroy]
  resources :histories, only: [:show, :update, :destroy]
  resources :articles, only: [:show, :update, :destroy]
  resources :sandwiches, only: [:show, :create]
  resources :attachments, only: [:show, :update, :destroy]

  get '/current' => 'users#current'

  get '/people/:id/individual_report' => 'people#individual_report'

  get '/reports/genre' => 'reports#genre'
  get '/reports/spanish' => 'reports#spanish'
  get '/reports/documentation' => 'reports#documentation'
  get '/reports/assistance' => 'reports#assistance'
  get '/reports/residence' => 'reports#residence'
  get '/reports/origin' => 'reports#origin'
  get '/reports/city' => 'reports#city'
end
