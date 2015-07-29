Rails.application.routes.draw do
  root "home#index"
  post "check_translation" => "home#check_translation"
  resources :cards
end
