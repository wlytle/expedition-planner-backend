Rails.application.routes.draw do
  resources :locations
  resources :legs
  resources :user_trips
  resources :trips
  resources :users
  post "/login", to: "auth#login"
  patch "/legs/meta/:id", to: "legs#update_meta"
  get "/collabs", to: "users#collabs"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
