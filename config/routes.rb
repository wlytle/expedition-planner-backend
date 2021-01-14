Rails.application.routes.draw do
  resources :locations
  resources :legs
  resources :user_trips
  resources :trips
  resources :users
  post "/login", to: "auth#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
