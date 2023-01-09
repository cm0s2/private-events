Rails.application.routes.draw do
  devise_for :users

  

  get '/events', to: "events#index"
  resources :users, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "events#index"
end