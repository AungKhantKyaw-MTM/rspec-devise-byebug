Rails.application.routes.draw do
  devise_for :users
  resources :posts
  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
