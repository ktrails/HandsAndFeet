HandsAndFeet::Application.routes.draw do

  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  get "sign_up" => "users#new",:as => "sign_up"

  root :to => "sessions#new"

  resources :posts
  resources :sessions
  resources :users
end
