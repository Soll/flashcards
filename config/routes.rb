Rails.application.routes.draw do
  get "oauths/oauth"
  get "oauths/callback"
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root "home#index"
  post "check_translation" => "home#check_translation"
  get "login" => "user_sessions#new", :as => :login
  post "login", to: "user_sessions#create"
  post "logout" => "user_sessions#destroy", :as => :logout
  resources :cards, :users, :user_sessions
end
