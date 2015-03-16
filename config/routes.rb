Rails.application.routes.draw do
  root to: "main#main"

  devise_for :users, controllers: {sessions: 'sessions'}
  
end
