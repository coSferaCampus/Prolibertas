Rails.application.routes.draw do
  root to: "main#main"
  resources :people
  devise_for :users, controllers: {sessions: 'sessions'}
  
end
