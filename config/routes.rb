Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root to: "main#main"
  resources :users
  resources :people
  resources :services
  resources :used_services
end
