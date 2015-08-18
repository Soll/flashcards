Rails.application.routes.draw do
  get "oauths/oauth"
  get "oauths/callback"
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root "home#index"
  post "cards/:id" => "cards#set_review_date_to_now"

  get "get_active_category" => "categories#get_active_category"
  post "change_current_category" => "categories#change_current_category"
  get "set_no_active_categories" => "categories#set_no_active_categories"
  get "send_letters" => "home#send_letters"

  post "check_translation" => "home#check_translation"
  get "login" => "user_sessions#new", :as => :login
  post "login", to: "user_sessions#create"
  post "logout" => "user_sessions#destroy", :as => :logout
  resources :cards, :users, :user_sessions, :categories
end
