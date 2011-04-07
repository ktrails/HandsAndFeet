HandsAndFeet::Application.routes.draw do

  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  get "sign_up" => "users#new",:as => "sign_up"

  root :to => "posts#index"

  resources :messages
  resources :posts do
    resources :comments
  end
  resources :sessions
  resources :users
end
