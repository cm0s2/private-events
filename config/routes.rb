Rails.application.routes.draw do
  devise_for :users

  

  # get '/events', to: "events#index"
  resources :users, only: [:show]
  resources :events
  resources :event_users, only: [:create, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "events#index"
end
