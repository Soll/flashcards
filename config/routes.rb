Rails.application.routes.draw do
  root "home#index"
  post "check_translation" => "home#check_translation"
  #get "login" => "users#login"
  get 'login' => 'user_sessions#new', :as => :login
  post 'login', to: 'user_sessions#create'
  post 'logout' => 'user_sessions#destroy', :as => :logout
  resources :cards, :users, :user_sessions
end
