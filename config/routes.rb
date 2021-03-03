Rails.application.routes.draw do
  root "home#index"
  get "/" => "home#index"
  get "/signin" => "sessions#new" , as: :new_sessions
  post "/signin" => "sessions#create" , as: :sessions
  delete "/signout" => "sessions#destroy" , as: :destroy_session
  resources :users
  resources :todos
  #get "todos", to: "todos#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
